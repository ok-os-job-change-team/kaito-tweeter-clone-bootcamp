## 【備忘録】 Dockerを使ったRails開発環境構築
### Dockerfileを作成
- Rubyコンテナ用のDockerfileを作成
  ```dockerfile
  FROM ruby:3.2 # イメージを指定

  COPY Gemfile Gemfile.lock ./  #bundle installするためにホストマシンからファイルをコピー（コンテナを起動するまではファイルが共有されていない）

  RUN gem install rails # Railsジェムのをインストール

  RUN bundle install    # ジェムの依存関係を更新
  ```

### docker-compose.ymlファイルを作成
- Rubyのコンテナを作成する
- 動作確認はコンテナ起動後、ブラウザから`localhost:3000`にアクセスできること
  ```docker
  services:       # サービス名
    app:
      build:      # imageの代わりにDockerfileを読み込む
        context: .
        dockerfile: Dockerfile
      container_name: web_app #コンテナ名
      volumes:    # ファイルを共有する設定(ホストマシン:コンテナ)
        - .:/app
      ports:      # ホストのポート：コンテナのポート
        - "3000:3000"
      tty: true   # コンテナの起動時にttyを有効化する設定
      depends_on: # 他のコンテナとの依存関係を設定
        - database
      working_dir: /app # コンテナ起動時のカレントディレクトリを指定
      command: "rails s -b 0.0.0.0" # 起動時に実行されるコマンド
  ```

- Mysqlのコンテナを作成
- 動作確認はコンテナに入り、`SHOW DATABASES;`を実行し、DBが表示されること
  ```docker
    database:
    image: mysql:8.0.34   # MySQLのイメージを指定
    platform: linux/amd64
    container_name: database
    command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
    ports: # 他のコンテナからmysqlクライアントを用いてアクセスしたい場合は、portを公開する必要あり
      - "3308:3306"
    environment:  # DB接続情報
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: demo
      TZ: "Asia/Tokyo"
    volumes:
      - ./mysql-data:/var/lib/mysql # DBデータの保存領域
      - ./sql:/usr/scripts          # 実行したいSQLを保管しておく場所
  ```

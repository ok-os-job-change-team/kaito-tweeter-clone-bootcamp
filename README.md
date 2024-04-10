# Hitorigoto

## 概要
- "Hitorigoto"は簡易的なSNSアプリです。

### 主な機能
- ユーザー登録とログイン
	- ユーザーはアカウントを作成し、ログインすることでアプリを利用できます。
- ひとりごとの投稿
	- ユーザーはひとりごと(140字以内のテキストメッセージ)を入力してを投稿できます。
- ひとりごとの表示
	- ユーザーは投稿されたひとりごとをタイムライン上で閲覧できます。
- ひとりごとのいいね機能
	- ユーザーは他のユーザーが投稿したひとりごとにいいねを付けることができます。
- フォロー/フォロワー機能
	- ユーザーは他のユーザーをフォローすることができます。

### demo動画
![demo動画_230229](https://github.com/ok-os-job-change-team/kaito-twitter-clone-bootcamp/assets/90958196/6468e15b-1e46-4961-a419-f4ea7e8778c1)

### アプリのURL
- http://hitorigoto-app.com
- ゲストユーザー用のメールアドレスとパスワードでログイン可能です。
  - メールアドレス: guest_user@example.com
  - パスワード: guest_pass
- アカウントを登録することもできますが、メールアドレスは架空のものを登録するようお願いします。(例：`hoge@example.com`)

## 使用技術
| カテゴリー | 技術 |
|----------|----------|
| バックエンド  | Ruby 3.2.2, Ruby on Rails 7.0.7.2 |
| フロントエンド  | HTML, CSS,  JavaScript, Bulma |
| データベース  | mysql 8.0.34 |
| インフラ(開発環境)  | Docker |
| CI/CD  | GitHub Actions |
| その他  | Git, GitHub, RSpec, Rubocop |

## Dockerを使った環境構築
### 環境構築手順
1. リポジトリをクローンする
```
$ git clone https://github.com/ok-os-job-change-team/kaito-twitter-clone-bootcamp.git
```
2. リポジトリに移動する
```
$ cd kaito-twitter-clone-bootcamp
```
3. イメージをビルドする
```
$ docker-compose build
```
4. コンテナを起動する
```
$ docker-compose up -d
```
### ページを表示する
- コンテナを起動後、Webブラウザで`http://localhost:3000/login`にアクセスする。

### その他のコマンド
- コンテナを停止し、作成したコンテナとネットワークを削除する
```
$ docker-compose donw
```

- コンテナ内に入る(実行中のコンテナ内でコマンドを実行する)
```
$ docker exec -it web_app bash
```

## 画面遷移図
- figmaで画面遷移図を作成しました。
[画面遷移図はこちら](https://www.figma.com/file/hd6yLAUfRUJvzbM5cvUcdr/Tubuyaki?type=design&node-id=0-1&mode=design&t=NX5r90lopdH1wt2k-0)

## ER図
```mermaid
erDiagram
Users ||--o{ Tweets:""
Users ||--o{ Favorites:"" 
Favorites }o--|| Tweets:""
Users ||--o{ Relationships:""
Relationships }o--|| Users:""

Users {
  integer id
  string email
  string pass
  string created_at
  string updated_at
}
Tweets {
  integer id
  integer user_id
  string title
  string content
  string created_at
  string updated_at
}
Favorites {
  integer id
  integer user_id
  integer tweet_id
}
Relationships{
  integer id
  integer following_id
  integer follower_id
}
```

## システム構成図
![aws_アーキテクチャ図_0409](https://github.com/ok-os-job-change-team/kaito-twitter-clone-bootcamp/assets/90958196/268727f5-318a-4118-8442-a13d300a6189)
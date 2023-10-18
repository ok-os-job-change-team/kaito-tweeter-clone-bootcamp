## binding.prynについて
### 導入方法
Gemfileに`pry-rails`と`pry-byebug`を追加する
```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # デバッグツール
  gem 'pry-rails'
  gem 'pry-byebug'
end
```
`bundle install`を実行するため`docker-compose build`する

### 使い方
ソースの任意の箇所に`binding.pry`と書いて、プログラムを実行すると、その行でプログラムの処理がストップしてpryのREPLが立ち上がりデバッグできる。

**rubyのファイルを直接実行する場合**

ターミナルからrubyファイルを実行する
```
From: /app/app/controllers/users_controller.rb:9 UsersController#show:

     7: def show
     8:   binding.pry
 =>  9:   @user = User.find(params[:id])
    10: end

[1] pry(#<UsersController>)>
```

**docker環境のrailsアプリにアクセスしたとき**

`docker attach <コンテナID>`を実行後、ページにアクセスする
```
From: /app/app/controllers/users_controller.rb:5 UsersController#index:

    3: def index
    4:   binding.pry
 => 5:   @users = User.all
    6: end

[1] pry(#<UsersController>)>
```

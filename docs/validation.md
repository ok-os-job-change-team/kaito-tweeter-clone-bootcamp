# バリデーションについて
## 0.バリデーションとは
- バリデーションとはDBにデータを保存する前に、保存するデータに問題がないか検証する機能

## 1.バリデーションの書き方
- 基本的なバリエーションの記述方法は以下の通り
```ruby
class User < ApplicationRecord
# validatesの引数にインスタンス変数とバリデーションヘルパーを指定
  validates :email, :password, presence: true
end
```

## 2.バリデーションを手動で実行する方法
- Railsでは、レコードを保存する直前にバリデーションを実行することができる。
  - ActiveRecord::Baseを継承したメソッドでは、レコードを保存する前に自動的にバリデーションが実行される。
- 例えば、以下のメソッドではバリデーションが実行される
  - create, create!
  - save, save!
  - update, update!
- 手動でバリデーションを実行するには`valid?`メソッドを使う
  - `valid?`メソッドを実行すると、バリデーションに通ればtrueを返し、引っかかればfalseを返す。

## 3.エラーの情報を取得する
### errors
- バリデーション実行後に`errors`メソッドを使うことで、発生したエラーメッセージを取得できる
- `errors`メソッドはエラーメッセージをハッシュで取得するコマンドである
- 実行例
  ```ruby
  irb(main):011> user = User.new(email: nil, password: nil)

  #  valid?メソッドを実行(emailがnilのためfalseとなる)
  irb(main):012> user.valid?
  => false

  # user.errorsを実行するとエラーを含むActiveModel::Errorクラスのインスタンスを1つ返す
  irb(main):013> user.errors
  => #<ActiveModel::Errors [#<ActiveModel::Error attribute=email, type=blank, options={}>, #<ActiveModel::Error attribute=password, type=blank, options={}>]>
  ```

### errors.full_messages
- バリデーション実行後に`errors.full_messages`メソッドを使うことで、全てのエラーメッセージを取得できる
- `errors.full_messages`メソッドはエラーメッセージを配列で取得するコマンドである
- エラーメッセージを1つずつ表示したい場合は、`each`や`map`などの繰り返し処理を使うと良い
- 実行例
  ```ruby
  irb(main):001> user = User.new(email: nil, password: nil)

  # valid?メソッド実行前は配列の中身が空
  irb(main):002> user.errors.full_messages
  => []

  irb(main):003> user.valid?
  => false

  #  valid?メソッド実行後は配列にエラーメッセージが格納されている
  irb(main):004> user.errors.full_messages
  => ["メールアドレスを入力してください", "パスワードを入力してください"]
  ```

# マイグレーションファイル(schema.rb)について
## schema.rbを用いたマイグレーションのやり方
```bash
# schema.rbを生成する
$ rake db:schema:dump

# schema.rbに書いた内容をもとに、マイグレーションを行う
# このコマンドを実行すると、「CREATE TABLE」や「DROP TABLE」などのSQLが走る
$ rake db:schema:load
```

## 書き方
- `create_table`メソッドでテーブルを作成することができる
- `t.string "email", null: false`について
  - `t.string`でstring型のカラムを定義している。
  - `null: false`でnullを許容しないことを示している。
```ruby
ActiveRecord::Schema[7.0].define(version: 0) do
  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
```

## 動作確認方法
### rails consoleに入る
```bash
$ rails console
```

### コンソール上で`users`テーブルのレコードを作成する
```bash
# usersテーブルのレコードを作成する
irb(main):001> User.create(email: 'test@example.com', password: 'password')
  TRANSACTION (0.3ms)  BEGIN
  User Create (1.0ms)  INSERT INTO `users` (`email`, `password`, `created_at`, `updated_at`) VALUES (
'test@example.com', 'poassword', '2023-09-03 13:44:08.872011', '2023-09-03 13:44:08.872011')
  TRANSACTION (2.8ms)  COMMIT
=>
#<User:0x00007fc17a574f98
 updated_at: Sun, 03 Sep 2023 13:44:08.872011000 UTC +00:00>
```

### usersテーブルのレコードを全件取得してみる
```bash
# レコードを全て呼び出す
# select * from users; と同じことをやってる。
irb(main):002> User.all
  User Load (0.4ms)  SELECT `users`.* FROM `users`
=>
[#<User:0x00007fc17b3ea500
  id: 1,
  email: "test@example.com",
  password: "[FILTERED]",
  created_at: Sun, 03 Sep 2023 13:44:08.872011000 UTC +00:00,
  updated_at: Sun, 03 Sep 2023 13:44:08.872011000 UTC +00:00>]
```

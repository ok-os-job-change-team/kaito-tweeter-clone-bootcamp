# FactoryBotについて
- FactoryBotは、`ApplicationRecord`を継承したクラスのインスタンスを生成するために使用するgemです。
  - `User.create(name: '小野', password: 'password', email: 'test@example.com')`のようなコードを長々と実行するのは面倒臭い。。。。。
  - FactoryBotなら、`FactoryBot.create(:user)`とするだけで良くなる。
- 2つのクラスメソッドを使用することができます。
  - `FactoryBot.create(:hoge)`
    - Hogeクラスのインスタンスを生成する、なおかつレコードも挿入する。
  - `FactoryBot.build(:hoge)`
    - Hogeクラスのインスタンスを生成する。こちらはレコードは挿入しない。
## 記述例
- Userモデルを定義していた場合では、以下のような記述をする必要がある。
```ruby
FactoryBot.define do
  # factory :hogeで、利用したいクラス名を指定する。
  factory :user do
    email { "john@example.com" }
    password { "secret_password" }
  end
end
```
## Tips
- `FactoryBot.create(:hoge)`や`FactoryBot.build(:hoge)`のFactoryBotは設定することで省略することができます。
  - Ref: https://qiita.com/jonakp/items/0f70eece4fe7980f81a6
  - `spec/rails_helper.rb`に以下のように書けば良いです。
  ```ruby
  RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
  end
  ```
  - 使用例は、以下。
  ```ruby
  RSpec.describe User, type: :model do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
  ```

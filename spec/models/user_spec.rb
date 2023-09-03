# require_relative '../rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = FactoryBot.build(:user)  # Userモデルのインスタンスを生成
    expect(user).to be_valid
  end
end

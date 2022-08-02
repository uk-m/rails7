require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      name: "Taro",
      email: "taro@example.com",
      password: "password")
    expect(user).to be_valid
  end
  
  it "名前がなければ無効な状態であること" do
    user = User.new(name: nil)
    user.valid?
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
    User.create(
      name: "Jiro",
      email: "tester@example.com",
      password: "password")
    user = User.new(
      name: "Saburo",
      email: "tester@example.com",
      password: "password")
    user.valid?
  end
end

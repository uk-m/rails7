require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  
  it "名前、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      name: "Taro",
      email: "taro@example.com",
      password: "password")
    expect(user).to be_valid
  end
  
  it "名前がなければ無効な状態であること" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
  end
  
  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: "test@example.com")
    user = FactoryBot.build(:user, email: "test@example.com")
    user.valid?
  end
end

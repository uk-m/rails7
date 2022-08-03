require 'rails_helper'

RSpec.describe Answer, type: :model do
  before do
    @user = User.create(
      name: "Taro",
      email: "taro@example.com",
      password: "password")
    
    @question = @user.questions.create(
      title: "転職を考えている",
      content: "初めましてこんにちは",
      category: "IT")
  end
  
  it "ユーザー、質問、内容があれば有効な状態であること" do
    answer = Answer.new(
      content: "質問に回答",
      user: @user,
      question: @question)
    expect(answer).to be_valid
  end
  
  it "内容がなければ無効な状態であること" do
    answer = Answer.new(content: nil)
    answer.valid?
  end
end

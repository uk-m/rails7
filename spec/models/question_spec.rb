require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @user = User.create(
      name: "太郎",
      email: "taro@example.com",
      passwrod: "password")
  end
  
  describe "文字列に一致するメッセージを検索する" do
    before do
      @question1 = Question.create(
        title: "転職を考えている",
        content: "みなさまこんにちは",
        category: "IT",
        user: @user)
      @question2 = Question.create(
        title: "転職を考えている",
        content: "どうもこんにちは",
        category: "IT",
        user: @user)
      @question3 = Question.create(
        title: "転職を考えている",
        content: "みなさまこんにちは",
        category: "IT",
        user: @user)
    end
    
    context "一致するデータが見つかるとき" do
      it "文字列に一致する質問を返すこと" do
        expect(Question.search("みなさま")).to include(@question1, @question3)
      end
    end
  end
end

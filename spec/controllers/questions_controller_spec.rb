require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe "#index" do
    it "正常にレスポンスを返すこと" do
      get :index
      expect(response).to be_successful
    end
    
    it "200レスポンスを返すこと" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
  
  describe "#create" do
    context "認証済みのユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "質問を追加できること" do
        question_params = FactoryBot.attributes_for(:question)
        sign_in @user
        expect {
          post :create, params: { question: question_params }
        }.to change(@user.questions, :count).by(1)
      end
    end
  end
end

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
      
      context "有効な属性値の場合" do
        it "質問を追加できること" do
          question_params = FactoryBot.attributes_for(:question)
          sign_in @user
          expect {
            post :create, params: { question: question_params }
          }.to change(@user.questions, :count).by(1)
        end
      end
      
      context "無効な属性値の場合" do
        it "質問を追加できないこと" do
          question_params = FactoryBot.attributes_for(:question, :invalid)
          sign_in @user
          expect {
            post :create, params: { question: question_params }
          }.to_not change(@user.questions, :count)
        end
      end
    end
  end
  
  describe "#destroy" do
    context "認可されたユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @question = FactoryBot.create(:question, owner: @user)
      end
      
      it "質問を削除できること" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @question.id }
        }.to change(@user.questions, :count).by(-1)
      end
    end
    
    context "認可されないユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @question = FactoryBot.create(:question, owner: other_user)
      end
      
      it "質問を削除できないこと" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @question.id }
        }.to_not change(Question, :count)
      end
    end
  end
end

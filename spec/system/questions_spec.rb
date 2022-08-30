require 'rails_helper'

RSpec.describe "Questions", type: :system do
  scenario "ユーザーは新しい質問を作成する" do
    user = FactoryBot.create(:user)
    
    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.pasword
    click_button "ログイン"
    
    expect {
      click_link "質問投稿"
      fill_in "内容", with: "Test Content"
      select "業界", from: "Category.all"
      click_button "投稿する"
    }.to change(user.questions, :count).by(1)
  end
end

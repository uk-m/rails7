class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search

  def set_search
    @search = Question.ransack(params[:q])
  end
  
  private
  
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end

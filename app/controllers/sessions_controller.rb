class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:danger] = '正しい情報を入力してください'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, status: :see_other
  end
end
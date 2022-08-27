class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash[:danger] = '正しい情報を入力してください'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, status: :see_other
  end
  
  def guest_sign_in
    user = User.guest
    log_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end
end
class UsersController < ApplicationController
  def new
    @user = User.new(flash[:user])
  end
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:user] = user
      flash[:error_messages] = user.errors.full_messages
      redirect_back fallback_location: { action: "new", id: user.id }
    end
  end
  
  def show
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy following followers)
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new(flash[:user])
  end
  
  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
    if @user.save
      log_in @user
      flash[:success] = "新規登録完了しました"
      redirect_to root_path
    else
      flash[:user] = @user
      flash[:error_messages] = @user.errors.full_messages
      redirect_back fallback_location: { action: "new", id: @user.id }
    end
  end
  
  def show
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to users_url
  end
  
  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy following followers)
  before_action :admin_user, only: :destroy
  before_action :set_q, only: %i(index search)
  
  def index
    @users = User.page(params[:page]).per(12)
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
      render 'new', status: :unprocessable_entity
    end
  end
  
  def show
    @user = User.find(params[:id])
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
    redirect_to users_url, status: :see_other
  end
  
  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow', status: :unprocessable_entity
  end
  
  def search
    @users = @q.result
  end
  
  def question
    @user = User.find(params[:id])
    @questions = @user.questions
  end
  
  def interest
    @user = User.find(params[:id])
    @questions = @user.interested_questions
  end
  
  def like
    @user = User.find(params[:id])
    @answers = @user.liked_answers
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
    end
    
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
    
    def set_q
      @q = User.ransack(params[:q])
    end
end

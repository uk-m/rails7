class LikesController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  
  def create
    @like = current_user.likes.new(user_id: params[:user_id], answer_id: params[:answer_id])
    if @like.save
      respond_to do |format|
        # format.html { redirect_to @like }
        format.turbo_stream
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @answer = @like.answer
    if @like.destroy
      respond_to do |format|
        # format.html { redirect_to @like, status: :see_other }
        format.turbo_stream
      end
    end
  end
end

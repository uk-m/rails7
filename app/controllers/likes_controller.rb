class LikesController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  
  def create
    @like = current_user.likes.new(answer_id: params[:answer_id])
    @answer = @like.answer
    if @like.save
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @answer = @like.answer
    if @like.destroy
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end

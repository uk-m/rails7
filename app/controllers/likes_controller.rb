class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(answer_id: params[:answer_id])
    @answer = @like.answer
    if @like.save
      respond_to do |format|
        format.html { redirect_to @answer }
        format.turbo_stream
      end
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @answer = @like.answer
    if @like.destroy
      respond_to do |format|
        format.html { redirect_to @answer, status: :see_other }
        format.turbo_stream
      end
    end
  end
end

class InterestsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  
  def create
    @interest = current_user.interests.new(question_id: params[:question_id])
    @question = @interest.question
    if @interest.save
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    @interest = Interest.find(params[:id])
    @question = @interest.question
    if @interest.destroy
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end

class InterestsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  
  def create
    @interest = current_user.interests.create(interest_params)
    @question = @interest.question
    if @interest.save
      respond_to do |format|
        format.html { redirect_to @question }
        format.turbo_stream
      end
    end
  end

  def destroy
    @interest = Interest.find_by(id: params[:id])
    @question = @interest.question
    if @interest.destroy
      respond_to do |format|
        format.html { redirect_to @question, status: :see_other }
        format.turbo_stream
      end
    end
  end
  
  private
  
    def interest_params
      params.permit(:question_id)
    end
end

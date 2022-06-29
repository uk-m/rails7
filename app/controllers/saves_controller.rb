class SavesController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  
  def create
    @save = current_user.saves.create(question_id: params[:question_id])
    @answer = @save.question
    if @save.save
      respond_to do |format|
        format.html { redirect_to @question }
        format.turbo_stream
      end
    end
  end

  def destroy
    @save = Save.find_by(id: params[:id])
    @question = @save.queston
    if @save.destroy
      respond_to do |format|
        format.html { redirect_to @question, status: :see_other }
        format.turbo_stream
      end
    end
  end
end

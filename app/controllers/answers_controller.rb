class AnswersController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  
  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.new(answer_params)
    if @answer.save
      redirect_to @question
    else
      redirect_to @question, status: :unprocessable_entity
    end
  end
  
  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to @question, status: :see_other
  end
  
  private
    def answer_params
      params.require(:answer).permit(:content)
    end
end

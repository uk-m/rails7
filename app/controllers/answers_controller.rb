class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    # @question = @answer.question
    if @question.save
      redirect_to question_path(@question)
    else
      redirect_to @question
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
      params.require(:answer).permit(:user_id, :question_id, :content)
    end
end

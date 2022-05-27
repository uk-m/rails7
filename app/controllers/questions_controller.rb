class QuestionsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end
  
  private
    def question_params
      params.require(:question).permit(:title, :content, :category_id)
    end
end

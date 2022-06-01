class QuestionsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :set_question, only: %i(show edit update destroy)
  
  def index
    @questions = Question.all
  end
  
  def show
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
  end
  
  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    @question.destroy
    redirect_to questions_path, status: :see_other
  end
  
  private
    def question_params
      params.require(:question).permit(:title, :content, :category_id)
    end
    
    def set_question
      @question = Question.find(params[:id])
    end
end

class CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
    @questions = @category.questions.page(params[:page])
  end
end

class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name:ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD']

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category Created!'
    else
      render :new
    end
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end

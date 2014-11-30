class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update]

  # GET /categories
  def index
    @categories = Category.all
  end

  # GET /categories/1/edit
  def edit
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      @category.color='#'+@category.color if @category.color[0]!='#'
      @category.save!
      redirect_to categories_path
    else
      render :edit
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name, :color)
  end
end

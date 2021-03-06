class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update]

  # GET /categories
  def index
    @categories = Category.all
  end

  # GET /categories/1/edit
  def edit
  end

  # GET /categories/new
  def new
    @category = Category.new
    render :edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :edit
    end
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

  #pickup list of categories
  def show
    @categories = Category.all
    @site = Site.find(params[:id])
    render :show, layout: false
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name, :color, :picture)
  end
end

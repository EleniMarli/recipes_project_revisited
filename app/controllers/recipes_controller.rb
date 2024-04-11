class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit]

  # def index
  #   @recipes = Recipe.all
  # end

  def new
    @recipe = Recipe.new
    authorize(@recipe)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize(@recipe)

    if @recipe.save
      redirect_to profile_path, notice: "Recipe saved succesfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize(@recipe)
  end

  def edit
    authorize(@recipe)
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path, notice: "Recipe updated succesfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :portions, :instructions, :time_in_min, :difficulty)
  end
end

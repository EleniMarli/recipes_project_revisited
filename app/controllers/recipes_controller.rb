class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[create]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    authorize(@recipe)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize(@recipe)

    if @recipe.save
      redirect_to @recipe, notice: "Recipe saved succesfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params

  end
end

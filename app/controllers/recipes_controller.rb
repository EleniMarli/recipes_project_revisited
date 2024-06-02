class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

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

    ingr_instances_list = []
    @recipe.list_of_ingredients.split("\n").reject { |str| str == "" }.map(&:strip).each do |str|
      ingredient = Ingredient.str_to_ingr(str)
      ingr_instances_list << ingredient if ingredient.valid?
      if !ingredient.valid?
        flash.now[:notice] = "One of the ingredients is not valid. Use a more standardised format (e.g. '400 gr pasta')"
        render :new, status: :unprocessable_entity
        return
      end
    end

    if @recipe.save
      ingr_instances_list.each do |ingr|
        ingr.recipe_id = @recipe.id
        ingr.save
      end
      @recipe.beautify_list_of_ingredients
      redirect_to recipe_path(@recipe), notice: "Recipe saved succesfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize(@recipe)
    if params["changed_portions"] == nil || params["changed_portions"].to_i == @recipe.portions
      @appearing_portions = @recipe.portions
      @ingredients = @recipe.ingredients.map(&:to_str)
    else
      @appearing_portions = params["changed_portions"].to_i
      @ingredients = @recipe.ingredients.map do |ingr|
        ingr.amount = (ingr.amount / @recipe.portions) * @appearing_portions if ingr.amount
        ingr.to_str
      end
    end
  end

  def edit
    authorize(@recipe)
  end

  def update
    authorize(@recipe)

    ingr_instances_list = []
    recipe_params[:list_of_ingredients].split("\n").reject { |str| str == "" }.map(&:strip).each do |str|
      ingredient = Ingredient.str_to_ingr(str)
      ingr_instances_list << ingredient if ingredient.valid?
      if !ingredient.valid?
        flash.now[:notice] = "One of the ingredients is not valid. Use a more standardised format (e.g. '400 gr pasta')"
        render :edit, status: :unprocessable_entity
        return
      end
    end

    @recipe.assign_attributes(recipe_params)

    if @recipe.valid?
      @recipe.update(recipe_params)
      # OLD INGREDIENTS
      @recipe.ingredients.destroy_all

      # NEW INGREDIENTS
      ingr_instances_list.each do |ingr|
        ingr.recipe_id = @recipe.id
        ingr.save
      end

      @recipe.beautify_list_of_ingredients
      redirect_to recipe_path(@recipe), notice: "Recipe updated succesfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@recipe)
    @recipe.destroy
    redirect_to profile_path, notice: "Recipe deleted successfully"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :portions, :instructions, :list_of_ingredients, :time_in_min, :difficulty, :public)
  end
end

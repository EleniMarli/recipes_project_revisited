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

    if @recipe.save


      @recipe.list_of_ingredients.split("\n").reject{ |str| str == "" }.map(&:strip).each do |str|
        ingredient = Ingredient.new
        # START WITH NUM

        # LOOK FOR COMMA
        num_str_comma = str.scan(/\d+,\d+/)


        str.gsub(/\d+,\d+/) { |match| match.gsub(',', '.') }

        amount = str.scan(/[-+]?\d*\.?\d+/).first
        amount = amount.to_f unless amount.nil?

        # THEN METRIC UNIT
        metric_unit = METRIC_UNITS.find { |word| str.include?(word) }
        # metric_unit = "unit(s)" if metric_unit.nil?

        # REST IS NAME

      end



      redirect_to recipe_path(@recipe), notice: "Recipe saved succesfully"
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
    authorize(@recipe)
    if @recipe.update(recipe_params)
      redirect_to recipe_path, notice: "Recipe updated succesfully"
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

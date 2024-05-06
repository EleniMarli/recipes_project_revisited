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
      @recipe.list_of_ingredients.split("\n").reject{ |str| str == "" }.map(&:strip).each do |str|

        # START WITH AMOUNT
        str.gsub(/\d+,\d+/) { |match| match.gsub(',', '.') }

        amount = str.scan(/[-+]?\d*\.?\d+/).first
        unless amount.nil?
          str.gsub!(amount, " ")
          amount = amount.to_f
        end

        # THEN METRIC UNIT
        metric_unit = Ingredient.metric_units.find { |word| str.match?(/\b#{word.downcase}\b/i) }

        #"250g penne pasta\n400 gr canned diced tomatoes\n1 onion, finely chopped\n2 cloves garlic, minced\n200 oz spinach leaves\n100 mL feta cheese, crumbled\n2 liter olive oil\n1 bunch dried oregano\nsalt and pepper to taste"

        unless metric_unit.nil?
          str.gsub!(/\b#{metric_unit.downcase}\b/i, "")
          metric_unit.downcase!
        end

        # REST IS NAME
        name = str.gsub(/\s+/, " ").strip

        ingredient = Ingredient.new(name: name, amount: amount, metric_unit: metric_unit, recipe_id: nil)
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
        format_list_of_ingredients(@recipe)
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

  def format_list_of_ingredients(recipe)
    new_list_of_ingredients = recipe.ingredients.map do |ingr|
      if ingr.amount && ingr.metric_unit
        "#{ingr.amount} #{ingr.metric_unit} #{ingr.name}"
      elsif ingr.amount
        "#{ingr.amount} #{ingr.name}"
      else
        ingr.name.to_s
      end
    end.join("\n")
    recipe.update(list_of_ingredients: new_list_of_ingredients)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :portions, :instructions, :list_of_ingredients, :time_in_min, :difficulty, :public)
  end
end

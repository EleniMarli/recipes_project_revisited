class RenameIngredientsToListOfIngredients < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipes, :ingredients, :list_of_ingredients
  end
end

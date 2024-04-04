class ChangeRecipeIdNullableInIngredients < ActiveRecord::Migration[7.1]
  def change
    change_column_null :ingredients, :recipe_id, true
  end
end

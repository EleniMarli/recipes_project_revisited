class ChangeShoppingListIdNullableInIngredients < ActiveRecord::Migration[7.1]
  def change
    change_column_null :ingredients, :shopping_list_id, true
  end
end

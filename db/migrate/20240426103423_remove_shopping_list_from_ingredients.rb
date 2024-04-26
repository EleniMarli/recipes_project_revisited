class RemoveShoppingListFromIngredients < ActiveRecord::Migration[7.1]
  def change
    remove_column :ingredients, :shopping_list_id, :bigint
  end
end

class AddPublicToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :public, :boolean, default: false
  end
end

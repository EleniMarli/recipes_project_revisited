class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :amount
      t.string :metric_unit
      t.references :recipe, null: false, foreign_key: true
      t.references :shopping_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end

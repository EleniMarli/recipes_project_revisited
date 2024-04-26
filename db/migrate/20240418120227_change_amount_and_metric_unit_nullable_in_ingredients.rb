class ChangeAmountAndMetricUnitNullableInIngredients < ActiveRecord::Migration[7.1]
  def change
    change_column_null :ingredients, :amount, true
    change_column_null :ingredients, :metric_unit, true
  end
end

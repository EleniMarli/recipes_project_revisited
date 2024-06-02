class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy

  validates :name, :portions, :instructions, :time_in_min, :difficulty, :instructions, :list_of_ingredients, presence: true
  validates :portions, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }
  validates :time_in_min, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5000 }
  validates :difficulty, inclusion: { in: %w[easy medium difficult] }

  def beautify_list_of_ingredients
    new_list_of_ingredients = self.ingredients.map do |ingr|
      ingr.to_str
    end.join("\n")
    self.update(list_of_ingredients: new_list_of_ingredients)
  end
end

class Ingredient < ApplicationRecord
  belongs_to :recipe, optional: true
  has_many :shopping_list_ingredients
  has_many :shopping_lists, through: :shopping_list_ingredients

  def self.metric_units
    [ # Singular forms
      "gram",
      "kilogram",
      "milligram",
      "ounce",
      "pound",
      "fluid ounce",
      "pint",
      "quart",
      "gallon",
      "teaspoon",
      "tablespoon",
      "cup",
      "milliliter",
      "liter",
      "pinch",
      "clove",
      "piece",
      "bunch",
      # Plural forms
      "grams",
      "kilograms",
      "milligrams",
      "ounces",
      "pounds",
      "fluid ounces",
      "pints",
      "quarts",
      "gallons",
      "teaspoons",
      "tablespoons",
      "cups",
      "milliliters",
      "liters",
      "pinches",
      "cloves",
      "pieces",
      # Abbreviations
      "g",
      "gr",
      "kg",
      "mg",
      "oz",
      "lb",
      "fl oz",
      "pt",
      "qt",
      "gal",
      "tsp",
      "tbsp",
      "ml",
      "l"
    ]
  end

  def self.str_to_ingr(str)
    # AMOUNT
    str.gsub(/\d+,\d+/) { |match| match.gsub(',', '.') }
    amount = str.scan(/[-+]?\d*\.?\d+/).first
    unless amount.nil?
      str.gsub!(amount, " ")
      amount = amount.to_f
    end

    # METRIC UNIT
    metric_unit = Ingredient.metric_units.find { |word| str.match?(/\b#{word.downcase}\b/i) }
    unless metric_unit.nil?
      str.gsub!(/\b#{metric_unit.downcase}\b/i, "")
      metric_unit.downcase!
    end

    # NAME
    name = str.gsub(/\s+/, " ").strip
    Ingredient.new(name: name, amount: amount, metric_unit: metric_unit, recipe_id: nil)
  end

  def to_str
    if self.amount && self.metric_unit
      return "#{self.amount} #{self.metric_unit} #{self.name}"
    elsif self.amount
      return "#{self.amount} #{self.name}"
    else
      return self.name
    end
  end
end

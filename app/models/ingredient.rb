class Ingredient < ApplicationRecord
  belongs_to :recipe
  has_many :shopping_list_ingredients
  has_many :shopping_lists, through: :shopping_list_ingredients

  METRIC_UNITS = [
    # Singular forms
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

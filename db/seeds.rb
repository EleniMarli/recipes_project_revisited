# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
ShoppingList.destroy_all

user1 = User.create(
  name: "Eleni",
  email: "eleni@eleni.com",
  password: "123456"
)

recipe1 = Recipe.create(
  name: "Scrambled Eggs",
  portions: 1,
  instructions: "1. Crack the eggs into a bowl. Add a pinch of salt and pepper according to your taste preferences.\n2. Beat the eggs until the yolks and whites are well combined.\n3. Heat a non-stick skillet over medium heat. Add the butter or oil and let it melt and coat the bottom of the skillet.\n4. Once the butter is melted and the skillet is heated, pour the beaten eggs into the skillet.\n5. Let the eggs cook for a few seconds until the edges start to set.\n6. Using a spatula, gently push the eggs from the edges towards the center of the skillet, allowing the uncooked eggs to flow to the edges.\n7. Continue to cook and gently stir the eggs until they are mostly set but still slightly runny.\n8. Remove the skillet from the heat and let the residual heat finish cooking the eggs. Be careful not to overcook them.\n9. If desired, sprinkle chopped chives or grated cheese over the scrambled eggs for extra flavor.\n10. Serve the scrambled eggs hot with toast, bacon, or your favorite breakfast sides.",
  time_in_min: 15,
  difficulty: "easy",
  user: user1,
  public: true,
  list_of_ingredients: "2.0 eggs\nSalt to taste\nPepper to taste\n1.0 tablespoon butter or oil\nOptional: chopped chives, grated cheese"
)

Ingredient.create(
  name: "eggs",
  amount: 2.0,
  metric_unit: nil,
  recipe: recipe1
)

Ingredient.create(
  name: "Salt to taste",
  amount: nil,
  metric_unit: nil,
  recipe: recipe1
)

Ingredient.create(
  name: "Pepper to taste",
  amount: nil,
  metric_unit: nil,
  recipe: recipe1
)

Ingredient.create(
  name: "butter or oil",
  amount: 1.0,
  metric_unit: "tablespoon",
  recipe: recipe1
)

Ingredient.create(
  name: "chopped chives, grated cheese",
  amount: nil,
  metric_unit: nil,
  recipe: recipe1
)

recipe2 = Recipe.create(
  name: "Classic Tomato Salad",
  portions: 2,
  instructions: "1. Wash and slice the tomatoes into wedges or slices.\n2. Peel and thinly slice the red onion.\n3. In a large bowl, combine the tomatoes, sliced red onion, and torn basil leaves.\n4. Drizzle olive oil over the salad and season with salt and pepper to taste.\n5. Gently toss the salad until the ingredients are evenly coated.\n6. Let the salad sit for 10-15 minutes to allow the flavors to meld together.\n7. Just before serving, sprinkle crumbled feta cheese over the salad.\n8. Serve the classic tomato salad as a side dish or as a light and refreshing appetizer.",
  time_in_min: 15,
  difficulty: "medium",
  user: user1,
  public: false,
  list_of_ingredients: "2.0 large tomatoes\n0.5 red onion\nHandful of fresh basil leaves\n2.0 tablespoons olive oil\nSalt and pepper to taste\n0.25 cup crumbled feta cheese (optional)"
)

Ingredient.create(
  name: "large tomatoes",
  amount: 2.0,
  metric_unit: nil,
  recipe: recipe2
)

Ingredient.create(
  name: "red onion",
  amount: 0.5,
  metric_unit: nil,
  recipe: recipe2
)

Ingredient.create(
  name: "Handful of fresh basil leaves",
  amount: nil,
  metric_unit: nil,
  recipe: recipe2
)

Ingredient.create(
  name: "olive oil",
  amount: 2.0,
  metric_unit: "tablespoons",
  recipe: recipe2
)

Ingredient.create(
  name: "Salt and pepper to taste",
  amount: nil,
  metric_unit: nil,
  recipe: recipe2
)

Ingredient.create(
  name: "crumbled feta cheese (optional)",
  amount: 0.25,
  metric_unit: "cup",
  recipe: recipe2
)

# -----------------------------------------

user2 = User.create(
  name: "Carlos",
  email: "carlos@carlos.com",
  password: "123456"
)

recipe3 = Recipe.create(
  name: "Banana Smoothie",
  portions: 2,
  instructions: "1. Peel the banana and break it into chunks.\n2. Place the banana chunks in a blender.\n3. Add the milk, yogurt, honey, and ice cubes to the blender.\n4. Blend on high speed until smooth and creamy.\n5. Pour the banana smoothie into a glass and serve immediately.",
  time_in_min: 35,
  difficulty: "easy",
  user: user2,
  public: false,
  list_of_ingredients: "1.0 ripe banana\n0.5 cup milk\n0.5 cup yogurt\n1.0 tablespoon honey\nHandful of ice cubes"
)

Ingredient.create(
  name: "ripe banana",
  amount: 1.0,
  metric_unit: nil,
  recipe: recipe3
)

Ingredient.create(
  name: "milk",
  amount: 0.5,
  metric_unit: "cup",
  recipe: recipe3
)

Ingredient.create(
  name: "yogurt",
  amount: 0.5,
  metric_unit: "cup",
  recipe: recipe3
)

Ingredient.create(
  name: "honey",
  amount: 1.0,
  metric_unit: "tablespoon",
  recipe: recipe3
)

Ingredient.create(
  name: "Handful of ice cubes",
  amount: nil,
  metric_unit: nil,
  recipe: recipe3
)

recipe4 = Recipe.create(
  name: "Basic Pasta Dish",
  portions: 3,
  instructions: "1. Bring a large pot of salted water to a boil.\n2. Add the pasta to the boiling water and cook according to package instructions until al dente.\n3. While the pasta is cooking, heat olive oil in a skillet over medium heat.\n4. Add minced garlic to the skillet and sauté until fragrant, about 1 minute.\n5. Drain the cooked pasta and add it to the skillet.\n6. Toss the pasta with the garlic-infused oil until evenly coated.\n7. Season with salt, pepper, and red pepper flakes to taste.\n8. Serve the basic pasta dish hot, optionally garnished with grated Parmesan cheese and chopped parsley.",
  time_in_min: 25,
  difficulty: "difficult",
  user: user2,
  public: true,
  list_of_ingredients: "200.0 g pasta (spaghetti, penne, or your choice)\n2.0 tablespoons olive oil\n2.0 cloves garlic, minced\nSalt and pepper to taste\nPinch of red pepper flakes (optional)\nGrated Parmesan cheese and chopped parsley for garnish (optional)"
)

Ingredient.create(
  name: "pasta (spaghetti, penne, or your choice)",
  amount: 200.0,
  metric_unit: "g",
  recipe: recipe4
)

Ingredient.create(
  name: "olive oil",
  amount: 2.0,
  metric_unit: "tablespoons",
  recipe: recipe4
)

Ingredient.create(
  name: "garlic, minced",
  amount: 2.0,
  metric_unit: "cloves",
  recipe: recipe4
)

Ingredient.create(
  name: "Salt and pepper to taste",
  amount: nil,
  metric_unit: nil,
  recipe: recipe4
)

Ingredient.create(
  name: "Pinch of red pepper flakes (optional)",
  amount: nil,
  metric_unit: nil,
  recipe: recipe4
)

Ingredient.create(
  name: "Grated Parmesan cheese and chopped parsley for garnish (optional)",
  amount: nil,
  metric_unit: nil,
  recipe: recipe4
)

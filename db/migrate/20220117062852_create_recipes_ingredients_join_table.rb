class CreateRecipesIngredientsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :recipes, :ingredients do |t|
      t.index :recipe_id
      t.index :ingredient_id
    end
  end
end

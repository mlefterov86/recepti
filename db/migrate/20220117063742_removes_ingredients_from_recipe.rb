class RemovesIngredientsFromRecipe < ActiveRecord::Migration[6.1]
  def change
    remove_index :recipes, :ingredients, using: 'gin'
    remove_column :recipes, :ingredients
  end
end

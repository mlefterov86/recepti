# frozen_string_literal: true

# Create recipes table
class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.references :author, null: false, foreign_key: true
      t.references :difficulty, null: false, foreign_key: true
      t.integer :prep_time
      t.integer :cook_time
      t.integer :total_time
      t.decimal :rate, precision: 2, scale: 1
      t.string :budget
      t.integer :people_quantity
      t.text :ingredients, array: true, default: []

      t.timestamps
    end

    add_index :recipes, :rate
    add_index :recipes, :total_time
    add_index :recipes, :people_quantity
    add_index :recipes, :ingredients, using: 'gin'
  end
end

# frozen_string_literal: true

# Create difficulties table
class CreateDifficulties < ActiveRecord::Migration[6.1]
  def change
    create_table :difficulties do |t|
      t.string :name

      t.timestamps

      t.index :name, unique: true
    end
  end
end

# frozen_string_literal: true

# Create authors table
class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name

      t.timestamps

      t.index :name
    end
  end
end

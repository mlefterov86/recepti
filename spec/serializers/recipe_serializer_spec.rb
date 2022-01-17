require 'rails_helper'

RSpec.describe RecipeSerializer do
  subject(:serializer) { described_class.new(recipe).serializable_hash }

  let(:recipe) do
    FactoryBot.create(
      :recipe,
      ingredients: [ingredient1, ingredient2],
      )
  end
  let(:ingredient1) { FactoryBot.create(:ingredient) }
  let(:ingredient2) { FactoryBot.create(:ingredient) }
  let(:ingredients) do
    [
      IngredientSerializer.new(ingredient1),
      IngredientSerializer.new(ingredient2),
    ]
  end

  it { is_expected.to include(id: recipe.id) }
  it { is_expected.to include(name: recipe.name) }
end

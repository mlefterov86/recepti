  class RecipeSerializer < ActiveModel::Serializer
    attribute :id
    attribute :name
    attribute :ingredients

    def ingredients
      object.ingredients.map do |ingredient|
        IngredientSerializer.new(ingredient)
      end
    end
  end

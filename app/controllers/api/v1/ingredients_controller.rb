class Api::V1::IngredientsController < ApplicationController
  def index
    ingredients = Ingredient.all
    render json: ingredients, each_serializer: IngredientSerializer
  end
end

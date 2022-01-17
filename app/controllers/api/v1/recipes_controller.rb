class Api::V1::RecipesController < ApplicationController
  def index
    render json: recipes, each_serializer: RecipeSerializer
  end

  def fill_db
    render json: { success: true }, status: 200 if FillDb.call
  end

  private

  def recipes
    # will be good to add paging
    ids = recipe_ids
    if ids.present?
      Recipe.where(id: ids)
    else
      Recipe.all.order(created_at: :desc)[0..100]
    end

  end

  def recipe_ids
    return if params['query_params'].blank?

    ingredient_ids = []
    parsed_params = JSON.parse(params['query_params'])
    parsed_params.each do |param|
      ingredient = param['name']
      ingredient_ids = ingredient_ids + Ingredient.where('name LIKE ?',  "%#{ingredient}%").map(&:id)
    end

    Recipe.includes(:ingredients).where(ingredients: {id: ingredient_ids}).map(&:id)
  end
end

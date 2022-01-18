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
      Recipe.all.order(created_at: :desc)
    end

  end

  def recipe_ids
    return if params['ingredient_ids'].blank?

    ingredient_ids = JSON.parse(params['ingredient_ids']).map{ |ing| ing['id'] }
    Recipe.includes(:ingredients).where(ingredients: {id: ingredient_ids}).map(&:id)
  end
end

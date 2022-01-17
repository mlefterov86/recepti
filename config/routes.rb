Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get :fill_db, to: 'recipes#fill_db'
      resources :recipes, only: %I(index) do
      end
      resources :ingredients, only: %I(index)
    end
  end

  root 'homepage#index'
  get '/*path' => 'homepage#index'
end

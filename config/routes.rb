Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes, only: %I(index)
    end
  end

  root 'homepage#index'
  get '/*path' => 'homepage#index'
end

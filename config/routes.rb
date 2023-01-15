Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/learning_resources', to: 'learning_resources#show'
      # resources :learning_resources, only: %i[show]
      resources :recipes, only: %i[index]
      resources :users, only: %i[create]
      resources :favorites, only: %i[create]
    end
  end
end

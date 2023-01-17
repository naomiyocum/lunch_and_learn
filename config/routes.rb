Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :learning_resources, only: %i[show]
      resources :recipes, only: %i[index]
      resources :sessions, only: %i[create]
      resources :users, only: %i[create]
      resources :favorites, only: %i[create index]
      resource :favorites, only: %i[destroy]
    end
  end
end

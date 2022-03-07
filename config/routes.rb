Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "api/v1/articles#index"

  namespace :api do
    namespace :v1 do
      resources :articles 
      resources :comments
      get 'search_article', to: 'articles#search'
      get 'comment_search', to: 'comments#search'
    end   
  end
end

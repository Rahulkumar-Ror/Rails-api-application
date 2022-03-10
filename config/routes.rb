Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "api/v1/articles#index"
  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :create, :destroy, :show, :update] do
        resources :comments, only: [:index, :create, :destroy, :show, :update]
      end
    end
	end
  get 'search_article', to: "api/v1/articles#search", :as => :search_article
  get 'search_comment', to: "api/v1/comments#search", :as => :search_comment
end

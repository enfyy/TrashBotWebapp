Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'trash#index' # set root page to Trash index page.
  resources :trash, only: [:index, :create, :show, :destroy] # Create routes for Trash related Requests.
  resources :category, only: [:index, :create, :destroy] # Create routes for Category related Requests.
  post 'authenticate', to: 'authentication#authenticate' # Create route for authentication.
  get 'map', to: 'map#index' # Create route for the Scatter map.
  get 'activity', to: 'activity#index' #Create route for bot activity.
end

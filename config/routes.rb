Rails.application.routes.draw do

  resources :categories
  resource :session

  get "signup" => "users#new"

  resources :users


  # %w(past free).each do |scope|
  #   get "events/#{scope}" => "events#index", scope: scope
  # end

  # get "events/:scope" => "events#index", constraints: { scope: /past|free/ }

  get "events/filter/:scope" => "events#index", as: :filtered_events


  resources :events do
  	resources :registrations
    resources :likes
  end

  root 'events#index'
  # get 'events' => 'events#index'
  # get 'events/:id' => 'events#show', as: "event"
  # get 'events/:id/edit' => 'events#edit', as: "edit_event"
  # patch 'events/:id' => 'events#update'

  

end

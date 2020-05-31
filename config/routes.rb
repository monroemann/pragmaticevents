Rails.application.routes.draw do

  resources :events do
  	resources :registrations
  end

  root 'events#index'
  # get 'events' => 'events#index'
  # get 'events/:id' => 'events#show', as: "event"
  # get 'events/:id/edit' => 'events#edit', as: "edit_event"
  # patch 'events/:id' => 'events#update'

  

end

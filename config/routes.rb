Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  root 'welcome#index'
  resources :sessions
  resources :users
  
  resources :cohorts do
    resources :contacts
  end

  match "/auth/:provider/callback" => "sessions#slack", :via => [:get, :post]

end

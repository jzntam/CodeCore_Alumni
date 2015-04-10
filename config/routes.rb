Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  root 'cohorts#index'
  resources :sessions
  resources :users
  
  resources :cohorts do
    resources :contacts
  end

end

Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  root 'cohorts#index'
  resources :sessions
  resources :users
  
  resources :cohorts, only: [:index, :show] do
    resources :contacts
  end

end

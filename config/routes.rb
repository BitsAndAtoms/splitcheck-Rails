Rails.application.routes.draw do
  
  resources :votes do
   member do
      get 'up_vote'
     end
        member do
      get 'down_vote'
     end
  end
  
  resources :favorites do
   member do
      get 'select_favorite'
     end
  end
  
  devise_for :users
  resources :users, only: [:show]
  
  resources :restaurants, except: [:destroy] do
  
  member do
      get 'new_comment'
  end
  
  resources :comments, only: [:create, :destroy]
  end
     

  root to: "restaurants#index"
  
  match '*a', :to => 'application#handling', via: :all

end

Rails.application.routes.draw do
  resources :users, except: [:index]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create,:show]
  root to: "sessions#new"
end

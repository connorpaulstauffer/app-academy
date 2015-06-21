Blogger::Application.routes.draw do

  root to: 'articles#index'

  resources :articles do
    resources :comments do
      member do
        post :upvote
        post :downvote
      end
    end
    member do
      post :upvote
      post :downvote
    end
  end

  resources :tags, only: [:index, :show]

  resources :authors

  resources :author_sessions, only: [ :new, :create, :destroy ]
  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'

end

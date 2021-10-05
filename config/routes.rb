Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show)

  scope '(:locale)' do
    resources :books
    resources :users, except: :create do
      member do
        get :followeds, :followers
      end
    end
    resource :user_icons, only: :destroy
    resources :follow_relationships, only: %I[create destroy] 
  end
end

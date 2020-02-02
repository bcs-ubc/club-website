Rails.application.routes.draw do
    devise_for :users
    devise_scope :user do
        get 'login', to: 'devise/sessions#new'
        get 'logout', to: 'devise/sessions#destroy'
        get 'signup', to: 'devise/registrations#new'
    end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'pages#home'
    get 'about', to: 'pages#about'

    resources :articles

    resources :users, except: [:new, :show]
    get ':id', to: 'users#show'


    # Commented :users out as Devise is handling it
    # get 'signup', to: 'users#new'

    # get 'login', to: 'sessions#new'
    # post 'login', to: 'sessions#create'
    # delete 'logout', to: 'sessions#destroy'
end

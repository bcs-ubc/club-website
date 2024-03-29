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
    get 'contact', to: 'pages#contact'

    # Custom events routes
    get 'events/hackathon-2020', to: 'articles#hackathon2020'

    resources :articles, path: 'events'

    resources :users, except: [:new, :show]
    get ':id', to: 'users#show'

    # Commented :users out as Devise is handling it
    # get 'signup', to: 'users#new'

    # get 'login', to: 'sessions#new'
    # post 'login', to: 'sessions#create'
    # delete 'logout', to: 'sessions#destroy'
end

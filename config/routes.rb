Rails.application.routes.draw do
  # 管理者側のルーティング
  devise_for :admins, controllers:{
    sessions: 'admins/sessions'
  }

  namespace :admins do
    resources :genres,only: [:new,:create,:index,:edit,:update]
    resources :places,only: [:index,:show,:edit,:new] do
      collection { post :import }
    end
    resources :routes,only: [:index,:show]
    resources :users,only: [:index,:edit,:update]
    get '/' => 'home#top', as: 'top'
  end


  # ユーザー側のルーティング
  devise_for :users, controllers:{
    sessions: 'publics/sessions',
    registrations: 'publics/registrations'
  }

  scope module: :publics do
    get 'users/routes' => 'users#routes',as: 'user_routes'
    patch 'users/:id/hide' => 'users#hide',as: 'users_hide'
    get 'users/switch_table' => 'users#switch_table',as: 'users_switch_table'
    resources :users,only: [:show,:edit,:update] do
      get 'following' => 'relations#following'
      get 'follower' => 'relations#follower'
    end
    resources :places,only: [:new,:create,:index,:show,:edit,:update]
    resources :routes,only: [:new,:create,:index,:show,:edit,:destroy] do
      resource :likes,only: [:create,:destroy]
    end
    patch 'routes/:id/draft' => 'routes#draft',as: 'route_draft'
    patch 'routes/:id/release' => 'routes#release',as: 'route_release'
    resources :spots,only: [:create,:destroy] do
      get 'autocomplete', on: :collection
    end
    resources :relations,only: [:create,:destroy]
    resource :wishes,only: [:create,:destroy]
    resource :wents,only: [:create,:destroy]
    get 'search' => 'search#search'
    post 'image_search' => 'search#image_search'
  end

  root to: 'home#top'
  get 'about' => 'home#about'

end
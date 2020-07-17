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
    get 'top' => 'home#top', as: 'top'
  end


  # ユーザー側のルーティング
  devise_for :users, controllers:{
    sessions: 'publics/sessions',
    registrations: 'publics/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :publics do
    get 'users/routes' => 'users#routes',as: 'user_routes'
    resources :users,only: [:show,:edit,:update]
    resources :places,only: [:new,:create,:index,:show,:edit,:update]
    resources :routes,only: [:new,:create,:index,:show,:edit,:destroy]
    patch 'routes/:id/draft' => 'routes#draft',as: 'route_draft'
    patch 'routes/:id/release' => 'routes#release',as: 'route_release'
    resources :spots,only: [:create,:destroy] do
      get 'autocomplete', on: :collection
    end
  end


  root to: 'home#top'




end

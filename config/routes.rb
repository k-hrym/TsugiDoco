Rails.application.routes.draw do
  # 管理者側のルーティング
  devise_for :admins, controllers:{
    sessions: 'admins/sessions'
  }

  namespace :admins do
    resources :genres,only: [:new,:create,:index]
  end


  # ユーザー側のルーティング
  devise_for :users, controllers:{
    sessions: 'publics/sessions',
    registrations: 'publics/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :publics do
    resources :users,only: [:show,:edit,:update]
    resources :places,only: [:new,:create,:index,:show,:edit,:update]
    resources :routes,only: [:new,:create,:index,:show,:edit]
    patch 'routes/:id/update_all' => 'routes#update_all',as: 'route_update_all'
    patch 'spots/:id/add' => 'spots#add',as: 'add_spot'
    resources :spots,only: [:create,:destroy] do
      get 'autocomplete', on: :collection
    end
  end


  root to: 'home#top'




end

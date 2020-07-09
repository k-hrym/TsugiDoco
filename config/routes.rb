Rails.application.routes.draw do
  # 管理者側のルーティング
  devise_for :admins, controllers:{
    sessions: 'admins/sessions'
  }

  namespace :admins do

  end


  # ユーザー側のルーティング
  devise_for :users, controllers:{
    sessions: 'publics/sessions',
    registrations: 'publics/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :publics do
    resources :users,only: [:show,:edit,:update]
  end


  root to: 'home#top'




end

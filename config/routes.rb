# frozen_string_literal: true

Rails.application.routes.draw do
    namespace :admin do
      resources :users
      resources :drivers
      resources :requests
      resources :reviews
      resources :carpools
      resources :messages
      resources :user_in_carpools
      resources :reports

      root to: "users#index"

      controller :admin do
        get '/admin/users'
      end
    end
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
                     path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root 'home#index'
  get 'home/index'
  get 'home/guest'
  get 'home/aboutus'
  get 'home/favorites'
  get 'home/inbox'
  get 'home/notifications'
  get 'home/admin'
  get '/home/:id', to: 'home#show', as: 'user_show'
  
  get 'carpools/index'
  get 'carpools/user_rides/:id', to: 'carpools#user_rides', as: 'user_rides'
  get 'carpools/rides_im_in'
  get '/carpool/:id', to: 'carpools#show', as: 'carpool'
  get '/carpool/chatroom/:id', to: 'carpools#chatroom', as: 'carpool_chatroom'
  get '/carpools/new', to: 'carpools#new'
  post '/carpools', to: 'carpools#create'
  get '/carpools/:id/edit', to: 'carpools#edit', as: 'carpools_edit'
  patch '/carpool/:id', to: 'carpools#update'
  delete '/carpool/:id', to: 'carpools#delete'
  get '/carpools/new_from_campus', to: 'carpools#new_from_campus'
  get '/carpools/new_to_campus', to: 'carpools#new_to_campus'
  get 'search', to: 'carpools#search'

  get '/message/new/:carpool_id', to: 'messages#new', as: 'new_carpool_message'
  post '/messages', to: 'messages#create'


  get 'requests/index'
  get 'requests/my_requests'
  delete '/request/:id', to: 'requests#destroy'

  resources :requests do
    member do
      get :request_ride
      get :accept
      get :reject
    end
  end

  resources :favorites do
    member do
      get :add_favorite
      get :remove_favorite
    end
  end

  resources :carpools do
    member do
      get :notify_covid
      get :user_leave
      get :toggle_open_for_request
    end
  end

  resources :users_in_carpool do
    member do
      get :remove_from_carpool
    end
  end

  get 'drivers/index'
  get '/driver/:id', to: 'drivers#show', as: 'driver'
  get 'drivers/new', to: 'drivers#new'
  post 'drivers', to: 'drivers#create'
  get '/drivers/:id/edit', to: 'drivers#edit', as: 'drivers_edit'
  patch '/driver/:id', to: 'drivers#update'
  delete '/driver/:id', to: 'drivers#delete'

  resources :reviews, path_names:{new: 'new/:to_user_id/:carpool_id'}
  get 'reviews/my_reviews/:user_id', to: 'reviews#my_reviews', as: 'my_reviews'
  get 'reviews/reviews_user/:user_id', to: 'reviews#reviews_user', as: 'reviews_user'
  delete 'review/:id', to: 'reviews#destroy'
  get '/reviews/:id/edit', to: 'reviews#edit', as: 'reviews_edit'
  patch '/review/:id', to: 'reviews#update'

  resources :reports, path_names:{new: 'new/:to_user_id'}
  get '/reports/index'

  resources :reports do
    member do 
      get :ban_user
      get :unban_user
    end
  end

end

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  scope '/me', module: 'me', as: :me do
    resources :movies
  end

  scope '/api', module: 'api' do
    post :login, to: 'login#call'
    get :movies, to: 'get_movies#call'

    scope 'me', module: 'me' do
      post 'movies/share', to: 'share_movie#call'
    end
  end

  root 'movies#index'

  get :version, to: 'api/application#version'
end

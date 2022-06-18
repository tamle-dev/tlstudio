Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  scope '/me', module: 'me', as: :me do
    resources :movies
  end

  scope '/api', module: 'api', as: :api do
    post 'users/login', to: 'login#call'
  end

  root 'movies#index'
end

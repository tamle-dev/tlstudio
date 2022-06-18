Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  scope '/me', module: 'me', as: :me do
    resources :movies
  end

  root 'movies#index'
end

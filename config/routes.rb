Rails.application.routes.draw do
  #delete sign_up controller
  devise_for :admins, skip: [:registration]

  devise_scope :admin do
    get "signin" => "devise/sessions#new" #devise is namespace , sessions is controller , new is action
  end

  namespace :admin do
    root "dashboard#index"
    get "dashboard" => "dashboard#index", as: "dashboard"
    resources :admins
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

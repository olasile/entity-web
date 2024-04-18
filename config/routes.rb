Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "entities#index"

  resources :entities
  resources :auth, only: [:new, :create] do
    collection do
      delete :sign_out
    end
  end
  namespace :entity do
    resources :fields
  end
end

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :schools do
    get 'teachers/confirmations/:token', to: 'confirmations#edit'
    patch 'teachers/confirmations/:token', to: 'confirmations#update'
    resources :teachers
    resources :school_classes do
      resources :school_applications
    end
  end
  resources :students
end

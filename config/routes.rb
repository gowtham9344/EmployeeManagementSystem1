Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  as :admin do
    get 'admins/sign_up', to: redirect('/admins/sign_in')
  end

  devise_for :users
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :employees
  resources :teams
  root 'welcome#index'
end

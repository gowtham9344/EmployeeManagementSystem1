Rails.application.routes.draw do
  get 'passwords/edit'
  get 'passwords/update'
  get 'welcome/index'

  get "password" , to: 'passwords#edit', as: :edit_password
  patch "password" , to: 'passwords#update', as: :update_password

  get 'teams/search'

  get 'employees/search'

  

  get 'login' , to: 'sessions#new'
  delete 'logout' ,  to: 'sessions#destroy'

  post 'login' , to:'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :employees
  resources :teams
  root 'welcome#index'

  get '*path', to: 'application#page_not_found'
end

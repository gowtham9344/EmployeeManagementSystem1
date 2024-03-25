Rails.application.routes.draw do
  get 'welcome/index'

  get 'teams/search'

  get 'employees/search'

  get 'login' , to: 'sessions#new'
  delete 'logout' ,  to: 'sessions#destroy'

  post 'login' , to:'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :employees
  resources :teams
  root 'welcome#index'
end

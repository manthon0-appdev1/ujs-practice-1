Rails.application.routes.draw do
  root "tasks#index"

  devise_for :users
  resources :tasks
  get 'tasks/:id/move', to: 'tasks#move', as: :move_task


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

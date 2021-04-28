Rails.application.routes.draw do
  namespace :api do
    get 'todos/show'
    get 'todos/index'
    get 'todos/create'
    get 'todos/update'
    get 'todos/destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

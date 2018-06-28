Rails.application.routes.draw do
  get 'a/index'
  get 'a/show'
  get 'a/update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  root 'a#index' #index page
end

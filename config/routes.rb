Rails.application.routes.draw do
  get 'dictionary/index'
  root 'dictionary#index'
  
  get '/search' => 'dictionary#search'
end

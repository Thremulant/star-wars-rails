Rails.application.routes.draw do
  root 'films#index'
  # get '/films', to: 'films#index'
  get '/characters', to: 'characters#index'
  get '/species', to: 'species#index'
  get '/planets', to: 'planets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

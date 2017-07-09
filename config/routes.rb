Rails.application.routes.draw do
  root 'welcome#index'
  get '/contact', to: 'contact#new'
  post '/contact', to: 'contact#create'
end

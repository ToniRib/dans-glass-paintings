Rails.application.routes.draw do
  root 'welcome#index'
  get '/contact', to: 'contact#show'
  post '/contact', to: 'contact#create'
end

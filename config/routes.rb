Rails.application.routes.draw do
  namespace :api do
    post '/api/runs', to: 'runs#create'
  end
end

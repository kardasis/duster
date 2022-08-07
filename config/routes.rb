Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :run_summaries, only: %i[index show destroy] do
    post 'duplicate'
  end
  resource :run, only: %i[show]

  namespace :api do
    resources :runs, only: %i[create show] do
      resources :run_summaries, only: :create
    end
    resources :run_summaries, only: [:show]
    post 'run/:run_id/datapoints', to: 'datapoints#add'
    post 'device_connected', to: 'devices#connect'
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  namespace :api do
    resources :runs, only: %i[create show] do
      resources :run_summaries, only: :create
    end
    post 'run/:run_id/datapoints', to: 'datapoints#add'
  end
end

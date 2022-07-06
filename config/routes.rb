# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  namespace :api do
    resource :runs, only: %i[create show]
    post 'run/:run_id/datapoints', to: 'datapoints#add'
  end
end

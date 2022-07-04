# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resource :runs, only: %i[create show]
    post 'datapoints/:run_id', to: 'datapoints#add'
  end
end

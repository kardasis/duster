# frozen_string_literal: true

require 'rails_helper'

describe Api::RunsController do
  describe 'GET run' do
    it 'returns the run' do
      run = create(:run)
      get :show, params: { id: run.id }
      expect(JSON.parse(response.body)['id']).to match(run.id)
    end
  end

  describe 'POST run' do
    it 'returns a 200' do
      post :create

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['id']).to be_a_valid_uuid
    end
  end
end

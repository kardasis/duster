# frozen_string_literal: true

require 'rails_helper'

describe Api::RunsController do
  describe 'POST run' do
    it 'returns a 200' do
      uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

      post :create

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['run_id']).to match(uuid_regex)
    end
  end
end

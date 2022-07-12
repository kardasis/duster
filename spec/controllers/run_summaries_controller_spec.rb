# frozen_string_literal: true

require 'rails_helper'

describe RunSummariesController do
  describe 'GET run' do
    it 'returns a 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end

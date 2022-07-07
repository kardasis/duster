# frozen_string_literal: true

require 'rails_helper'

describe RunSummariesController do
  describe 'GET run' do
    it 'returns a 200' do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template(:run_summaries)
    end
  end
end

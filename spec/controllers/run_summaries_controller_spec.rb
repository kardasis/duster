require 'rails_helper'

describe RunSummariesController do
  describe 'DELETE run_summary' do
    it 'deletes a run summary' do
      rs = create :run_summary
      delete :destroy, params: { id: rs.id }
      expect(RunSummary.exists?(rs.id)).to be false
    end
  end

  describe 'POST run_summary' do
    it 'creates the RunSummary' do
      post :create, params: { run_summary: {
        start_time: Time.new(2022, 8, 13, 1, 2, 3).utc,
        total_distance: 3.345,
        total_time: 2012
      } }

      rs = RunSummary.last
      expect(Run.last.start_time).to eq(Time.new(2022, 8, 13, 1, 2, 3).utc)
      expect(rs.start_time).to eq(Time.new(2022, 8, 13, 1, 2, 3).utc)
      expect(rs.total_distance).to eq(3.345)
      expect(rs.total_time).to eq(2012)
    end
  end

  describe 'GET run_summary' do
    it 'returns a 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end

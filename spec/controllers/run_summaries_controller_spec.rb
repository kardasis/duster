require 'rails_helper'

describe RunSummariesController do
  describe 'DELETE run_summary' do
    it 'deletes a run summary' do
      rs = create :run_summary
      delete :destroy, params: { id: rs.id }
      expect(RunSummary.exists?(rs.id)).to be false
    end
  end

  describe 'GET run_summary' do
    it 'returns a 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'duplication' do
    it 'should duplicate the run_summary' do
      allow(Time).to receive(:now).and_return(Time.new(2002, 10, 31, 2, 2, 2).utc)

      rs = create :run_summary

      allow(Time).to receive(:now).and_return(Time.new(2012, 11, 1, 4, 4, 4).utc)

      post :duplicate, params: { run_summary_id: rs.id }

      json_response = JSON.parse response.body
      expect(json_response[:id]).not_to eq rs.id
      expect(json_response['start_time']).not_to eq(rs.start_time.iso8601(3))
      expect(json_response['total_distance'].to_f).to eq(rs.total_distance.to_f)
      expect(json_response['total_time'].to_f).to eq(rs.total_time.to_f)
    end
  end
end

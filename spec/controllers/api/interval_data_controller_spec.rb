require 'rails_helper'

describe Api::IntervalDataController do
  describe 'GET show' do
    it 'should return json' do
      s3_client = Aws::S3::Client.new

      data = (1..10).map do |_|
        { calories: 0.0923,
          immediate_speed: 7.65,
          time: 1234,
          distance: 1.234 }
      end
      json_data_string = data.to_json

      allow(s3_client).to receive_message_chain(:get_object, :body, :string).and_return(json_data_string)

      run = create :run

      get :show, params: { run_id: run.id }

      expect(JSON.parse(response.body).length).to eq(10)
    end
  end
end

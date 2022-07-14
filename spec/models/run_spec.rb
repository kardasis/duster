# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Run, type: :model do
  describe 'create new record' do
    it 'should have a valid id' do
      run = create :run
      expect(run.id).to be_a_valid_uuid
    end
  end

  describe '#tickstamps' do
    it 'should return tickstamps from the cache' do
      run = create :run
      RunDataStore.add run.id, [123, 234, 345]

      expect(run.tickstamps).to eq [111, 222]
    end

    it 'should fetch data from s3 if no tickstamps are in the cache' do
      s3_client = Aws::S3::Client.new
      json_data_string = { 'start_time' => 1_657_310_628, 'ticks' => [123, 987, 1234] }.to_json
      allow(s3_client).to receive_message_chain(:get_object, :body, :string).and_return(json_data_string)
      run = create :run

      expect(run.tickstamps).to eq [864, 1111]
    end
  end

  describe '#generate_summary' do
    it 'should create a summary with correct data' do
      run = create :run, :with_data
      run.generate_summary

      expect(run.summary.start_time).to eq run.start_time
      expect(run.summary.total_distance).to be
    end
  end
end

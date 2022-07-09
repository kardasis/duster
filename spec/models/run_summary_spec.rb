require 'rails_helper'

describe RunSummary, type: :model do
  describe '.create' do
    it 'should calculate basic fields' do
      run = create :run, :with_small_data
      RunSummary.from_run run
      expect(run.summary.run).to eq run
      expect(run.summary.start_time).to eq run.created_at
      expect(run.summary.total_time).to eq 444.0 / 1000
      expect(run.summary.distance_records).to be_empty
    end

    it 'should works on a larger run' do
      run = create :run, :with_data
      summary = RunSummary.from_run run
      expect(summary.distance_records.length).to be 2
    end
  end

  describe '.from_cold_store' do
    it 'should pull data from cold storage and create a run' do
      data = { start_time: 1_657_310_628, ticks: [123, 987, 1234] }
      key = 'abcd'
      bucket = 'xyz'
      allow(ColdDataStore).to receive(:fetch_s3_data).with(bucket, key).and_return(data)

      summary = RunSummary.from_s3_bucket bucket, key
      expect(summary.total_time).to eq 1111 / 1000
    end
  end
end

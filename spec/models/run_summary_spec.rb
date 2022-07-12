require 'rails_helper'

describe RunSummary, type: :model do
  describe '.create' do
    it 'should calculate basic fields' do
      run = create :run, :with_small_data
      RunSummary.from_run run
      expect(run.summary.run).to eq run
      expect(run.summary.start_time).to eq run.created_at.round
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
      data = { 'startTime' => 1_657_310_628, 'ticks' => [123, 987, 1234] }
      key = 'abcd'
      bucket = 'xyz'
      allow(ColdDataStore).to receive(:fetch_s3_data).with(bucket, key).and_return(data)

      summary = RunSummary.from_s3_bucket bucket, key
      expect(summary.total_time).to eq 1111 / 1000
      expect(summary.start_time.to_i).to eq 1_657_310_628
    end

    it 'should fail if the run already exists' do
      run = create :run, :with_small_data
      rs = RunSummary.from_run run
      rs.save

      key = "run-#{run.start_time.to_i}.json"
      bucket = 'xyz'

      summary = RunSummary.from_s3_bucket bucket, key
      expect(summary).to be nil
    end
  end
end

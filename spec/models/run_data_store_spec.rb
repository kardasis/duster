# frozen_string_literal: true

require 'rails_helper'

describe RunDataStore, type: :model do
  describe '.add' do
    it 'should update internal data' do
      run_id = 'abc'
      RunDataStore.add run_id, [34, 123]

      expect(RunDataStore.get(run_id)).to eq [34, 123]
    end
  end

  describe '.take' do
    it 'should fetch the data and remove it' do
      run_id = 'abc'
      RunDataStore.add run_id, [34, 123]
      data = RunDataStore.take run_id

      expect(RunDataStore.get(run_id)).to be_nil
      expect(data).to eq [34, 123]
    end
  end

  describe '.remove' do
    it 'should remove data for the run' do
      run_id = 'abc'
      RunDataStore.add run_id, [34, 123]
      RunDataStore.remove run_id
      expect(RunDataStore.get(run_id)).to be_nil
    end
  end
end

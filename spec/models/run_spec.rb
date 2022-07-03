require 'rails_helper'

RSpec.describe Run, type: :model do
  describe 'create new record' do
    it 'should have a run_id' do
      uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
      run = create(:run)

      expect(run.run_id).to match(uuid_regex)
    end
  end
end

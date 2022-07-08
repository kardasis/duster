# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Run, type: :model do
  describe 'create new record' do
    it 'should have a id' do
      run = create(:run)
      expect(run.id).to be_a_valid_uuid
    end
  end
end

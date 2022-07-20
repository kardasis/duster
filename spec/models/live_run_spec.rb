require 'rails_helper'

describe LiveRun, type: :model do
  describe '#total_time' do
    it 'should update the client with fresh data' do
      allow(RunChannel).to receive(:broadcast_to)
      lr = create :live_run, :in_progress

      lr.update_with((2..100).map { |x| (x * 100).to_s })

      expect(RunChannel).to have_received(:broadcast_to)
        .with(lr.run, {
                total_time: '00:00:09',
                total_distance: '0.0098'
              })
    end
  end
end

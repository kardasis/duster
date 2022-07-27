require 'rails_helper'

describe LiveRun, type: :model do
  describe '#total_time' do
    it 'should update the client with fresh data' do
      allow(RunChannel).to receive(:broadcast_to)
      lr = create :live_run, :in_progress

      lr.update_with((2..100).map { |x| (x * 100).to_s })

      expect(RunChannel).to have_received(:broadcast_to)
        .with(lr.run, {
                intervalTicks: [[9.9, 3.4738292011019287]],
                stats: {
                  'total-time': '0:09',
                  'total-distance': '0.0097',
                  'average-speed': '3.510',
                  'average-pace': '17:05',
                  speed: '3.474',
                  pace: '17:16'
                }
              })
    end
  end
end

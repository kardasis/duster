require 'rails_helper'

describe LiveRun, type: :model do
  describe '#total_time' do
    it 'should update the client with fresh data' do
      allow(RunChannel).to receive(:broadcast_to)
      lr = create :live_run, :in_progress

      lr.update_with((2..100).map { |x| (x * 100).to_s })

      expect(RunChannel).to have_received(:broadcast_to)
        .with(lr.run, {
                intervalTicks: [[9.9, 3.5095886976919077]],
                stats: {
                  'average-pace': '16:55',
                  'average-speed': '3.545',
                  pace: '17:05',
                  speed: '3.510',
                  'total-time': '0:09',
                  'total-distance': '0.0097'
                }
              })
    end
  end
end

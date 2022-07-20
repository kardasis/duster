require 'rails_helper'

RSpec.describe RunChannel, type: :channel do
  it 'should subscribe to new runs' do
    subscribe
    expect(subscription).to be_confirmed
  end

  it 'should successfully subscribe to a run' do
    run = create :run
    subscribe run_id: run.id
    expect(subscription).to be_confirmed
  end
end

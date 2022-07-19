require 'rails_helper'

RSpec.describe RunChannel, type: :channel do
  it 'successfully subscribes' do
    run = create :run
    subscribe run_id: run.id
    expect(subscription).to be_confirmed
  end
end

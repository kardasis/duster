# frozen_string_literal: true

FactoryBot.define do
  factory :run do
    start_time { Time.now.utc.round }

    trait :with_small_data do
      after(:create) do |run|
        RunDataStore.add run.id, [123, 345, 567]
      end
    end

    trait :with_data do
      after(:create) do |run|
        data = (0...10_000).map do |i|
          (i * 50) - (i * i / 10_000_000)
        end
        RunDataStore.add run.id, data
      end
    end
  end
end

FactoryBot.define do
  factory :run_summary do
    run
    total_time { 3600 }
    total_distance { 10.0 }
    start_time { Time.now.utc }

    trait :with_distance_records do
    association :run, :with_data
      after(:create) do |summary|
        summary.calculate_distance_records(summary.run.tickstamps)
      end
    end
  end
end

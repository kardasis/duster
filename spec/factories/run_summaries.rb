FactoryBot.define do
  factory :run_summary do
    run
    total_time { 3600 }
    total_distance { 10.0 }
    start_time { Time.now.utc }
  end
end

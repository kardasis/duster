FactoryBot.define do
  factory :run_summary do
    run
    total_time { '9.99' }
    total_distance { '9.99' }
  end
end

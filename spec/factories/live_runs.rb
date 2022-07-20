FactoryBot.define do
  factory :live_run do
    run

    trait :in_progress do
      first_tickstamp { 100 }
    end
  end
end

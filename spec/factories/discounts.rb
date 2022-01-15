FactoryBot.define do
  factory :discount do
    sequence(:percent, 1) do |n|
      n % 100 == 0 ? 1 : n % 100
    end
    sequence(:threshold, 1)

    merchant
  end
end

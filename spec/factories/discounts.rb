FactoryBot.define do
  factory :discount do
    sequence(:percent, 1) do |n|
      n % 99 == 0 ? 1 : n % 99
    end
    sequence(:threshold, 1)

    merchant
  end
end

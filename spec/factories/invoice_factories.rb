FactoryGirl.define do
  factory :invoice do
    amount_cents 100
    date Date.new(2013, 3, 14)
    paid false

    factory :paid_invoice do
      paid true
    end
  end
end

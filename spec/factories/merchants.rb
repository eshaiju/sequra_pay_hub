# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    reference { 'MyString' }
    email { 'MyString' }
    live_on { '2023-10-15' }
    payout_frequency { 1 }
    minimum_monthly_fee { '9.99' }
  end
end

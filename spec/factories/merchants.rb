# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    reference { 'wintheiser_bernhard' }
    email { 'info@wintheiser-bernhard.com' }
    live_on { Time.zone.today }
    disbursement_frequency { 'daily' }
    minimum_monthly_fee { 15.0 }
  end

  factory :second_merchant, class: 'Merchant' do
    reference { 'another_merchant_reference' }
    email { 'another_merchant@example.com' }
    live_on { Time.zone.today }
    disbursement_frequency { 'weekly' }
    minimum_monthly_fee { 20.0 }
  end
end

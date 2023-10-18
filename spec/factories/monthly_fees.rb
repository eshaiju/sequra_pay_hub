# frozen_string_literal: true

FactoryBot.define do
  factory :monthly_fee do
    merchant { create(:merchant) }
    total_commissions { 9.99 }
    monthly_fee { 1.6 }
    month { '2023-10-18' }
  end
end

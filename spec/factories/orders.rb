# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    merchant { create(:merchant) }
    amount { 100 }
    order_date { Time.zone.today }
  end
end

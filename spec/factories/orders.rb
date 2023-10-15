# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    merchant { nil }
    amount { '9.99' }
    order_date { '2023-10-15' }
  end
end

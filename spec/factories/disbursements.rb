# frozen_string_literal: true

FactoryBot.define do
  factory :disbursement do
    merchant { create(:merchant) }
    reference { 'MyString' }
    disbursement_date { '2023-10-15' }
    total_amount { '9.99' }
    total_fee { '9.99' }
  end
end

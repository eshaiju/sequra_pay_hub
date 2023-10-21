# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe MonthlyFeeCalculatorJob do
  it 'performs monthly fee calculation for a merchant' do
    merchant = create(:merchant)
    date = Date.current.beginning_of_month

    expect do
      described_class.perform_async(merchant.id, date.to_s)
    end.to change(MonthlyFee, :count).by(1)

    monthly_fee = MonthlyFee.last

    expect(monthly_fee.month).to eq(date.beginning_of_month)
    expect(monthly_fee.merchant_id).to eq(merchant.id)
  end
end

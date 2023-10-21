# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CreateMonthlyFeesJob do
  it 'enqueues MonthlyFeeCalculatorJob for eligible merchants' do
    eligible_merchant = create(:merchant, live_on: 1.month.ago.to_date)
    ineligible_merchant = create(:second_merchant, live_on: 1.month.from_now.to_date)

    allow(MonthlyFeeCalculatorJob).to receive(:perform_async)

    specified_date = Time.zone.today
    described_class.perform_async(specified_date.to_s)
    described_class.drain

    expect(MonthlyFeeCalculatorJob).to have_received(:perform_async)
      .with(eligible_merchant.id, specified_date.to_s)
      .once

    expect(MonthlyFeeCalculatorJob).not_to have_received(:perform_async)
      .with(ineligible_merchant.id, specified_date.to_s)
  end

  it 'defaults to calculating the previous month for eligible merchants' do
    eligible_merchant = create(:merchant, live_on: 2.months.ago.to_date)
    specified_date = Date.current.beginning_of_month.prev_month

    allow(MonthlyFeeCalculatorJob).to receive(:perform_async)

    described_class.perform_async
    described_class.drain

    expect(MonthlyFeeCalculatorJob).to have_received(:perform_async)
      .with(eligible_merchant.id, specified_date.strftime('%Y-%m-%d'))
      .once
  end
end

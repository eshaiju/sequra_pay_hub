# frozen_string_literal: true

class CreateMonthlyFeesJob
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(date)
    date ||= Date.current.beginning_of_month

    Merchant.select(:id, :live_on).find_each do |merchant|
      next if merchant.live_on > date.to_date

      MonthlyFeeCalculatorJob.perform_async(merchant.id, date.to_s)
    end
  end
end

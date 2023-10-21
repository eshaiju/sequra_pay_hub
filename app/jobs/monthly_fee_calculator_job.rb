# frozen_string_literal: true

class MonthlyFeeCalculatorJob
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(merchant_id, date)
    Rails.logger.info("Started the monthly fee generation process for #{date} for Merchant ID: #{merchant_id}...")

    MonthlyFeeCalculatorService.new(merchant_id, date.to_date).call
  end
end

# frozen_string_literal: true

class DisbursementJob
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(merchant_id, date)
    Rails.logger.info("Started the disbursement process for #{date} for Merchant ID: #{merchant_id}...")

    DisbursementService.new(merchant_id, date.to_date).call
  end
end

# frozen_string_literal: true

class CreateDisbursementsJob
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(date = nil)
    date ||= Time.zone.yesterday

    Merchant.select(:id).find_each do |merchant|
      DisbursementJob.perform_async(merchant.id, date.to_s)
    end
  end
end

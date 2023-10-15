# frozen_string_literal: true

class MerchantFactory
  def self.build(row:)
    new(row: row).build
  end

  def initialize(row:)
    @row = row
  end

  def build
    save_merchant_details
  end

  private

  attr_reader :row

  def save_merchant_details
    merchant.update!({
                       reference: row['reference'],
                       email: row['email'],
                       live_on: row['live_on'],
                       disbursement_frequency: row['disbursement_frequency']&.downcase&.to_sym,
                       minimum_monthly_fee: row['minimum_monthly_fee'].to_f
                     })
  end

  def merchant
    @merchant ||= Merchant.find_or_create_by!(reference: row['reference'])
  end
end

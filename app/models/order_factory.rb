# frozen_string_literal: true

class OrderFactory
  def self.build(row:)
    new(row: row).build
  end

  def initialize(row:)
    @row = row
  end

  def build
    save_order_details
  end

  private

  attr_reader :row

  def save_order_details
    if merchant.blank?
      Rails.logger.error("Merchant not found for reference: #{row['merchant_reference']}")
      return
    end

    Order.create!({
                    merchant: merchant,
                    amount: row['amount'].to_f,
                    order_date: row['created_at']
                  })
  end

  def merchant
    @merchant ||= Merchant.find_by(reference: row['merchant_reference'])
  end
end

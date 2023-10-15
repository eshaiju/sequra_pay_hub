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
    Order.create!({
                    merchant: find_or_create_merchant,
                    amount: row['amount'].to_f,
                    order_date: row['created_at']
                  })
  end

  def find_or_create_merchant
    Merchant.find_or_create_by!(reference: row['merchant_reference'])
  end
end

# frozen_string_literal: true

class DisbursementService
  attr_reader :merchant_id, :date, :date_week_ago

  def initialize(merchant_id, date)
    @merchant_id = merchant_id
    @date = date
    @date_week_ago = @date - 7.days
  end

  def call
    return if orders.empty?

    total_fee = calculate_total_fee(orders)

    ActiveRecord::Base.transaction do
      disbursement = find_or_initialize_disbursement
      disbursement.total_amount = orders.sum(&:amount)
      disbursement.total_fee = total_fee
      disbursement.save!

      update_orders(disbursement.id)
    end
  end

  private

  def find_or_initialize_disbursement
    Disbursement.find_or_initialize_by(merchant_id: merchant_id,
                                       disbursement_date: date,
                                       disbursement_type: 'confirmation')
  end

  def calculate_total_fee(merchant_orders)
    merchant_orders.reduce(0) do |fee, order|
      fee + OrderCommissionCalculator.new(order).calculate_commission
    end
  end

  def update_orders(disbursement_id)
    Order.where(id: orders.pluck(:id)).update_all(disbursement_id: disbursement_id)
  end

  def orders
    @orders ||= OrderQueryService.new(merchant_id).orders(date, date_week_ago)
  end
end

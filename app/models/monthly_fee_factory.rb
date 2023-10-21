# frozen_string_literal: true

class MonthlyFeeFactory
  def initialize(merchant_id)
    @merchant_id = merchant_id
  end

  def create(fee_month, total_commissions, minimum_monthly_fee)
    amount_to_charge = [minimum_monthly_fee - total_commissions, 0].max

    monthly_fee = find_or_create_monthly_fee(fee_month)
    update_monthly_fee(monthly_fee, total_commissions, amount_to_charge)
  end

  private

  attr_reader :merchant_id

  def find_or_create_monthly_fee(fee_month)
    MonthlyFee.find_or_create_by(merchant_id: merchant_id, month: fee_month)
  end

  def update_monthly_fee(monthly_fee, total_commissions, monthly_fee_amount)
    monthly_fee.update(
      total_commissions: total_commissions,
      monthly_fee: monthly_fee_amount
    )
  end
end

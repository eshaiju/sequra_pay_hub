# frozen_string_literal: true

class MonthlyFeeFactory
  def initialize(merchant_id)
    @merchant_id = merchant_id
  end

  def create(fee_month, total_commissions, minimum_monthly_fee)
    amount_to_charge = [(minimum_monthly_fee - total_commissions), 0].max

    MonthlyFee.create!(
      merchant_id: merchant_id,
      month: fee_month,
      total_commissions: total_commissions,
      monthly_fee: amount_to_charge
    )
  end

  private

  attr_reader :merchant_id
end

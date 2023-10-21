# frozen_string_literal: true

class MonthlyFeeCalculatorService
  attr_reader :merchant_id, :fee_month

  def initialize(merchant_id, fee_month)
    @merchant_id = merchant_id
    @fee_month = fee_month
  end

  def call
    total_commissions = calculate_total_commissions

    return if total_commissions > minimum_monthly_fee

    create_monthly_fee(total_commissions)
  end

  private

  def disbursements
    Disbursement.where(merchant_id: merchant_id, disbursement_date: fee_month.all_month)
  end

  def calculate_total_commissions
    disbursements.sum(&:total_fee)
  end

  def create_monthly_fee(total_commissions)
    MonthlyFeeFactory.new(merchant_id).create(fee_month, total_commissions, minimum_monthly_fee)
  end

  def minimum_monthly_fee
    merchant.minimum_monthly_fee
  end

  def merchant
    @merchant = Merchant.find_by_id(merchant_id)
  end
end

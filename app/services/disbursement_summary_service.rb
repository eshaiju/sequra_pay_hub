# frozen_string_literal: true

class DisbursementSummaryService
  def self.generate_summary(year)
    disbursements = fetch_disbursements(year)
    fee_stats_by_year = calculate_monthly_fees_stats(year)

    {
      year: year,
      number_of_disbursements: disbursements.count,
      amount_disbursed: calculate_sum(disbursements, :total_amount),
      amount_of_order_fees: calculate_sum(disbursements, :total_fee),
      monthly_fees_number: fee_stats_by_year[:fees_number],
      monthly_fees_sum: fee_stats_by_year[:fees_sum]
    }
  end

  def self.fetch_disbursements(year)
    Disbursement.where(disbursement_date: Date.new(year, 1, 1)..Date.new(year, 12, 31))
  end

  def self.calculate_sum(records, attribute)
    records.sum(attribute).to_f
  end

  def self.calculate_monthly_fees_stats(year)
    monthly_fees = fetch_monthly_fees(year)
    fees_number = monthly_fees.count
    fees_sum = calculate_sum(monthly_fees, :monthly_fee)

    { fees_number: fees_number, fees_sum: fees_sum }
  end

  def self.fetch_monthly_fees(year)
    MonthlyFee.where(month: Date.new(year, 1, 1)..Date.new(year, 12, 31))
  end
end

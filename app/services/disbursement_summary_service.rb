# frozen_string_literal: true

class DisbursementSummaryService
  def self.generate_summary(year)
    disbursements = fetch_disbursements(year)

    {
      year: year,
      number_of_disbursements: disbursements.count,
      amount_disbursed: calculate_sum(disbursements, :total_amount),
      amount_of_order_fees: calculate_sum(disbursements, :total_fee)
    }
  end

  def self.fetch_disbursements(year)
    Disbursement.where(disbursement_date: Date.new(year, 1, 1)..Date.new(year, 12, 31))
  end

  def self.calculate_sum(records, attribute)
    records.sum(attribute).to_f
  end
end

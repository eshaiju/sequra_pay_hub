# frozen_string_literal: true

class MonthlyFee < ApplicationRecord
  belongs_to :merchant

  validates :merchant_id, :total_commissions, :monthly_fee, :month, presence: true
  validates :total_commissions, numericality: { greater_than: 0 }
end

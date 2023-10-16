# frozen_string_literal: true

class Disbursement < ApplicationRecord
  belongs_to :merchant

  validates :merchant_id, :disbursement_date, :total_amount, :total_fee, presence: true
  validates :reference, uniqueness: true
  validates :total_amount, :total_fee, numericality: { greater_than: 0 }
end

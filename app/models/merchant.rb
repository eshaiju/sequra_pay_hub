# frozen_string_literal: true

class Merchant < ApplicationRecord
  enum disbursement_frequency: { daily: 'daily', weekly: 'weekly' }

  validates :reference, :email, :live_on, :minimum_monthly_fee, :disbursement_frequency, presence: true
  validates :reference, :email, uniqueness: true
  validates :minimum_monthly_fee, numericality: { greater_than_or_equal_to: 0 }
end

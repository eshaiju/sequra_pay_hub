# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :merchant
  # belongs_to :cancellation_disbursement, class_name: 'Disbursement'

  validates :merchant_id, :amount, :order_date, presence: true
  validates :amount, numericality: { greater_than: 0 }
end

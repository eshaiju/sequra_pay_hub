# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :disbursements, optional: true
  belongs_to :cancellation_disbursement, class_name: 'Disbursement', optional: true

  validates :merchant_id, :amount, :order_date, presence: true
  validates :amount, numericality: { greater_than: 0 }
end

# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :merchant

  validates :merchant_id, :amount, :order_date, presence: true
  validates :amount, numericality: { greater_than: 0 }
end

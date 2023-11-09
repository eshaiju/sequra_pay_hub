# frozen_string_literal: true

class OrderQueryService
  attr_reader :merchant_id

  def initialize(merchant_id)
    @merchant_id = merchant_id
  end

  def orders(date, date_week_ago)
    Order.select(:id, :amount)
         .joins(:merchant)
         .where(merchant_id: merchant_id)
         .where(cancelled_at: nil)
         .where(<<~SQL.squish, date: date, date_week_ago: date_week_ago)
           (disbursement_frequency = 'daily' AND order_date = :date) OR
           (disbursement_frequency = 'weekly' AND
             EXTRACT(DOW FROM live_on) = EXTRACT(DOW FROM TIMESTAMP :date) AND
             order_date BETWEEN :date_week_ago AND :date)
         SQL
  end

  def cancelled_orders(date, date_week_ago)
    Order.select(:id, :amount)
         .joins(:merchant)
         .where(merchant_id: merchant_id)
         .where.not(cancelled_at: nil)
         .where(<<~SQL.squish, date: date, date_week_ago: date_week_ago)
           (disbursement_frequency = 'daily' AND order_date = :date) OR
           (disbursement_frequency = 'weekly' AND
             EXTRACT(DOW FROM live_on) = EXTRACT(DOW FROM TIMESTAMP :date) AND
             order_date BETWEEN :date_week_ago AND :date)
         SQL
  end
end

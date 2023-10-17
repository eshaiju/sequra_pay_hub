# frozen_string_literal: true

desc 'Creates disbursements for historical data'

task create_disbursements_for_historical_data: :environment do
  first_order = Order.order(:order_date).first
  last_order = Order.order(order_date: :desc).first

  return if first_order.nil? || last_order.nil?

  date_range = first_order.order_date..(last_order.order_date + 1.week)

  date_range.each do |date|
    CreateDisbursementsJob.perform_async(date.to_s)
  end
end

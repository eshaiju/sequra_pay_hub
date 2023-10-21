# frozen_string_literal: true

desc 'Creates monthly fee for historical data'

task create_monthly_fee_for_historical_data: :environment do
  first_order = Order.order(:order_date).first
  last_order = Order.order(order_date: :desc).first

  return if first_order.nil? || last_order.nil?

  first_date = first_order.order_date
  last_date = last_order.order_date

  current_date = first_date

  while current_date <= last_date
    CreateMonthlyFeesJob.perform_async(current_date.to_s)

    current_date = current_date.beginning_of_month + 1.month
  end
end

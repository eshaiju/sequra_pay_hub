# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderQueryService, type: :service do
  subject(:order_query_service) { described_class.new(merchant.id) }

  let(:merchant) { create(:merchant) }
  let(:date) { Date.current }
  let(:date_week_ago) { date - 7.days }

  describe '#orders' do
    it 'returns daily orders for a merchant' do
      daily_order = create(:order, merchant: merchant, order_date: date)

      result = order_query_service.orders(date, date_week_ago)

      expect(result).to include(daily_order)
    end

    it 'filter calcelled orders for merchant' do
      first_order = create(:order, merchant: merchant, order_date: date)
      second_order = create(:order, merchant: merchant, order_date: date, cancelled_at: Date.current)

      result = order_query_service.orders(date, date_week_ago)
      expect(result).to include(first_order)
      expect(result).not_to include(second_order)
    end

    it 'returns cancelled orders for merchant' do
      first_order = create(:order, merchant: merchant, order_date: date)
      cancelled_order = create(:order, merchant: merchant, order_date: date, cancelled_at: Date.current)

      result = order_query_service.cancelled_orders(date, date_week_ago)

      expect(result).not_to include(first_order)
      expect(result).to include(cancelled_order)
    end

    it 'returns weekly orders for a merchant' do
      merchant.update!(disbursement_frequency: 'weekly')
      weekly_order = create(:order, merchant: merchant, order_date: date)

      result = order_query_service.orders(date, date_week_ago)

      expect(result).to include(weekly_order)
    end

    it 'does not return orders for other merchants' do
      other_merchant = create(:second_merchant)
      create(:order, merchant: other_merchant, order_date: date)

      result = order_query_service.orders(date, date_week_ago)

      expect(result).to be_empty
    end

    it 'does not return orders outside the date range' do
      create(:order, merchant: merchant, order_date: date - 8.days)

      result = order_query_service.orders(date, date_week_ago)

      expect(result).to be_empty
    end
  end
end

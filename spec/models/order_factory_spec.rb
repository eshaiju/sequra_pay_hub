# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderFactory do
  describe '.build' do
    it 'creates and saves an order record' do
      row = {
        'merchant_reference' => 'merchant123',
        'amount' => '25.43',
        'created_at' => '2022-10-07'
      }

      expect do
        described_class.build(row: row)
      end.to change(Order, :count).by(1)

      created_order = Order.last
      expect(created_order.merchant.reference).to eq('merchant123')
      expect(created_order.amount).to eq(25.43)
      expect(created_order.order_date).to eq('2022-10-07'.to_date)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderFactory do
  before do
    Etl::Merchants.load
  end

  describe '.build' do
    it 'creates and saves an order record' do
      row = {
        'merchant_reference' => 'wintheiser_bernhard',
        'amount' => '25.43',
        'created_at' => '2022-10-07'
      }

      expect do
        described_class.build(row: row)
      end.to change(Order, :count).by(1)

      created_order = Order.last
      expect(created_order.merchant.reference).to eq('wintheiser_bernhard')
      expect(created_order.amount).to eq(25.43)
      expect(created_order.order_date).to eq('2022-10-07'.to_date)
    end
  end

  context 'when the merchant is not found' do
    let(:row) do
      {
        'merchant_reference' => 'non_existent_reference',
        'amount' => '100.00',
        'created_at' => '2023-10-15'
      }
    end

    it 'logs an error and does not create an order' do
      allow(Rails.logger).to receive(:error)

      described_class.build(row: row)

      expect(Order.count).to eq(0)

      expect(Rails.logger).to have_received(:error).with('Merchant not found for reference: non_existent_reference')
    end
  end
end

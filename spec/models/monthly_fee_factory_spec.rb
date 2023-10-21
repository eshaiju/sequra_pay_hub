# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MonthlyFeeFactory do
  subject(:monthly_fee_factory) { described_class.new(merchant_id) }

  let(:merchant) { create(:merchant, minimum_monthly_fee: 100.0) }
  let(:merchant_id) { merchant.id }
  let(:fee_month) { Date.current.beginning_of_month }
  let(:total_commissions) { 50.0 }
  let(:minimum_monthly_fee) { 100.0 }

  context 'when creating a monthly fee' do
    it 'creates a monthly fee record with correct attributes' do
      expect do
        monthly_fee_factory.create(fee_month, total_commissions, minimum_monthly_fee)
      end.to change(MonthlyFee, :count).by(1)

      created_monthly_fee = MonthlyFee.last
      expect(created_monthly_fee.merchant_id).to eq(merchant_id)
      expect(created_monthly_fee.month).to eq(fee_month)
      expect(created_monthly_fee.total_commissions).to eq(total_commissions)
      expect(created_monthly_fee.monthly_fee).to eq(50.0)
    end
  end
end

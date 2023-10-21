# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MonthlyFeeCalculatorService do
  let(:merchant) { create(:merchant, minimum_monthly_fee: 100.0) }
  let(:fee_month) { Date.current.beginning_of_month }
  let(:disbursement) { create(:disbursement, merchant: merchant, disbursement_date: fee_month) }

  before do
    create(:order, merchant: merchant, disbursement_id: disbursement.id, amount: 50.0)
  end

  context 'when merchant commission less than the minimum monthly fee' do
    it 'creates a monthly fee record with monthly_fee' do
      expect do
        described_class.new(merchant.id, fee_month).call
      end.to change(MonthlyFee, :count).by(1)

      created_monthly_fee = MonthlyFee.last
      expect(created_monthly_fee.merchant_id).to eq(merchant.id)
      expect(created_monthly_fee.month).to eq(fee_month)
      expect(created_monthly_fee.total_commissions).to eq(9.99)
      expect(created_monthly_fee.monthly_fee).to eq(90.01)
    end
  end

  context 'when merchant earns at least the minimum monthly fee' do
    it 'does not create a monthly fee record' do
      merchant.update!(minimum_monthly_fee: 1.0)

      expect do
        described_class.new(merchant.id, fee_month).call
      end.not_to change(MonthlyFee, :count)
    end
  end
end

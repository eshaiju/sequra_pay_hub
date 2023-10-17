# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DisbursementSummaryService, type: :service do
  describe '.generate_summary' do
    context 'when there are disbursements for the specified year' do
      let!(:merchant) { create(:merchant) }

      before do
        create(:disbursement, total_amount: 100, total_fee: 10, disbursement_date: Date.new(2022, 1, 15),
                              merchant: merchant)
        create(:disbursement, total_amount: 150, total_fee: 15, disbursement_date: Date.new(2022, 2, 20),
                              merchant: merchant)
      end

      it 'generates the summary for the specified year' do
        summary = described_class.generate_summary(2022)

        expect(summary[:year]).to eq(2022)
        expect(summary[:number_of_disbursements]).to eq(2)
        expect(summary[:amount_disbursed]).to eq(250.0)
        expect(summary[:amount_of_order_fees]).to eq(25.0)
      end
    end

    context 'when there are no disbursements for the specified year' do
      it 'returns a summary with zeros' do
        summary = described_class.generate_summary(2023)

        expect(summary[:year]).to eq(2023)
        expect(summary[:number_of_disbursements]).to eq(0)
        expect(summary[:amount_disbursed]).to eq(0.0)
        expect(summary[:amount_of_order_fees]).to eq(0.0)
      end
    end
  end
end

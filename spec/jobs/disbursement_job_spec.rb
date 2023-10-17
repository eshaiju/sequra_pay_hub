# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe DisbursementJob do
  it 'performs the disbursement for a merchant' do
    merchant = create(:merchant)
    order1 = create(:order, merchant: merchant, amount: 50)
    order2 = create(:order, merchant: merchant, amount: 100)

    expect do
      described_class.perform_async(merchant.id, Time.zone.today.to_s)
    end.to change(Disbursement, :count).by(1)

    disbursement = Disbursement.last

    expect(disbursement.total_amount).to eq(150)
    expect(disbursement.merchant_id).to eq(merchant.id)

    expect(order1.reload.disbursement_id).to eq(disbursement.id)
    expect(order2.reload.disbursement_id).to eq(disbursement.id)
  end
end

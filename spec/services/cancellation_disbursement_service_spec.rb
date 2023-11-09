# frozen_string_literal: true

require 'rails_helper'

describe CancellationDisbursementService do
  subject(:cancellation_disbursement_service) { described_class.new(merchant.id, Time.zone.now) }

  let(:merchant) { create(:merchant) }
  let(:small_order) { create(:order, merchant: merchant, amount: 40) }
  let(:medium_order) { create(:order, merchant: merchant, amount: 150) }
  let(:large_order) { create(:order, merchant: merchant, amount: 500) }
  let(:cancelled_order) { create(:order, merchant: merchant, amount: 150, cancelled_at: Time.current) }

  describe '#call' do
    context 'when there are orders for the merchant' do
      it 'creates a disbursement for cancelled orders and updates orders' do
        small_order
        large_order
        cancelled_order

        expect { cancellation_disbursement_service.call }.to change(Disbursement, :count).by(1)
        disbursement = Disbursement.last

        expect(disbursement.total_amount).to eq(cancelled_order.amount)
        expect(disbursement.total_fee).to eq(1.43)
        expect(disbursement.merchant_id).to eq(merchant.id)
        expect(disbursement.disbursement_type).to eq('cancellation')

        expect(small_order.reload.disbursement_id).not_to eq(disbursement.id)
        expect(large_order.reload.disbursement_id).not_to eq(disbursement.id)

        expect(cancelled_order.reload.disbursement_id).to eq(disbursement.id)
      end

      it 'is idempotent' do
        small_order
        large_order
        cancelled_order

        expect { cancellation_disbursement_service.call }.to change(Disbursement, :count).by(1)
        first_disbursement = Disbursement.last

        expect { cancellation_disbursement_service.call }.not_to change(Disbursement, :count)
        second_disbursement = Disbursement.last

        expect(second_disbursement).to eq(first_disbursement)
      end
    end

    context 'when there are no orders for the merchant' do
      it 'does not create a disbursement' do
        expect { cancellation_disbursement_service.call }.not_to change(Disbursement, :count)
      end
    end
  end
end

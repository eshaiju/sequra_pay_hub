# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CreateDisbursementsJob do
  context 'when a specific date is provided' do
    it 'enqueues DisbursementJob for each merchant with the provided date' do
      merchant1 = create(:merchant)
      merchant2 = create(:second_merchant)

      allow(DisbursementJob).to receive(:perform_async)

      specific_date = Time.zone.today.to_s
      described_class.perform_async(specific_date)
      described_class.drain

      expect(DisbursementJob).to have_received(:perform_async)
        .with(merchant1.id, specific_date)
        .once

      expect(DisbursementJob).to have_received(:perform_async)
        .with(merchant2.id, specific_date)
        .once
    end
  end

  context 'when no specific date is provided' do
    it 'enqueues DisbursementJob for each merchant with the previous day as default date' do
      Timecop.freeze(Time.zone.local(2023, 10, 21, 8, 0, 0)) do
        merchant1 = create(:merchant)
        merchant2 = create(:second_merchant)

        allow(DisbursementJob).to receive(:perform_async)

        described_class.perform_async
        described_class.drain

        expect(DisbursementJob).to have_received(:perform_async)
          .with(merchant1.id, '2023-10-20')
          .once

        expect(DisbursementJob).to have_received(:perform_async)
          .with(merchant2.id, '2023-10-20')
          .once
      end
    end
  end
end

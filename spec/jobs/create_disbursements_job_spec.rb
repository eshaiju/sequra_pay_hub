# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CreateDisbursementsJob do
  it 'enqueues DisbursementJob for each merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:second_merchant)

    allow(DisbursementJob).to receive(:perform_async)

    described_class.perform_async(Time.zone.today.to_s)

    expect(DisbursementJob).to have_received(:perform_async).with(merchant1.id, Time.zone.today.to_s).once
    expect(DisbursementJob).to have_received(:perform_async).with(merchant2.id, Time.zone.today.to_s).once
  end
end

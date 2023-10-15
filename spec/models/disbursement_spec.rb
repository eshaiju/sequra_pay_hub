# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Disbursement do
  it 'is valid with valid attributes' do
    disbursement = build(:disbursement)
    expect(disbursement).to be_valid
  end

  it 'is not valid without a merchant_id' do
    disbursement = build(:disbursement, merchant_id: nil)
    expect(disbursement).not_to be_valid
  end

  it 'is not valid without an total_amount' do
    disbursement = build(:disbursement, total_amount: nil)
    expect(disbursement).not_to be_valid
  end

  it 'is not valid without an total_fee' do
    disbursement = build(:disbursement, total_fee: nil)
    expect(disbursement).not_to be_valid
  end

  it 'is not valid without an disbursement_date' do
    disbursement = build(:disbursement, disbursement_date: nil)
    expect(disbursement).not_to be_valid
  end

  it 'is not valid with a non-positive total_amount' do
    disbursement = build(:disbursement, total_amount: -10)
    expect(disbursement).not_to be_valid
  end

  it 'is not valid with a non-positive total_fee' do
    disbursement = build(:disbursement, total_fee: -10)
    expect(disbursement).not_to be_valid
  end
end

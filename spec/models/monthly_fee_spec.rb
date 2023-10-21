# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MonthlyFee do
  it 'is valid with valid attributes' do
    monthly_fee = build(:monthly_fee)
    expect(monthly_fee).to be_valid
  end

  it 'is not valid without a merchant' do
    monthly_fee = build(:monthly_fee, merchant: nil)
    expect(monthly_fee).not_to be_valid
  end

  it 'is not valid without an total_commissions' do
    monthly_fee = build(:monthly_fee, total_commissions: nil)
    expect(monthly_fee).not_to be_valid
  end

  it 'is not valid with a non-positive total_commissions' do
    monthly_fee = build(:monthly_fee, total_commissions: -50.0)
    expect(monthly_fee).not_to be_valid
  end

  it 'is not valid without month date' do
    monthly_fee = build(:monthly_fee, month: nil)
    expect(monthly_fee).not_to be_valid
  end
end

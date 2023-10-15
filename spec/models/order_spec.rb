# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  it 'is valid with valid attributes' do
    order = build(:order)
    expect(order).to be_valid
  end

  it 'is not valid without a merchant_id' do
    order = build(:order, merchant_id: nil)
    expect(order).not_to be_valid
  end

  it 'is not valid without an amount' do
    order = build(:order, amount: nil)
    expect(order).not_to be_valid
  end

  it 'is not valid without an order_date' do
    order = build(:order, order_date: nil)
    expect(order).not_to be_valid
  end

  it 'is not valid with a non-positive amount' do
    order = build(:order, amount: -10)
    expect(order).not_to be_valid
  end
end

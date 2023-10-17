# frozen_string_literal: true

require 'rails_helper'

describe OrderCommissionCalculator do
  describe '#calculate_commission' do
    context 'when order amount is less than 50' do
      it 'calculates the correct commission' do
        order = create(:order, amount: 40)
        calculator = described_class.new(order)

        expect(calculator.calculate_commission).to eq(0.40)
      end
    end

    context 'when order amount is between 50 and 300' do
      it 'calculates the correct commission' do
        order = create(:order, amount: 150)
        calculator = described_class.new(order)

        expect(calculator.calculate_commission).to eq(1.43)
      end
    end

    context 'when order amount is 300 or more' do
      it 'calculates the correct commission' do
        order = create(:order, amount: 500)
        calculator = described_class.new(order)

        expect(calculator.calculate_commission).to eq(4.25)
      end
    end
  end
end

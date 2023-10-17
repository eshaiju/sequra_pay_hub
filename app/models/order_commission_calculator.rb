# frozen_string_literal: true

class OrderCommissionCalculator
  FEE_UNDER_50 = 0.01
  FEE_50_TO_300 = 0.0095
  FEE_ABOVE_300 = 0.0085

  def initialize(order)
    @order = order
  end

  def calculate_commission
    if @order.amount < 50
      (@order.amount * FEE_UNDER_50).round(2)
    elsif @order.amount < 300
      (@order.amount * FEE_50_TO_300).round(2)
    else
      (@order.amount * FEE_ABOVE_300).round(2)
    end
  end
end

# frozen_string_literal: true

module Etl
  class Master
    def self.load_all
      Etl::Merchants.load
      Etl::Orders.load
    end
  end
end

# frozen_string_literal: true

require 'csv'

module Etl
  class Merchants
    def self.load(path: Rails.root.join('data/merchants.csv'))
      new(path: path).load
    end

    def initialize(path:)
      @path = path
    end

    def load
      ActiveRecord::Base.transaction do
        CSV.foreach(path, headers: true, col_sep: ';') do |row|
          MerchantFactory.build(row: row)
        end
      end
    end

    private

    attr_reader :path
  end
end

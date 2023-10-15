# frozen_string_literal: true

require 'rails_helper'
require 'etl/master'

RSpec.describe Etl::Master do
  describe '.load_all' do
    it 'calls Etl::Merchants.load and Etl::Orders.load' do
      allow(Etl::Merchants).to receive(:load)
      allow(Etl::Orders).to receive(:load)

      described_class.load_all

      expect(Etl::Merchants).to have_received(:load)
      expect(Etl::Orders).to have_received(:load)
    end
  end
end

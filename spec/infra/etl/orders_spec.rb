# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Etl::Orders do
  describe '.load' do
    let(:csv_path) { Rails.root.join('spec/fixtures/files/orders.csv') }

    it 'loads merchants from a CSV file and saves them' do
      expect do
        described_class.load(path: csv_path)
      end.to change(Order, :count).by(8)
    end
  end
end

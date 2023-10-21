# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe 'Rake tasks' do
  before(:all) do
    Rake.application = Rake::Application.new
    Rake.application.rake_require('tasks/import')
    Rake::Task.define_task(:environment)
  end

  it 'loads merchants and orders' do
    allow(Etl::Master).to receive(:load_all)

    Rake::Task['import:merchants_and_orders'].invoke

    expect(Etl::Master).to have_received(:load_all)
  end

  it 'loads merchants from a CSV file' do
    allow(Etl::Merchants).to receive(:load)

    merchants_file = Rails.root.join('spec/fixtures/files/merchants.csv')

    Rake::Task['import:merchants'].invoke(merchants_file)

    expect(Etl::Merchants).to have_received(:load).with(path: merchants_file)
  end

  it 'loads orders from a CSV file' do
    allow(Etl::Orders).to receive(:load)

    orders_file = Rails.root.join('spec/fixtures/files/orders.csv')

    Rake::Task['import:orders'].invoke(orders_file)

    expect(Etl::Orders).to have_received(:load).with(path: orders_file)
  end
end

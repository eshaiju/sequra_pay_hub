# frozen_string_literal: true

namespace :import do
  desc 'Import merchants and orders from CSV files'
  task merchants_and_orders: :environment do
    puts 'Starting data import...'
    Etl::Master.load_all
    puts 'Data import completed.'
  end

  desc 'Import merchants from a CSV file'
  task :merchants, [:merchants_file] => :environment do |_, args|
    merchants_file = args[:merchants_file]

    puts 'Starting merchant data import...'
    Etl::Merchants.load(path: merchants_file)
    puts 'Data import completed.'
  end

  desc 'Import orders from a CSV file'
  task :orders, [:orders_file] => :environment do |_, args|
    orders_file = args[:orders_file]

    puts 'Starting order data import...'
    Etl::Orders.load(path: orders_file)
    puts 'Data import completed.'
  end
end

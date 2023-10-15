# frozen_string_literal: true

namespace :import do
  desc 'Import merchants and orders from CSV files'
  task merchants_and_orders: :environment do
    puts 'Starting data import...'
    Etl::Master.load_all
    puts 'Data import completed.'
  end
end

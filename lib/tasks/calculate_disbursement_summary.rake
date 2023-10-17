# frozen_string_literal: true

namespace :disbursement_summary do
  desc 'Calculate disbursement summary for a specific year'
  task :calculate, [:year] => :environment do |_, args|
    year = args[:year].to_i

    summary = DisbursementSummaryService.generate_summary(year)

    puts "Disbursement Summary for #{year}:"
    puts "Year: #{summary[:year]}"
    puts "Number of Disbursements: #{summary[:number_of_disbursements]}"
    puts "Amount Disbursed: #{summary[:amount_disbursed]} €"
    puts "Amount of Order Fees: #{summary[:amount_of_order_fees]} €"
  end
end

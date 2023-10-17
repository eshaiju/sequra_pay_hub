# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe 'disbursement_summary:calculate' do
  before do
    Rake.application.load_rakefile
  end

  it 'calculates disbursement summary for a specific year' do
    year = 2022

    # rubocop:disable Layout/LineLength
    expected_output = /Disbursement Summary for #{year}:\nYear: #{year}\nNumber of Disbursements: \d+\nAmount Disbursed: \d+\.\d+ €\nAmount of Order Fees: \d+\.\d+ €/
    # rubocop:enable Layout/LineLength

    expect { Rake::Task['disbursement_summary:calculate'].invoke(year) }.to output(expected_output).to_stdout
  end
end

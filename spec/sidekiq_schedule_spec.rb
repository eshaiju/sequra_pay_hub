# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sidekiq Schedule' do
  it 'has the correct schedule for CreateMonthlyFeesJob' do
    schedule_file = Rails.root.join('config', 'sidekiq_scheduler.yml')

    schedule = YAML.load_file(schedule_file)

    expect(schedule['calculate_monthly_fee_job']).not_to be_nil

    expect(schedule['calculate_monthly_fee_job']['class']).to eq('CreateMonthlyFeesJob')
    expect(schedule['calculate_monthly_fee_job']['cron']).to eq('0 0 1 * *')
    expect(schedule['calculate_monthly_fee_job']['queue']).to eq('default')
    expect(schedule['calculate_monthly_fee_job']['description'])
      .to eq('Calculate monthly fees for the previous month at the beginning of each month')
  end
end

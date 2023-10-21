# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sidekiq Schedule' do
  let(:schedule_file) { Rails.root.join('config', 'sidekiq_scheduler.yml') }
  let(:schedule) { YAML.load_file(schedule_file) }

  it 'has the correct schedule for CreateMonthlyFeesJob' do
    expect(schedule['calculate_monthly_fee_job']).not_to be_nil

    expect(schedule['calculate_monthly_fee_job']['class']).to eq('CreateMonthlyFeesJob')
    expect(schedule['calculate_monthly_fee_job']['cron']).to eq('0 0 1 * *')
    expect(schedule['calculate_monthly_fee_job']['queue']).to eq('default')
    expect(schedule['calculate_monthly_fee_job']['description'])
      .to eq('Calculate monthly fees for the previous month at the beginning of each month')
  end

  it 'has the correct schedule for CreateDisbursementsJob' do
    expect(schedule['create_disbursements_job']).not_to be_nil
    expect(schedule['create_disbursements_job']['class']).to eq('CreateDisbursementsJob')
    expect(schedule['create_disbursements_job']['cron']).to eq('0 8 * * *')
    expect(schedule['create_disbursements_job']['queue']).to eq('default')
    expect(schedule['create_disbursements_job']['description'])
      .to eq('Create disbursements for eligible merchants by 8:00 AM UTC')
  end
end

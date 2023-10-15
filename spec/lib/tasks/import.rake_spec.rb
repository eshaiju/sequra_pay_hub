# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe 'import:merchants_and_orders' do
  before do
    Rake.application = Rake::Application.new
    Rake.application.rake_require('tasks/import')
    Rake::Task.define_task(:environment)
  end

  it 'loads merchants and orders' do
    allow(Etl::Master).to receive(:load_all)

    Rake::Task['import:merchants_and_orders'].invoke

    expect(Etl::Master).to have_received(:load_all)
  end
end

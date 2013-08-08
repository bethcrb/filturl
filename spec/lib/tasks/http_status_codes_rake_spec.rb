require 'spec_helper'
require 'rake'

describe 'http_status_codes namespace rake task' do
  before :all do
    Rake.application.rake_require 'tasks/http_status_codes'
    Rake::Task.define_task(:environment)
  end

  describe 'http_status_codes:import' do
    let :run_rake_task do
      Rake::Task['http_status_codes:import'].reenable
      Rake.application.invoke_task 'http_status_codes:import'
    end

    it 'should import status codes' do
      run_rake_task
      HttpStatusCode.count.should > 0
    end

    it 'should not import the CSV file header' do
      run_rake_task
      HttpStatusCode.find_by(value: 'value').should be_nil
    end

    it 'should not import unassigned status codes' do
      run_rake_task
      HttpStatusCode.find_by(description: 'Unassigned').should be_nil
    end
  end
end
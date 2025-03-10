# api_automation_framework/run_tests.rb

require_relative 'lib/api_test_runner'

runner = ApiAutomationFramework::ApiTestRunner.new('config.yml')
runner.run_tests

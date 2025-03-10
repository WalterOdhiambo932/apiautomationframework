# api_automation_framework/lib/api_test_runner.rb

require_relative 'api_client'
require_relative 'api_validator'
require 'yaml'

module ApiAutomationFramework
  class ApiTestRunner
    def initialize(config_file)
      @config = YAML.load_file(config_file)
      @client = ApiClient.new(@config['base_url'])
      @validator = ApiValidator.new
    end

    def run_tests
      @config['tests'].each do |test|
        puts "Running test: #{test['name']}"
        run_test(test)
      end
    end

    private

    def run_test(test)
      response = @client.send(test['method'], test['endpoint'], test['payload'], test['headers'])

      validate_response(response, test)
    end

    def validate_response(response, test)
      valid_status = @validator.validate_status_code(response[:status], test['expected_status'])
      puts "  Status Code: #{valid_status ? 'PASSED' : 'FAILED'}"

      if test['schema']
        schema = JSON.parse(File.read(test['schema']))
        schema_validation = @validator.validate_schema(response[:body], schema)
        puts "  Schema Validation: #{schema_validation == true ? 'PASSED' : "FAILED: #{schema_validation}"}"
      end

      if test['expected_body']
        body_validation = @validator.validate_response_body(response[:body], test['expected_body'])
        puts "  Body Validation: #{body_validation ? 'PASSED' : 'FAILED'}"
      end

      if test['expected_headers']
        headers_validation = @validator.validate_headers(response[:headers], test['expected_headers'])
        puts "  Headers Validation: #{headers_validation ? 'PASSED' : 'FAILED'}"
      end

      puts "  Response: #{response}"
    end
  end
end

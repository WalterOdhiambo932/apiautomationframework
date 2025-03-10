# api_automation_framework/lib/api_validator.rb

require 'json-schema'

module ApiAutomationFramework
  class ApiValidator
    def validate_schema(response_body, schema)
      JSON::Validator.validate!(schema, response_body)
      true
    rescue JSON::Schema::ValidationError => e
      e.message
    end

    def validate_status_code(actual, expected)
      actual == expected
    end

    def validate_response_body(actual, expected)
        actual == expected
    end

    def validate_headers(actual, expected)
      expected.all? { |key, value| actual[key] == value }
    end
  end
end
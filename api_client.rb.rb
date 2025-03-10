# api_automation_framework/lib/api_client.rb
require 'rest-client'
require 'json'

module ApiAutomationFramework
  class ApiClient
    def initialize(base_url)
      @base_url = base_url
    end

    def get(endpoint, headers = {})
      execute_request(:get, endpoint, headers: headers)
    end

    def post(endpoint, payload, headers = {})
      execute_request(:post, endpoint, payload: payload, headers: headers)
    end

    def put(endpoint, payload, headers = {})
      execute_request(:put, endpoint, payload: payload, headers: headers)
    end

    def delete(endpoint, headers = {})
      execute_request(:delete, endpoint, headers: headers)
    end

    private

    def execute_request(method, endpoint, payload: nil, headers: {})
      url = "#{@base_url}#{endpoint}"
      begin
        response = RestClient::Request.execute(
          method: method,
          url: url,
          payload: payload ? payload.to_json : nil,
          headers: headers.merge({ content_type: :json, accept: :json })
        )
        { status: response.code, body: JSON.parse(response.body), headers: response.headers }
      rescue RestClient::ExceptionWithResponse => e
        { status: e.response.code, body: JSON.parse(e.response.body), headers: e.response.headers }
      rescue RestClient::Exception => e
        { status: 500, body: { error: e.message }, headers: {} }
      end
    end
  end
end







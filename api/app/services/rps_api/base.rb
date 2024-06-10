# frozen_string_literal: true

require 'faraday'
require 'json'

require_relative 'error'

module RpsApi
  # Base class for all services
  class Base
    BASE_URL = ENV.fetch('RPS_API_BASE_URL', '')
    TIMEOUT = 5

    def initialize
      @connection = Faraday.new(url: BASE_URL) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.options.timeout = TIMEOUT
        faraday.adapter Faraday.default_adapter
      end
    end

    private

    def get(path)
      response = @connection.get(path)
      handle_response(response)
    rescue Faraday::TimeoutError, Faraday::ConnectionFailed
      raise RpsApi::TimeoutError, 'Request timed out'
    end

    def handle_response(response)
      case response.status
      when 200
        JSON.parse(response.body)
      when 400
        raise RpsApi::BadRequestError, 'Bad Request'
      when 404
        raise RpsApi::NotFoundError, 'Not Found'
      when 500...600
        raise RpsApi::ServerError, "Server Error: #{response.status}"
      else
        raise RpsApi::UnexpectedError, 'Unexpected Error'
      end
    end
  end
end

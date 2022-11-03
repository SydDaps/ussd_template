# frozen_string_literal: true

module Api
  class Get < Api::Base
    def process
      make_request
    rescue StandardError => e
      parse_error(e)
    end

    private

    def make_request
      @response = @api_connection.get do |request|
        request.url @endpoint
        request.options.timeout = 180
        request.body = @payload.to_json
      end

      process_response
    end
  end
end

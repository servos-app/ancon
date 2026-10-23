module Ancon
  module Errors
    class Error < StandardError
      attr_reader :response, :code

      def initialize(message = nil, response: nil, code: nil)
        @response = response
        @code = code
        super(message)
      end

      # Ancon asks for this id in any support question about the request.
      def correlation_id
        response&.correlation_id
      end
    end

    class AuthenticationError < Error; end

    class ForbiddenError < Error; end

    class NotFoundError < Error; end

    class ValidationError < Error
      def additional_data
        response.data["additionalData"] if response.data.is_a?(Hash)
      end
    end

    # 423: another device holds the check or product, e.g. a till editing it.
    class LockedError < Error; end

    # Ancon allows a handful of requests per second per endpoint and says
    # when the window reopens.
    class RateLimitError < Error
      def reset_at
        response.rate_limit_reset
      end
    end

    class ServerError < Error; end

    class ConnectionError < Error; end

    class TimeoutError < Error; end

    class ConfigurationError < Error; end

    BY_STATUS = {
      400 => ValidationError,
      401 => AuthenticationError,
      403 => ForbiddenError,
      404 => NotFoundError,
      423 => LockedError,
      429 => RateLimitError
    }.freeze

    def self.from(response)
      error_class = BY_STATUS.fetch(response.status) { (response.status >= 500) ? ServerError : Error }
      error_class.new(response.error_message || "HTTP #{response.status}", response: response, code: response.status)
    end
  end
end

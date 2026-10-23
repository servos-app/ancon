module Ancon
  # Lists answer `{"items" => [...], "meta" => {"count" =>, "offset" =>}}`.
  # Errors carry a `message`, except throttling, which answers ProblemDetails.
  class Response
    attr_reader :status, :headers, :data

    def initialize(status:, body:, headers: {})
      @status = status
      @headers = headers.to_h { |name, values| [name.to_s.downcase, Array(values)] }
      @data = parse(body)
    end

    def success?
      status.between?(200, 299)
    end

    def correlation_id
      header("x-correlation-id")
    end

    # Set when the endpoint is deprecated, to the date it stops answering.
    def deprecation_sunset
      header("deprecation-sunset")
    end

    def rate_limit_reset
      reset = header("x-rate-limit-reset")
      reset && Time.iso8601(reset)
    rescue ArgumentError
      nil
    end

    def error_message
      case data
      when Hash
        data["message"] || data["detail"] || data["title"] || data["reason"]
      when String
        data
      end
    end

    def error_code
      data["errorCode"] if data.is_a?(Hash)
    end

    private

    def header(name)
      headers[name]&.first
    end

    def parse(raw)
      return nil if raw.to_s.strip.empty?

      JSON.parse(raw)
    rescue JSON::ParserError
      raw
    end
  end
end

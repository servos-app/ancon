module Ancon
  # `version` is the API version segment (v1, v1.1, v1.2, v2). Ancon versions
  # each endpoint on its own, so a resource can span several.
  module Request
    USER_AGENT = "SERVOS (https://servos.dk)"
    METHODS = {
      get: Net::HTTP::Get,
      post: Net::HTTP::Post,
      put: Net::HTTP::Put,
      delete: Net::HTTP::Delete
    }.freeze

    def self.build(method, configuration, version, path, params: {}, body: nil)
      uri = URI("#{configuration.api_url(version)}#{path}")
      uri.query = URI.encode_www_form(params) if params.any?

      request = METHODS.fetch(method).new(uri)
      request["Access-Token"] = configuration.access_token
      request["Accept"] = "application/json"
      request["Accept-Language"] = configuration.language if configuration.language
      request["User-Agent"] = USER_AGENT
      write_body(request, body) unless body.nil?
      request
    end

    def self.write_body(request, body)
      request["Content-Type"] = "application/json"
      request.body = body.to_json
    end
    private_class_method :write_body
  end
end

module Ancon
  # `language` goes out as Accept-Language, which the v2 check endpoints honour
  # for product names.
  class Configuration < Data.define(:access_token, :language, :base_url)
    BASE_URL = "https://core-api.ancon.io/public"

    def initialize(access_token:, language: nil, base_url: BASE_URL)
      raise Errors::ConfigurationError, "Missing Ancon access token" if access_token.to_s.strip.empty?

      super
    end

    def api_url(version)
      "#{base_url}/api/#{version}"
    end

    # Keeps the token out of logs and error reports.
    def inspect
      "#<data #{self.class.name} access_token=[FILTERED], language=#{language.inspect}, base_url=#{base_url.inspect}>"
    end
    alias_method :to_s, :inspect
  end
end

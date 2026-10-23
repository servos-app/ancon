require "minitest/autorun"
require_relative "../lib/ancon"

class FakeConnection
  attr_reader :requests

  def initialize
    @requests = []
    @responses = []
  end

  def respond_with(status: 200, body: "", headers: {})
    @responses << Ancon::Response.new(status: status, body: body.is_a?(String) ? body : body.to_json,
      headers: headers)
    self
  end

  def perform(request)
    @requests << request
    @responses.shift || Ancon::Response.new(status: 200, body: "{}")
  end

  def last_request = requests.last
end

module AnconTestHelpers
  API_URL = "https://core-api.ancon.io/public/api".freeze

  def setup
    @connection = FakeConnection.new
  end

  private

  def client(**options)
    Ancon::Client.new(access_token: "token", connection: @connection, **options)
  end

  def response(status, body, headers = {})
    Ancon::Response.new(status: status, body: body, headers: headers)
  end

  def last_request = @connection.last_request

  def assert_request(method, url, request = last_request)
    assert_equal method, request.method
    assert_equal url, URI.decode_www_form_component(request.uri.to_s)
  end
end

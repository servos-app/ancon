require_relative "test_helper"

class Ancon::ClientTest < Minitest::Test
  include AnconTestHelpers

  def test_requires_an_access_token
    assert_raises(Ancon::Errors::ConfigurationError) { Ancon::Client.new(access_token: " ") }
  end

  def test_current_tenant_gets_the_tokens_tenant
    @connection.respond_with(body: {tenant: {id: "t-1"}})

    assert_equal "t-1", client.current_tenant.data.dig("tenant", "id")
    assert_request "GET", "#{API_URL}/v1/Tenants"
  end

  def test_outlets_lists_the_tenants_outlets
    client.outlets(limit: 10)

    assert_request "GET", "#{API_URL}/v1/Tenants/Outlets?Limit=10"
  end

  def test_sends_the_access_token_as_json_from_servos
    client.current_tenant

    assert_equal "token", last_request["Access-Token"]
    assert_equal "application/json", last_request["Accept"]
    assert_equal Ancon::Request::USER_AGENT, last_request["User-Agent"]
    assert_nil last_request["Accept-Language"]
  end

  def test_sends_the_language_when_given
    client(language: "da-DK").outlet("o-1").checks.retrieve("c-1")

    assert_equal "da-DK", last_request["Accept-Language"]
  end

  def test_base_url_can_point_elsewhere
    client(base_url: "https://ancon.example/public").current_tenant

    assert_request "GET", "https://ancon.example/public/api/v1/Tenants"
  end

  def test_writes_send_a_json_body_and_bodiless_writes_send_none
    outlet = client.outlet("o-1")

    outlet.tables.update("tb-1", {externalId: "42"})
    assert_equal '{"externalId":"42"}', last_request.body
    assert_equal "application/json", last_request["Content-Type"]

    outlet.checkouts.recalculate_price("co-1")
    assert_nil last_request.body
    assert_nil last_request["Content-Type"]
  end

  def test_scopes_memoize_their_resources
    tenant = client.tenant("t-1")

    assert_same tenant.products, tenant.products
    refute_same tenant.products, tenant.taxes
  end

  def test_raises_the_error_for_the_status
    @connection.respond_with(status: 404, body: {message: "Product not found", errorCode: "e-1"},
      headers: {"X-Correlation-Id" => ["corr-1"]})

    error = assert_raises(Ancon::Errors::NotFoundError) { client.tenant("t-1").products.retrieve("p-1") }

    assert_equal "Product not found", error.message
    assert_equal 404, error.code
    assert_equal "corr-1", error.correlation_id
  end

  def test_inspecting_the_client_hides_the_access_token
    refute_includes client.inspect, "token\""
    assert_includes client.configuration.inspect, "access_token=[FILTERED]"
  end
end

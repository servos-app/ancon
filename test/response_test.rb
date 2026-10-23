require_relative "test_helper"

class Ancon::ResponseTest < Minitest::Test
  include AnconTestHelpers

  def test_parses_json_and_leaves_an_empty_body_nil
    assert_equal({"items" => []}, response(200, '{"items":[]}').data)
    assert_nil response(200, "").data
  end

  def test_keeps_a_body_that_is_not_json
    assert_equal "Bad gateway", response(502, "Bad gateway").data
  end

  def test_error_message_reads_ancons_message_then_problem_details
    assert_equal "Not found", response(404, '{"message":"Not found"}').error_message
    assert_equal "Too many requests", response(429, '{"title":"Too many requests"}').error_message
    assert_equal "Locked by till", response(423, '{"reason":"Locked by till"}').error_message
  end

  def test_reads_correlation_and_deprecation_headers
    response = response(200, "{}", {"X-Correlation-Id" => ["corr-1"], "Deprecation-Sunset" => ["2028-09-01"]})

    assert_equal "corr-1", response.correlation_id
    assert_equal "2028-09-01", response.deprecation_sunset
  end

  def test_rate_limit_reset_parses_ancons_seven_digit_fractions
    response = response(429, "", {"X-Rate-Limit-Reset" => ["2026-10-23T13:08:38.0322751Z"]})

    assert_equal Time.utc(2026, 10, 23, 13, 8, 38.0322751r), response.rate_limit_reset
  end

  def test_rate_limit_reset_is_nil_when_missing_or_unreadable
    assert_nil response(429, "").rate_limit_reset
    assert_nil response(429, "", {"X-Rate-Limit-Reset" => ["soon"]}).rate_limit_reset
  end
end

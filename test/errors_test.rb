require_relative "test_helper"

class Ancon::ErrorsTest < Minitest::Test
  include AnconTestHelpers

  def test_maps_statuses_to_error_classes
    {
      400 => Ancon::Errors::ValidationError,
      401 => Ancon::Errors::AuthenticationError,
      403 => Ancon::Errors::ForbiddenError,
      404 => Ancon::Errors::NotFoundError,
      423 => Ancon::Errors::LockedError,
      429 => Ancon::Errors::RateLimitError,
      503 => Ancon::Errors::ServerError,
      409 => Ancon::Errors::Error
    }.each do |status, error_class|
      assert_instance_of error_class, Ancon::Errors.from(response(status, "")), "for #{status}"
    end
  end

  def test_falls_back_to_the_status_when_there_is_no_message
    assert_equal "HTTP 500", Ancon::Errors.from(response(500, "")).message
  end

  def test_validation_error_exposes_ancons_additional_data
    error = Ancon::Errors.from(response(400, '{"message":"Invalid","additionalData":{"name":["required"]}}'))

    assert_equal({"name" => ["required"]}, error.additional_data)
  end

  def test_rate_limit_error_says_when_to_retry
    error = Ancon::Errors.from(response(429, "", {"X-Rate-Limit-Reset" => ["2026-10-23T13:08:39Z"]}))

    assert_equal Time.utc(2026, 10, 23, 13, 8, 39), error.reset_at
  end
end

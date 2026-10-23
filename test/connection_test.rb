require_relative "test_helper"
require "socket"

class Ancon::ConnectionTest < Minitest::Test
  def test_wraps_the_status_body_and_headers
    server = TCPServer.new("127.0.0.1", 0)
    answer = Thread.new do
      socket = server.accept
      socket.gets("\r\n\r\n")
      socket.write "HTTP/1.1 200 OK\r\nX-Correlation-Id: corr-1\r\n" \
        "Content-Length: 11\r\nConnection: close\r\n\r\n{\"ok\":true}"
      socket.close
    end
    request = Net::HTTP::Get.new(URI("http://127.0.0.1:#{server.addr[1]}/public/api/v1/Tenants"))

    response = Ancon::Connection.perform(request, timeout: 5, open_timeout: 5)

    assert_equal 200, response.status
    assert_equal({"ok" => true}, response.data)
    assert_equal "corr-1", response.correlation_id
  ensure
    answer&.kill
    server&.close
  end

  def test_a_refused_connection_becomes_a_connection_error
    request = Net::HTTP::Get.new(URI("http://127.0.0.1:1/public/api/v1/Tenants"))

    assert_raises(Ancon::Errors::ConnectionError) { Ancon::Connection.perform(request, timeout: 1, open_timeout: 1) }
  end
end

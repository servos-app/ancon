require_relative "test_helper"

class Ancon::QueryTest < Minitest::Test
  def test_paging_order_and_search_go_out_under_ancons_names
    query = Ancon::Query.list(offset: 100, limit: 50, order: "created desc", search: "burger")

    assert_equal [[:Offset, 100], [:Limit, 50], [:Order, "created desc"], [:Search, "burger"]], query
  end

  def test_a_filter_with_several_conditions_repeats_the_key
    query = Ancon::Query.list(filter: {created: ["gte:2026-01-01", "lte:2026-02-01"], name: "eq:Fries"})

    assert_equal "Filter[created]=gte:2026-01-01&Filter[created]=lte:2026-02-01&Filter[name]=eq:Fries",
      URI.decode_www_form_component(URI.encode_www_form(query))
  end

  def test_meta_filters_and_endpoint_parameters_pass_through
    query = Ancon::Query.list(meta_filter: {table: "eq:12"}, Handled: false)

    assert_equal [[:Handled, false], ["MetaFilter[table]", "eq:12"]], query
  end

  def test_no_arguments_send_no_query
    assert_empty Ancon::Query.list
  end
end

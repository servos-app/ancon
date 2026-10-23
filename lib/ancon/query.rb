module Ancon
  # Query string for list endpoints. Filters are `operator:value` strings keyed
  # by the property names each endpoint documents, and a property can take
  # several (`filter: {created: ["gte:2026-01-01", "lte:2026-02-01"]}` sends
  # `Filter[created]=gte:…&Filter[created]=lte:…`). Endpoint-specific
  # parameters pass through under Ancon's own names (`Handled: false`).
  #
  # @see https://ancon.dev/wp-content/uploads/2022/12/Filtering-2022-12-16.pdf
  module Query
    def self.list(offset: nil, limit: nil, order: nil, search: nil, filter: {}, meta_filter: {}, **params)
      {Offset: offset, Limit: limit, Order: order, Search: search, **params}.compact.to_a +
        nested("Filter", filter) + nested("MetaFilter", meta_filter)
    end

    def self.nested(name, conditions)
      conditions.flat_map { |property, values| Array(values).map { |value| ["#{name}[#{property}]", value] } }
    end
    private_class_method :nested
  end
end

module Ancon
  module Resources
    # Kitchen and bar tickets.
    class Tickets < Resource
      include Retrievable

      def detailed_list(**params)
        client.get(path("DetailedList"), params: Query.list(**params))
      end

      protected

      def resource_path
        "/Tickets"
      end
    end
  end
end

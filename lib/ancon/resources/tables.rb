module Ancon
  module Resources
    class Tables < Resource
      include Listable

      # Only a table's external id can be changed, to link it to another system.
      def update(id, body)
        client.put(path(id), body: body)
      end

      protected

      def resource_path
        "/Tables"
      end
    end
  end
end

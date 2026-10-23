module Ancon
  module Resources
    class Discounts < Resource
      include Listable

      def retrieve(id)
        client.get(path(id), version: "v1.1")
      end

      protected

      def resource_path
        "/Discounts"
      end
    end
  end
end

module Ancon
  module Resources
    class ProductGroups < Resource
      include Listable
      include Retrievable
      include Deletable

      def create(body)
        client.post(path, body: body, version: "v1.1")
      end

      def update(id, body)
        client.put(path(id), body: body, version: "v1.1")
      end

      protected

      def resource_path
        "/ProductGroups"
      end
    end
  end
end

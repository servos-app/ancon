module Ancon
  module Resources
    # `create` makes a draft; it reaches the tills once published.
    class Products < Resource
      include Listable
      include Creatable
      include Updatable
      include Deletable

      def retrieve(id)
        client.get(path(id), version: "v1.1")
      end

      def publish(id)
        client.put(path(id, "publish"))
      end

      def update_availabilities(id, body)
        client.put(path(id, "productAvailabilities"), body: body)
      end

      # Which outlets the product is shared with.
      def update_shares(id, body)
        client.put(path(id, "shares"), body: body)
      end

      def create_variant(id, body)
        client.post(path(id, "variants"), body: body)
      end

      def update_variant(id, variant_id, body)
        client.put(path(id, "variants", variant_id), body: body)
      end

      def update_tags(id, body)
        client.put(path(id, "tags"), body: body)
      end

      def update_metadata(id, body)
        client.put(path(id, "metadata"), body: body)
      end

      def update_sub_products(id, body)
        client.put(path(id, "SubProducts"), body: body)
      end

      protected

      def resource_path
        "/Products"
      end
    end
  end
end

module Ancon
  module Resources
    class UpsellGroups < Resource
      include Listable
      include Retrievable

      protected

      def resource_path
        "/UpsellGroups"
      end
    end
  end
end

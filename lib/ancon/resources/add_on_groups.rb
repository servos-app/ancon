module Ancon
  module Resources
    class AddOnGroups < Resource
      include Listable
      include Retrievable

      protected

      def resource_path
        "/AddOnGroups"
      end
    end
  end
end

module Ancon
  module Resources
    class ClientGroups < Resource
      include Listable
      include Retrievable
      include Creatable
      include Updatable
      include Deletable

      protected

      def resource_path
        "/ClientGroups"
      end
    end
  end
end

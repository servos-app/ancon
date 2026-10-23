module Ancon
  module Resources
    class Clients < Resource
      include Listable

      protected

      def resource_path
        "/Clients"
      end
    end
  end
end

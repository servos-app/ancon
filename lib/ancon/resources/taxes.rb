module Ancon
  module Resources
    class Taxes < Resource
      include Listable
      include Retrievable

      protected

      def resource_path
        "/Taxes"
      end
    end
  end
end

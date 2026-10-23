module Ancon
  module Resources
    class SaleSources < Resource
      include Listable

      protected

      def resource_path
        "/SaleSources"
      end
    end
  end
end

module Ancon
  module Resources
    class Fees < Resource
      include Listable
      include Retrievable

      protected

      def resource_path
        "/Fees"
      end
    end
  end
end

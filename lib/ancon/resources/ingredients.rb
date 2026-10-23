module Ancon
  module Resources
    class Ingredients < Resource
      include Listable
      include Retrievable

      protected

      def resource_path
        "/Ingredients"
      end
    end
  end
end

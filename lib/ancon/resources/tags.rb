module Ancon
  module Resources
    class Tags < Resource
      include Listable

      protected

      def resource_path
        "/Tags"
      end
    end
  end
end

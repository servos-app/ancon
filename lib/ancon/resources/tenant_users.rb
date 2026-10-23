module Ancon
  module Resources
    class TenantUsers < Resource
      include Retrievable

      protected

      def resource_path
        "/TenantUsers"
      end
    end
  end
end

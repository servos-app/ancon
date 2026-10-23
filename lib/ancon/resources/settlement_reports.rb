module Ancon
  module Resources
    class SettlementReports < Resource
      include Listable

      protected

      def resource_path
        "/SettlementReports"
      end
    end
  end
end

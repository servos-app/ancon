module Ancon
  module Resources
    class MenuTrees < Resource
      include Listable
      include Retrievable

      # The menu as an outlet shows it, narrowed by Ancon's own parameters
      # (`SystemVisibility:`, `OrderFormats:`, `OrderTime:`, `DayOfWeek:`).
      def hierarchy(id, outlet_id:, **params)
        client.get("#{@scope}/Outlets/#{outlet_id}#{resource_path}/#{id}/Hierarchy", params: params)
      end

      protected

      def resource_path
        "/MenuTrees"
      end
    end
  end
end

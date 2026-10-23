module Ancon
  module Resources
    # Areas of the floor plan (dining room, terrace) and their tables.
    class Sections < Resource
      include Listable

      def status(id)
        client.get(path(id, "Status"))
      end

      def tables(id, **params)
        client.get(path(id, "Tables"), params: Query.list(**params))
      end

      protected

      def resource_path
        "/Sections"
      end
    end
  end
end

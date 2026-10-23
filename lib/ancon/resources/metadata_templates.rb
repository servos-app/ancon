module Ancon
  module Resources
    class MetadataTemplates < Resource
      include Listable
      include Retrievable
      include Creatable
      include Updatable
      include Deletable

      protected

      def resource_path
        "/MetadataTemplate"
      end
    end
  end
end

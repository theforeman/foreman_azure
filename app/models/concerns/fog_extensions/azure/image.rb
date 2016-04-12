module FogExtensions
  module Azure
    module Image
      extend ActiveSupport::Concern

      def id
        name
      end
    end
  end
end

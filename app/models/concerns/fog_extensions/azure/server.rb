module FogExtensions
  module Azure
    module Server
      extend ActiveSupport::Concern

      def to_s
        "#{vm_name}@#{cloud_service_name}"
      end
    end
  end
end

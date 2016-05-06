module FogExtensions
  module Azure
    module Compute
      extend ActiveSupport::Concern

      def role_sizes
        @vm_svc.list_role_sizes
      end

      def cloud_services
        ::Azure::CloudServiceManagementService.new.list_cloud_services
      end
    end
  end
end

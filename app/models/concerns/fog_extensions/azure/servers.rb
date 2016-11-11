module FogExtensions
  module Azure
    module Servers
      extend ActiveSupport::Concern

      included do
        alias_method_chain :all, :patched_arguments
        alias_method_chain :get, :cloud_service_patch
      end

      # Azure servers.all doesn't take any argument, against the fog
      # standard, so we override the method.
      # https://github.com/fog/fog-azure/pull/25
      def all_with_patched_arguments(_options = {})
        all_without_patched_arguments
      end

      # Azure servers.get takes 2 arguments, the cloud service name and
      # the vm_name. This is against the fog standard, however it's not
      # possible to uniquely find a VM with just one argument. Instead,
      # we try our best (see models/foreman_azure/azure.rb#find_vm_by_uuid
      # for a similar method) to find it.
      def get_with_cloud_service_patch(identity, cloud_service_name = nil)
        cloud_service_name ||= identity
        cloud_service_vm = get_without_cloud_service_patch(identity, cloud_service_name)
        return cloud_service_vm if cloud_service_vm.present?
        find { |vm| vm.vm_name == identity }
      end
    end
  end
end

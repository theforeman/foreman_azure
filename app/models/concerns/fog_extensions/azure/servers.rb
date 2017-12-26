module FogExtensions
  module Azure
    module Servers
      extend ActiveSupport::Concern
      module Overrides
        # Azure servers.all doesn't take any argument, against the fog
        # standard, so we override the method.
        # https://github.com/fog/fog-azure/pull/25
        def all(_options = {})
          super(options)
        end

        # Azure servers.get takes 2 arguments, the cloud service name and
        # the vm_name. This is against the fog standard, however it's not
        # possible to uniquely find a VM with just one argument. Instead,
        # we try our best (see models/foreman_azure/azure.rb#find_vm_by_uuid
        # for a similar method) to find it.
        def get(identity, cloud_service_name = nil)
          cloud_service_name ||= identity
          cloud_service_vm = super(identity, cloud_service_name)
          return cloud_service_vm if cloud_service_vm.present?
          find { |vm| vm.vm_name == identity }
        end
      end

      prepend Overrides
    end
  end
end

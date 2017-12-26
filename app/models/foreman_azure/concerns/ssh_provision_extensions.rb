module ForemanAzure
  module Concerns
    module SSHProvisionExtensions
      extend ActiveSupport::Concern
      module Overrides
        def setSSHWaitForResponse
          if compute_resource.type == "ForemanAzure::Azure"
            self.client = Foreman::Provision::SSH.new(
              provision_ip,
              image.username,
              { :template => template_file.path,
                :uuid => uuid,
                :keys => [compute_resource.certificate_path] })
          else
            super
          end
        rescue => e
          failure _("Failed to login via SSH to %{name}: %{e}") %
            { :name => name, :e => e }, e
        end
      end

      included do
        prepend Overrides
      end
    end
  end
end

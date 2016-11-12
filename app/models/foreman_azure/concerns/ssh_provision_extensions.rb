module ForemanAzure
  module Concerns
    module SSHProvisionExtensions
      extend ActiveSupport::Concern

      included do
        alias_method_chain :setSSHWaitForResponse, :use_ssh_keys
      end

      def setSSHWaitForResponse_with_use_ssh_keys
        if compute_resource.type == "ForemanAzure::Azure"
          self.client = Foreman::Provision::SSH.new(
            provision_ip,
            image.username,
            { :template => template_file.path,
              :uuid => uuid,
              :keys => [compute_resource.certificate_path] })
        else
          setSSHWaitForResponse_without_use_ssh_keys
        end
      rescue => e
        failure _("Failed to login via SSH to %{name}: %{e}") %
          { :name => name, :e => e }, e
      end
    end
  end
end

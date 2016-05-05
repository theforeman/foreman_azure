module FogExtensions
  module Azure
    module Compute
      extend ActiveSupport::Concern

      def list_role_sizes
        @vm_svc.list_role_sizes
      end
    end
  end
end

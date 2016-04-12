module FogExtensions
  module Azure
    module Servers
      extend ActiveSupport::Concern

      # Azure servers.all doesn't take any argument, against the fog
      # standard, so we override the method.
      # https://github.com/fog/fog-azure/pull/25
      included do
        alias_method_chain :all, :patched_arguments
      end

      def all_with_patched_arguments(_options = {})
        all_without_patched_arguments
      end
    end
  end
end

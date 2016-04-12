module ForemanAzure
  class Engine < ::Rails::Engine
    engine_name 'foreman_azure'

    initializer 'foreman_azure.register_plugin', :before => :finisher_hook do
      Foreman::Plugin.register :foreman_azure do
        requires_foreman '>= 1.8'
        compute_resource(Azure)
      end
    end

    initializer 'foreman_azure.register_gettext', after: :load_config_initializers do
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_azure'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end

    config.to_prepare do
      require 'fog/azure'
      require 'fog/azure/models/compute/servers'
      require File.expand_path(
        '../../../app/models/concerns/fog_extensions/azure/servers', __FILE__)
      Fog::Compute::Azure::Servers.send(:include, FogExtensions::Azure::Servers)
      require 'fog/azure/models/compute/image'
      require File.expand_path(
        '../../../app/models/concerns/fog_extensions/azure/image', __FILE__)
      Fog::Compute::Azure::Image.send(:include, FogExtensions::Azure::Image)
    end
  end
end

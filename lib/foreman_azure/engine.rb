module ForemanAzure
  class Engine < ::Rails::Engine
    engine_name 'foreman_azure'

    initializer 'foreman_azure.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_azure do
        requires_foreman '>= 1.8'
      end
    end

    initializer 'foreman_azure.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_azure'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end

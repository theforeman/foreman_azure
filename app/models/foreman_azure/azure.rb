module ForemanAzure
  class Azure < ComputeResource
    alias_attribute :subscription_id, :user
    alias_attribute :certificate_path, :url
    if ::Foreman::Version.new.major.to_i == 1 && ::Foreman::Version.new.minor.to_i < 13
      attr_accessible :subscription_id, :certificate_path
    end

    before_create :test_connection

    delegate :storage_accounts, :role_sizes, :cloud_services,
      :virtual_networks, :to => :client

    def to_label
      "#{name} (#{provider_friendly_name})"
    end

    def capabilities
      [:build, :image]
    end

    def self.model_name
      ComputeResource.model_name
    end

    def provider_friendly_name
      'Azure'
    end

    def test_connection(options = {})
      client.storage_accounts # Make a simple 'ping' request
      super(options)
    end

    def available_images
      client.images
    end

    def provided_attributes
      super.merge(:ip => :public_ip_address)
    end

    def image_locations(image_id)
      client.images.get(image_id).locations.split(';')
    end

    def create_vm(args = {})
      args.delete_if { |_key, value| value.blank? }
      args[:hostname] = args[:name]
      args[:vm_name] = args[:name].split('.').first
      args[:cloud_service_name] ||= args[:vm_name]
      args[:image] = args[:image_id]
      args[:vm_user] = Image.unscoped.find_by_uuid(args[:image_id]).username
      args[:private_key_file] = url
      super(args)
    end

    # Azure does not have an UUID for each vm. It has a unique pair
    # 'cloud_service_name' and 'vm_name'. We will need to override all
    # destroy_vm, start_vm, stop_vm... to accept two parameters.
    #
    # fog-azure should probably build this UUID concept instead,
    # but until then, we can just do our best to match it

    def find_vm_by_uuid(uuid)
      client.servers.find { |vm| vm.vm_name == uuid }
    end

    protected

    def client
      @client ||= Fog::Compute.new(
        :provider => 'Azure',
        :azure_sub_id => subscription_id,
        :azure_pem => certificate_path)
    end
  end
end

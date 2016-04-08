module ForemanAzure
  class Azure < ComputeResource
    alias_attribute :subscription_id, :user
    alias_attribute :certificate_path, :url
    attr_accessible :subscription_id, :certificate_path

    before_create :test_connection

    def to_label
      "#{name} (#{provider_friendly_name})"
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

    protected

    def client
      @client ||= Fog::Compute.new(
        :provider => 'Azure',
        :azure_sub_id => subscription_id,
        :azure_pem => certificate_path)
    end
  end
end

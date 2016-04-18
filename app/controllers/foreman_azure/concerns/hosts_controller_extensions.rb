module ForemanAzure
  module Concerns
    module HostsControllerExtensions
      def locations
        azure_resource = Image.find_by_uuid(params[:image_id]).compute_resource
        render :json => azure_resource.locations(params[:image_id])
      end
    end
  end
end

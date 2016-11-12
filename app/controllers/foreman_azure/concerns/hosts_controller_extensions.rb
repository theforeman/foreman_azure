module ForemanAzure
  module Concerns
    module HostsControllerExtensions
      def locations
        if (azure_resource = Image.unscoped.find_by_uuid(params[:image_id])).present?
          render :json => azure_resource.compute_resource.
            image_locations(params[:image_id])
        else
          error = _('The operating system you selected has no associated image.'\
                    ' Please select a different one or go to Infrastructure >'\
                    ' Compute Resources to associate an image with this '\
                    'operating system.')
          render :json => "[\"#{error}\"]"
        end
      end
    end
  end
end

module AzureImagesHelper
  def select_azure_image(f, images)
    select_f(
      f,
      :image,
      images,
      :uuid,
      :name,
      { :include_blank => (images.empty? || images.size == 1) ? false : _('Please select an image') },
      :label => ('Image'),
      :disabled => images.empty?,
      :class => 'without_select2',
      :'data-url' => '/azure/locations',
      :onclick => 'azure_image_selected();',
      :onchange => 'azure_image_selected();')
  end

  def select_azure_region(f)
    selectable_f(
      f,
      :location, [],
      { :include_blank => _('Choose an operating system and image first') },
      :label => _('Azure location'),
      :class => 'without_select2',
      :id => 'azure_locations',
      :help_inline => refresh_button + spinner_indicator)
  end

  def select_storage_account(f, accounts)
    selectable_f(
      f,
      :storage_account_name, accounts.map(&:name),
      { :include_blank => _('None') },
      :label => _('Storage account'))
  end

  def select_role_size(f, role_sizes)
    selectable_f(
      f,
      :vm_size, role_sizes,
      {},
      :label => _('Role size'))
  end

  def select_cloud_service(f, cloud_services)
    selectable_f(
      f,
      :cloud_service_name, cloud_services.map(&:name),
      { :include_blank => _('Defaults to VM name') },
      :label => _('Cloud service name'))
  end

  private

  def spinner_indicator
    content_tag(:span,
                content_tag(:div, '',
                            :id => 'azure_locations_spinner',
                            :class => 'hide spinner spinner-xs'),
                :class => 'help-block').html_safe
  end

  def refresh_button
    link_to_function(icon_text('refresh', ''),
                     'azure_image_selected();')
  end
end

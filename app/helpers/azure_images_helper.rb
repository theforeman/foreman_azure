module AzureImagesHelper
  def select_azure_image(f, images)
    select_f(
      f,
      :image,
      images,
      :uuid,
      :name,
      { :include_blank => (images.empty? || images.size == 1) ? false : _('Please select an image') },
      { :label => ('Image'),
        :disabled => images.empty?,
        :class => 'without_select2',
        :'data-url' => '/azure/locations',
        :onclick => 'azure_image_selected(this);',
        :onchange => 'azure_image_selected(this);' } )
  end

  def select_azure_region(f)
    selectable_f f,
      :location, [],
      { :include_blank => _('Choose an operating system and image first') },
      { :label => _('Location'),
        :class => 'without_select2',
        :id => 'azure_locations' }
  end
end

# Hack to add javascript via partials
Deface::Override.new(
  :virtual_path => 'hosts/_form',
  :name => 'add_image_location_js',
  :insert_after => 'erb[loud]:contains("javascript")',
  :text => "<% javascript 'foreman_azure/host_os_azure_selected' %>")

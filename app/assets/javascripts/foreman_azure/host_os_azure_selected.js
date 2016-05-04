function azure_image_selected() {
  var url = $('#host_compute_attributes_image').attr('data-url');
  var imageId = $('#host_compute_attributes_image').val();
  var azure_locations = $('#azure_locations');
  var locations_spinner = $('#azure_locations_spinner');
  foreman.tools.showSpinner();
  locations_spinner.removeClass('hide');
  $.ajax({
    data: { "image_id": imageId },
    type:'get',
    url: url,
    complete: function(){
      reloadOnAjaxComplete('#host_compute_attributes_image');
      locations_spinner.addClass('hide');
    },
    error: function(request, status, error) {
    },
    success: function(request_locations) {
      azure_locations.empty();
			$.each(request_locations, function() {
				azure_locations.append($("<option />").val(this).text(this));
			});
    }
  });
}

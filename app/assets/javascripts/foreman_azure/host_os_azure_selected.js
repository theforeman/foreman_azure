function azure_image_selected() {
  var url = $('#host_compute_attributes_image_id').attr('data-url');
  var imageId = $('#host_compute_attributes_image_id').val();
  var azure_locations = $('#azure_locations');
  var locations_spinner = $('#azure_locations_spinner');
  if (typeof tfm == 'undefined') {  // earlier than 1.13
    foreman.tools.showSpinner();
  } else {
    tfm.tools.showSpinner();
  }

  locations_spinner.removeClass('hide');
  $.ajax({
    data: { "image_id": imageId },
    type:'get',
    url: url,
    complete: function(){
      reloadOnAjaxComplete('#host_compute_attributes_image_id');
      locations_spinner.addClass('hide');
      if (typeof tfm == 'undefined') {  // earlier than 1.13
        foreman.tools.hideSpinner();
      } else {
        tfm.tools.hideSpinner();
      }
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

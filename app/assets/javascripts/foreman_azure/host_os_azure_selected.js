function azure_image_selected(element) {
  var url = $(element).attr('data-url');
  var imageId = $(element).val();
  var azure_locations = $('#azure_locations')
  foreman.tools.showSpinner();
  $.ajax({
    data: { "image_id": imageId },
    type:'get',
    url: url,
    complete: function(){
      reloadOnAjaxComplete(element);
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

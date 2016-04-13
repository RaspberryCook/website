$(document).ready(function(){
	$('.flash_error, .flash_notice, .flash_success')
		.delay(500)
			.fadeToggle(500);

	$('.flash_error, .flash_notice, .flash_success').click( function(){ 
		$(this).fadeToggle(500) ;});

})



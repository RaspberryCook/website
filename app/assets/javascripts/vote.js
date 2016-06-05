
$(document).ready(function(){


	function dry (event){
		event.preventDefault();
		$('#vote_up, #vote_down').css('color' , 'inherit');
	}


	$('#vote_up').click(function(event){
		dry(event);
		$(this).css('color' , 'green');
	})
	$('#vote_down').click(function(event){
		dry(event);
		$(this).css('color' , 'green');
	})


})
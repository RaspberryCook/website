$(document).ready(function(){
	$('#recipe_picture').parallax();

	// set green color on vote button if the current user already voted 
	// FIND A WAY TO REPAIR IT !
	
	// <% begin %>
	// 	<% if Vote.where( user_id: current_user.id , recipe_id: params[:id] , value: 1).first %>
	// 		$('#vote_up').css('color' , 'green');
	// 	<% elsif Vote.where( user_id: current_user.id , recipe_id: params[:id] , value: -1).first %>
	// 		$('#vote_down').css('color' , 'green');
	// 	<% end %>
	// <% rescue NoMethodError %>
		
	// <% end %>

	// display or hide the magnifier icon to show up the recipe picture
	$('#recipe_picture').hover(function(){
		$('#zoom-in').fadeIn();
	},function() {
		$('#zoom-in').fadeOut();
	})
	
	// show the picture
	$('#zoom-in').click(function(event){
		event.preventDefault();
		$('#recipe_fullscreen_picture').fadeToggle();
	})

	// hide the picture when user click on it
	$('#recipe_fullscreen_picture').click( function(){
		$(this).fadeOut();
	})

});
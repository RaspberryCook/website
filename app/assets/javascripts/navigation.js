$('#search-icon').on('click', function(){
  var form = $('#search-recipe-form');
  form.fadeToggle();
  if(form.is(":visible")){
     $('#search-recipe-form input').focus();
     if($(document).width() < 768 ){
     	$('#navbar-collapse').fadeOut();
     }
  }
});
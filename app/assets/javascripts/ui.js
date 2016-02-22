
$(document).ready(function(){
  console.log("jQuery est prêt !");
  $('#nav').fadeToggle();
});


// $(function () {
// 	var $window = $(window);
// 	var $nav = $('#nav');

// 	$window.scroll(function () {
// 		if ($window.scrollTop() >= 50 && $nav.css('display') == 'none'){
// 			$('#nav').slideDown();
// 		}else if ($window.scrollTop() <= 50 && $nav.css('display') != 'none'){
// 			$('#nav').slideUp();
// 		}
// 	});
// });

$('#nav-toggle').click(function(){
	$('#nav').fadeToggle();
});
$('a#nav-button').click(function(){
	$('nav').slideToggle();
})

$('nav li').hover(function(){
	$('nav').height('120px');
	//$(this).children().toggle();

});

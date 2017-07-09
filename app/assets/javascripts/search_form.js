$('div.check-search').on('click', function(){
  var container = $(this);
  if(container.find('input[type="checkbox"]').is(':checked')){
    container.addClass('checked');
  }else{
    container.removeClass('checked');
  }
});

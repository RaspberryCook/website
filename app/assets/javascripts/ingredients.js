$('#ingredient_name').on('input', function(e){
    var input = $(this);
    var url = input.attr('data-url');
    $.ajax({

        url: url,
        type: 'POST',
        data: {
            "ingredient[name]": input.val(),
        },
        success: function(data){
            input.autocomplete({
                source: data
            })
        }
    });
});
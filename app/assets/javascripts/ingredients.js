var input = $('#ingredient_name');


input.autocomplete({
    source: [],
    response: function(event, ui){
        $.ajax({

            url: input.attr('data-url'),
            type: 'POST',
            data: {
                "ingredient[name]": input.val(),
            },
            success: function(products){

                var productsNames = [];

                products.forEach(function(product) {
                  productsNames.push({label: product.name, value: product._id});
                });


                input.autocomplete({
                    source: productsNames
                });
            }
        });// ajax
    }// end change
});



let MovieListFilter = {
    filter_adult: function () {
      // 'this' is *unwrapped* element that received event (checkbox)
      if ($(this).is(':checked')) {
        $('.adult').hide();
      } else {
        $('.adult').show();
      };
    },
    setup: function() {
      // construct checkbox with label
      let labelAndCheckbox =
        $('<label for="filter">Only movies suitable for children</label>' +
          '<input type="checkbox" id="filter"/>' );
      if (! $('#filter').length ) {
        labelAndCheckbox.insertBefore('#movies');
      }
      //$('#filter').change(MovieListFilter.filter_adult);
      $('#filter').on('change', MovieListFilter.filter_adult);
    }
}

$(MovieListFilter.setup); // run setup function when document ready
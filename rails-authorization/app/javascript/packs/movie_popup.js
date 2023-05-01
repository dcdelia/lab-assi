var MoviePopup = {
    setup: function() {
      // add hidden 'div' to end of page to display popup:
      let popupDiv = $('<div id="movieInfo"></div>');
      popupDiv.hide().appendTo($('body'));
      $(document).on('click', '#movies a', MoviePopup.getMovieInfo);
    }
    ,getMovieInfo: function() {
      $.ajax({type: 'GET',
              url: $(this).attr('href'),
              timeout: 5000,
              success: MoviePopup.showMovieInfo,
              error: function(xhrObj, textStatus, exception) { alert('Error!'); }
              // 'success' and 'error' functions will be passed 3 args
             });
      return(false);
    }
    ,showMovieInfo: function(data, requestStatus, xhrObject) {
      // center a floater 1/2 as wide and 1/4 as tall as screen
      let oneFourth = Math.ceil($(window).width() / 4);
      $('#movieInfo').
        css({'left': oneFourth,  'width': 2*oneFourth, 'top': 250}).
        html(data).
        show();
      // make the Close link in the hidden element work
      $('#closeLink').on('click',MoviePopup.hideMovieInfo);
      return(false);  // prevent default link action
    }
    ,hideMovieInfo: function() {
      $('#movieInfo').hide();
      return(false);
    }
  };
  $(MoviePopup.setup);
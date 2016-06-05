$(function() {
  $('.current-players-checker').click(function(e) {
    var $target = $(e.currentTarget),
        highlightCssClass = 'selected-for-move',
        shouldAddClass = !$target.hasClass(highlightCssClass);

    e.preventDefault();

    // clear any previous selections
    $('.square').removeClass(highlightCssClass);

    if (shouldAddClass) {
      $target.toggleClass(highlightCssClass);
      $('.game-board').addClass('with-checker-selected');
      GamingNamespace.state.proposedStartMove = '' + $target.data('row') + $target.data('column');
    }
  });

  $('.square').click(function (e) {
    var gameId = $('.game-board').data('id'); // TODO: abstract this to a helper method

    var $target = $(e.currentTarget),
        highlightCssClass = 'selected-for-move',
        isDifferentSquare;

    GamingNamespace.state.proposedEndMove = '' + $target.data('row') + $target.data('column');

    isDifferentSquare = (GamingNamespace.state.proposedStartMove !== GamingNamespace.state.proposedEndMove);

    if (isDifferentSquare && $('.game-board').hasClass('with-checker-selected')) {
      $('input[name="start_move"]').val(GamingNamespace.state.proposedStartMove);
      $('input[name="end_move"]').val(GamingNamespace.state.proposedEndMove);
      $('form.edit_game').submit();
    }
  });
});
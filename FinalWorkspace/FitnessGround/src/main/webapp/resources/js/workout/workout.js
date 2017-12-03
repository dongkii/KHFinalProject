/**
 *  sidebar collapse in workout pages
 */

$(function () {
    $(".workout_sidebar>ul>li>a").bind('click', function () {
      var _this = $(this);

      // Expand the current link
      _this.addClass('active', 5);
      _this.next().removeClass('closed', 50);
      // Contract the others and set off the 'active' state.
      $(".workout_sidebar>ul>li>a").not(_this).each(function () {
        $(this).next().addClass('closed', 50);
        $(this).removeClass('active', 5);
      });
    });
  });
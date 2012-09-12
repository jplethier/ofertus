// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.maskMoney
//= require jquery.dataTables.min
//= require ckeditor/init
//= require popup
//= require script
//= require slides.min.jquery
//= require jquery.carouFredSel-5.6.4
//= require_tree .

$(document).ready(function() {
    $('#help dd').hide();

    $('#help dt a').click(function(){
      if ($($('#help dt a')[0]).hasClass("ativo")) {
        $(this).removeClass('ativo');
      } else {
        $(this).addClass('ativo');
      }

      $(this).parent().next('dd').slideToggle('slow');
    });

    setTimeout(hideFlashes, 2500);

    $("#slides").slides({
      generatePagination: true,
      play: 5000,
      pause: 2500,
      hoverPause: true,
      animationComplete: function(current){
        // Set the slide number as a hash
        window.location.hash = '#' + current;
      }
    });

    $("#partners_list").carouFredSel({
      circular : false,
      infinite : false,
      auto : false,
      prev : "#partners_list_prev",
      next : "#partners_list_next",
      scroll : {
        items : 1
      }
    });
 });

var hideFlashes = function() {
  $('#flash_notice, #flash_warning, #flash_error').fadeOut(1500);
}

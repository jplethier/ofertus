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
//= require turbolinks
//= require uservoice-turbolinks
//= require slides.min.jquery
//= require jquery.carouFredSel-5.6.4
//= require_tree .

$(document).ready(function() {
  //User Voice
  uservoice();

  center_flash();

  ready()
});

$(document).on('page:load', function(){
  //uservoice
  uservoice();

  center_flash();

  ready();
})

$(document).on('page:fetch', function(){
  $('#blocker').height($(document).height());
  $('#blocker').show();
  $('#loading').show();
})

function ready(){
  $('#blocker').hide();
  $('#loading').hide();

  $('#header_search_btn').click(function(){
    $('#user_menu_options').hide();
    $('#settings_menu_options').hide();
    $('#search_form_div').toggle();
  });

  $('#user_menu_link').click(function(){
    $('#settings_menu_options').hide();
    $('#user_menu_options').toggle();
  });

  $('#settings_menu_link').click(function(){
    $('#user_menu_options').hide();
    $('#settings_menu_options').toggle();
  });

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
    hoverPause: true
    // animationComplete: function(current){
      // Set the slide number as a hash
      // window.location.hash = '#' + current;
    // }
  });

  $('#flashes').effect("pulsate", {}, 200);
}

function uservoice(){
  var uvOptions = {default_mode: 'ideas'};
  (function() {
    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/KhjBP9Wz0hWPZKkPOj6DbQ.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
  })();
}

function center_flash(){
  total_width = $("#flashes").width();
  $("#flashes").css('margin-left', '-' + total_width/2 + 'px')
}

var hideFlashes = function() {
  $('#flash_notice, #flash_warning, #flash_error').fadeOut(10500);
}

function chosen_bank(code){
  Popup.close();
  $('#user_withdraw_bank_number').val(code);
}
function follow(user_username, link){
  $.ajax({
    url: '/users/'+user_username+'/follow',
    success: function(data){
      if(data.status == 'erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data.message + '</p></div>')
      }else{
        $('.'+link).attr('onclick',"unfollow('"+user_username+"','"+link+"')").addClass('unfollow')
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data.message + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  })
}

function unfollow(user_username, link){
  $.ajax({
    url: '/users/'+user_username+'/unfollow',
    success: function(data){
      if(data.status == 'erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data.message + '</p></div>')
      }else{
        $('.'+link).attr('onclick',"follow('"+user_username+"','"+link+"')").removeClass('unfollow')
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data.message + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  })
}

$(document).ready(function() {
  endless_user();
});

$(document).on('page:load', function() {
  endless_user();
});

function endless_user(){
  if($('body.users').size()){
    $(window).scroll(function() {
      url = $('.pagination .next_page').attr('href')
      if( url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 250){
        $('.pagination').html('<p>Carregando mais usuários...</p>')
        $.getScript(url)
      }
    })
  }
}
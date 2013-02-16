function follow(user_username, link){
  $.ajax({
    url: 'users/'+user_username+'/follow',
    success: function(data){
      if(data.status == 'erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data.message + '</p></div>')
      }else{
        $('#'+link).attr('onclick',"unfollow('"+user_username+"','"+link+"')").addClass('unfollow')
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data.message + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  })
}

function unfollow(user_id, link){
  $.ajax({
    url: 'users/'+user_username+'/unfollow',
    success: function(data){
      if(data.status == 'erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data.message + '</p></div>')
      }else{
        $('#'+link).attr('onclick',"follow('"+user_username+"','"+link+"')").removeClass('unfollow')
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data.message + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  })
}
function upvote_deal(deal_id){
  $.ajax({
    type: 'GET',
    url: '/deals/' + deal_id + '/upvote',
    success: function(data) {
      if(data[0] == 'Erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data[1] + '</p></div>')
      }else{
        $('.counts .reports').text(data[3])
        $('.counts .likes').text(data[2])
        $('#like_btn').hide()
        $('#unreport_btn').hide()
        $('#dislike_btn').show()
        $('#report_btn').show()
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data[1] + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  });
}

function dislike_deal(deal_id){
  $.ajax({
    type: 'GET',
    url: '/deals/' + deal_id + '/unvote',
    success: function(data) {
      if(data[0] == 'Erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data[1] + '</p></div>')
      }else{
        $('.counts .reports').text(data[3])
        $('.counts .likes').text(data[2])
        $('#dislike_btn').hide()
        $('#like_btn').show()
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data[1] + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  });
}

function report_deal(deal_id){
  $.ajax({
    type: 'GET',
    url: '/deals/' + deal_id + '/downvote',
    success: function(data) {
      if(data[0] == 'Erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data[1] + '</p></div>')
      }else{
        $('.counts .reports').text(data[3])
        $('.counts .likes').text(data[2])
        $('#dislike_btn').hide()
        $('#report_btn').hide()
        $('#like_btn').show()
        $('#unreport_btn').show()
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data[1] + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  });
}

function unreport_deal(deal_id){
  $.ajax({
    type: 'GET',
    url: '/deals/' + deal_id + '/unvote',
    success: function(data) {
      if(data[0] == 'Erro'){
        $('#flashes').append('<div class="alert error" id="flash_notice"><p>' + data[1] + '</p></div>')
      }else{
        $('.counts .reports').text(data[3])
        $('.counts .likes').text(data[2])
        $('#unreport_btn').hide()
        $('#report_btn').show()
        $('#flashes').append('<div class="alert success" id="flash_notice"><p>' + data[1] + '</p></div>')
      }
      center_flash();
      $('#flashes').effect("pulsate", {}, 200);
      setTimeout(hideFlashes, 2500);
    }
  });
}
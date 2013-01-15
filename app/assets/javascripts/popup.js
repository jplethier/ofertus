var Popup = {
  state: {},
  
  actions : { 'default' : { 'data' :  null, 
                            'url'  : '/'} 
            },
  
  open_html : function(html) {
    $('#blocker').height($(document).height());
    $('#blocker').show();
    $('#popup .content').html(html);
    $('#popup').show();
    $('#popup .loading').hide();
  },

  open_url : function(url) {    
    $('#blocker').height($(document).height());
    $('#blocker').show();
    $('#popup .content').html('');
    $('#popup').show();

    $.ajax({
      type: 'GET',
      data: {},
      url: url,
      success: function(html) { 
        $('#popup .main_popup').show().html(html);
      }
    });               
  },
  
  submit : function(div, url) {
    $('div').trigger('submit');
    Popup.open_url('url');
  },
  
  submit_and_add_more : function(url) {
    $('.resource_form').trigger('submit');
    $('#blocker').height($(document).height());
    $('#blocker').show();
    $('#popup .content').html('');
    $('#popup').show();
    $('#popup .loading').show();    

    $.ajax({
      type: 'GET',
      data: {},
      url: url,
      success: function(html) { 
        $('#popup .content').show().html(html);
        $('#popup .loading').hide();
      }
    });
  },
    
  close : function() {
    $('#blocker').hide();
    $('#popup').hide();
    $('#popup iframe').remove()

    return false;
  }
}
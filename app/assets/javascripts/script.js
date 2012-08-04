// $('.bt-compartilhe-off').click(function() {
// 	$('#box-compartilhe').slideToggle();
// });

// $("#categorias-home a").hover(function(){
//     $(this).parent().find("span").stop().animate({"opacity": 1});
// },function(){
//     $(this).parent().find("span").stop().animate({"opacity": 0});
// });

// $('.slide:first').show().parent().find(".bt-info").addClass("bt-mais-slide");
// $('.bt-info').click(function() {
//   $(this).parent().find('.slide').slideToggle('slow', function() {
//     $(this).parent().find(".bt-info").toggleClass('bt-mais-slide');
//   });
// });


/* reset default value */
jQuery.fn.resetDefaultValue = function() {
	function _clearDefaultValue() {
		var _$ = $(this);
		if (_$.val() == this.defaultValue) {
			_$.val('');
		}
	};
	
	function _resetDefaultValue() {
		var _$ = $(this);
		if (_$.val() == '') {
			_$.val(this.defaultValue);
		}
	};
	return this.click(_clearDefaultValue).focus(_clearDefaultValue).blur(_resetDefaultValue);
}

$('.resetValue').resetDefaultValue();
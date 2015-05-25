var main = function() {
	
	for (var i = 0; i < 15; i++) {
		$('#wrapper').append('<div class="row"></div>');
	};
	$('.row').each(function() {
		for (var i = 0; i < 15; i++) {
			$(this).append('<div class="box"></div>');
		};
	});
	
	$('.box').mouseenter(function() {
		$(this).css('background-color', 'white');
	});
};

$(document).ready(main);


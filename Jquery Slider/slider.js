$(document).ready(function() {
	$('#1').fadeIn('slow');
	$('#1').delay(4500).hide('slide', {direction: 'left'}, 200);
	
	var sliderCount = 4;
	var count = 2;
	
	setInterval(function () {
		$('#'+count).show('slide', {direction: 'right'}, 200);
		$('#'+count).delay(4500).hide('slide', {direction: 'left'}, 200);
		
		if(count == sliderCount){
			count = 1;
		}else{
			count = count + 1;
		}
	}, 5500);
		
});


'slide', {direction: 'right'}
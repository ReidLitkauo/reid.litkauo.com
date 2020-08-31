# nn-clear.coffee
# Resets the neural network visuals.

window.nn_clear = () ->

	# Make all top canvases fully transparent and restore all bottom canvases
	$('.nn .network canvas.btm').css 'opacity', 1
	$('.nn .network canvas.top').css 'opacity', 0

	# Fade out input canvas
	$('.nn .io .input canvas').css 'opacity', 0

	# Reset the output to blank
	sevenseg $('.nn .io .output .sevenseg')

	true

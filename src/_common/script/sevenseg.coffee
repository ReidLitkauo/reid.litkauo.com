# sevenseg.coffee
# Support for my seven-segment display

# Call this function with a seven-segment element
# Leave x blank to clear the display
# Otherwise, 0 <= x <= 9 will show x on the display
window.sevenseg = (el, x = null) ->

	# Clear display
	$(el).removeClass("show-#{i}") for i in [0..9]

	# Show the desired number
	if x?
		$(el).addClass "show-#{x}"

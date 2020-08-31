$ ->

	# Open / close navigation with the hamburger menu
	$('header .nav-icon-wrap').on 'click keypress', (e) ->
		$('header').toggleClass 'nav-open'

	# Close navigation if the user clicks outside of it
	$('header .nav-clickout').on 'click keypress', (e) ->
		$('header').removeClass 'nav-open'

	# Also close navigation if a link is followed
	$('header nav a').on 'click keypress', (e) ->
		$('header').removeClass 'nav-open'

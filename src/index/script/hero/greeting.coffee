$ ->

	$('section.hero .greeting a.whatisthis').click (e) ->
		e.preventDefault()
		hero_setMode 'interact-card-1'

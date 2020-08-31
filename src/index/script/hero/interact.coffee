$ ->

	$('section.hero .interact .card.card-1 button').on 'click keypress', (e) ->
		hero_setMode 'interact-card-2'

	$('section.hero .interact .card.card-2 button').on 'click keypress', (e) ->
		hero_setMode 'interact-card-3'

	$('section.hero .interact .card.card-3 button').on 'click keypress', (e) ->
		hero_setMode 'interact-card-4'

	$('section.hero .interact .card.card-4 button').on 'click keypress', (e) ->
		hero_setMode 'greeting' # TODO something else???

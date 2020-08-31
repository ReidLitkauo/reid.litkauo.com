import './hero/nn.coffee'
import './hero/greeting.coffee'
import './hero/interact.coffee'

window.hero_setMode = (mode) ->
	$('section.hero').removeClassMatching /mode-/
		.addClass 'mode-' + mode

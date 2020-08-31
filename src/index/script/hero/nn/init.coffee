# nn-init.coffee
# Handles initialization for the neural network

# Send the request for neural network parameters.
# Do this IMMEDIATELY!
$.ajax(
	'/assets/nn-params.json', {

		cache: true
		dataType: 'json'

		success: (data, status, jqxhr) ->
			$ -> # Have this success function execute when the DOM is ready
				nn_init data

	})

# Also send request for samples to run in the background.
$.ajax(
	'/assets/nn-samples.json', {

		cache: true
		dataType: 'json'

		# Store the samples into memory and attempt to fire the main nn loop
		success: (data, status, jqxhr) ->
			window.nn_samples = data
			nn_loop()

	})

################################################################################
# nn_init
# Initialize the neural network and create the nn DOM

nn_init = (nn_data) ->

	# === === === === === === === === === === === === === === === === === === ==
	# Initialization

	# Make data globally available
	window.nn_data = nn_data

	# Connection positioning parameters
	# Used to position the neurons and connections
	# TODO Change these if I decide to change the layout!
	# init: the offset from the top/left
	# delta: distance from center of one neuron to the next
	# unit: what's used? vmin, vw, px, em, you know
	# And special: vhtdft, vertical height default, used for horizontal lines
	pos_hinit  = 0#15
	pos_hdelta = 50#30
	pos_hunit  = '%'#'vmin'
	pos_vinit  = 0#2
	pos_vdelta = (100/15)#5
	pos_vhtdft = 2#1
	pos_vunit  = '%'#'vmin'

	# === === === === === === === === === === === === === === === === === === ==
	# Initialize the input squares
	#$(".nn .io .input").append $('<div>').addClass("input-#{i}") for i in [0 ... 28*28]

	# === === === === === === === === === === === === === === === === === === ==
	# Initialize all neurons

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	# Let's start by grabbing contexts

	# Public contexts, the ones that we'll be drawing on later
	window.nn_neuron_ctx =( $('.network .neurons.layer-' + i + ' canvas.top')[0].getContext('2d') for i in [0 .. 2] )

	# These contexts only need to be drawn on once
	neuron_btmctx = ( $('.network .neurons.layer-' + i + ' canvas.btm')[0].getContext('2d') for i in [0 .. 2] )

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	# Draw the neurons

	for layer_i in [0 .. 2]

		# Raw neuron index, converted below
		for n_i in [0 .. 15]

			# Special case: We're in the third layer (i==2)
			# Skip n_i 0-2 & 13-15
			# so third layer neurons can skip those positions
			if layer_i is 2 and (n_i in [0..2] or n_i in [13..15])
				continue

			# Convert neuron number according to special case for third layer:
			# Subtract 3 because of above weirdness
			neuron_i = if layer_i is 2 then n_i - 3 else n_i

			# Determine position and radii
			pos_x  = 90
			pos_y  = 90 + (n_i * 200)
			pos_r1 = 90
			pos_r2 = 70

			# Draw the first circle in border color
			neuron_btmctx[layer_i].beginPath()
			neuron_btmctx[layer_i].fillStyle = nn_bias2color nn_data.biases[layer_i][neuron_i]
			neuron_btmctx[layer_i].arc pos_x, pos_y, pos_r1, 0, 2 * Math.PI
			neuron_btmctx[layer_i].fill()
			neuron_btmctx[layer_i].closePath()

			# Draw the second circle in neutral color
			neuron_btmctx[layer_i].beginPath()
			neuron_btmctx[layer_i].fillStyle = "hsl(0deg, 0%, 15%)"
			neuron_btmctx[layer_i].arc pos_x, pos_y, pos_r2, 0, 2 * Math.PI
			neuron_btmctx[layer_i].fill()
			neuron_btmctx[layer_i].closePath()

	# === === === === === === === === === === === === === === === === === === ==
	# Initialize all connections

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	# Grab some contexts

	# Public contexts, the ones that we'll be drawing on later
	window.nn_conn_ctx =( $('.network .connections.layer-' + i + ' canvas.top')[0].getContext('2d') for i in [0 .. 1] )

	# These contexts only need to be drawn on once
	conn_btmctx = ( $('.network .connections.layer-' + i + ' canvas.btm')[0].getContext('2d') for i in [0 .. 1] )

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	# Draw initial connections

	for layer_i in [0 .. 1]

		# A spot of initialization here
		# Let's set the line width properly
		conn_btmctx[layer_i].lineWidth = 10
		nn_conn_ctx[layer_i].lineWidth = 10

		# Raw neuron index, again converted below
		# This is used for positioning later
		for n_i in [0 .. 15]

			# Another raw index, this time for the next layer
			# np stands for n' or n-prime, idk man
			for np_i in [0 .. 15]

				# Special case:
				# We're in the second layer, going to the third.
				# Don't draw any connections headed to 0-2 or 13-15
				if layer_i is 1 and (np_i in [0..2] or np_i in [13..15])
					continue

				# Converted n_i and np_i, used for correct weight indexing
				neuron_i = n_i
				neuronp_i = if layer_i is 1 then np_i - 3 else np_i

				# Determine starting and ending points
				pos_x1 = 0
				pos_y1 = 90 + (n_i * 200)
				pos_x2 = 970
				pos_y2 = 90 + (np_i * 200)

				# Draw some lines!
				conn_btmctx[layer_i].beginPath()
				conn_btmctx[layer_i].strokeStyle = nn_weight2color nn_data.weights[layer_i+1][neuronp_i][neuron_i], 15
				conn_btmctx[layer_i].moveTo pos_x1, pos_y1
				conn_btmctx[layer_i].lineTo pos_x2, pos_y2
				conn_btmctx[layer_i].stroke()
				conn_btmctx[layer_i].closePath()

	# === === === === === === === === === === === === === === === === === === ==
	# Cleanup

	# Attempt to start main nn looping animation
	nn_loop()

	true

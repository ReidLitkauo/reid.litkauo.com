# nn-run.coffee
# Call this function with an input to run the nn & the visuals

window.nn_run = (activation) ->

	############################################################################
	# Call the neural network

	# This calculation shouldn't take too long (a few milliseconds?)
	# So I'm comfortable with blocking until it finishes
	# Remember: results[0] is the guess
	# results[1] is an array of all activations in the neural network
	# (input layer included)
	results = nn_guess window.nn_data.weights, window.nn_data.biases, activation

	############################################################################
	# Draw all canvases

	# === === === === === === === === === === === === === === === === === === ==
	# Input

	# Initialization
	in_ctx = $('.nn .io .input canvas')[0].getContext('2d')
	in_ctx.clearRect 0, 0, 28, 28

	# Create new image within canvas's context
	in_img = in_ctx.createImageData 28, 28

	# Set RGBA data directly
	for i in [0 .. 28*28]
		in_img.data[ i * 4 + 0 ] = 255
		in_img.data[ i * 4 + 1 ] = 255
		in_img.data[ i * 4 + 2 ] = 255
		in_img.data[ i * 4 + 3 ] = Math.round activation[i] * 255

	# And draw the image
	in_ctx.putImageData in_img, 0, 0

	# === === === === === === === === === === === === === === === === === === ==
	# Neurons

	for layer_i in [0 .. 2]

		# Clear the canvas
		nn_neuron_ctx[layer_i].clearRect 0, 0, 180, 3180

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

			# Determine new fill color
			color_value = Math.round results[1][layer_i + 1][neuron_i] * 100
			color_full = "hsl(0deg, 0%, " + color_value + "%)"

			# Draw the first circle in border color
			nn_neuron_ctx[layer_i].beginPath()
			nn_neuron_ctx[layer_i].fillStyle = nn_bias2color nn_data.biases[layer_i][neuron_i]
			nn_neuron_ctx[layer_i].arc pos_x, pos_y, pos_r1, 0, 2 * Math.PI
			nn_neuron_ctx[layer_i].fill()
			nn_neuron_ctx[layer_i].closePath()

			# Draw the second circle in neutral color
			nn_neuron_ctx[layer_i].beginPath()
			nn_neuron_ctx[layer_i].fillStyle = color_full
			nn_neuron_ctx[layer_i].arc pos_x, pos_y, pos_r2, 0, 2 * Math.PI
			nn_neuron_ctx[layer_i].fill()
			nn_neuron_ctx[layer_i].closePath()

	# === === === === === === === === === === === === === === === === === === ==
	# Connections

	for layer_i in [0 .. 1]

		# Clear the canvas
		nn_conn_ctx[layer_i].clearRect 0, 0, 970, 3180

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

				# Determine opacity
				opacity = Math.round results[1][layer_i + 1][neuron_i] * 80

				# Draw some lines!
				nn_conn_ctx[layer_i].beginPath()
				nn_conn_ctx[layer_i].strokeStyle = nn_weight2color nn_data.weights[layer_i+1][neuronp_i][neuron_i], opacity
				nn_conn_ctx[layer_i].moveTo pos_x1, pos_y1
				nn_conn_ctx[layer_i].lineTo pos_x2, pos_y2
				nn_conn_ctx[layer_i].stroke()
				nn_conn_ctx[layer_i].closePath()


	############################################################################
	# Visualization

	# === === === === === === === === === === === === === === === === === === ==
	# Input

	$('.nn .io .input canvas').css 'opacity', 1

	# === === === === === === === === === === === === === === === === === === ==
	# First layer

	await sleep 400

	$('.nn .network .neurons.layer-0 canvas.top').css 'opacity', 1

	# === === === === === === === === === === === === === === === === === === ==
	# Connection to second layer

	await sleep 400

	$('.nn .network .connections.layer-0 canvas.btm').css 'opacity', 0
	$('.nn .network .connections.layer-0 canvas.top').css 'opacity', 1

	# === === === === === === === === === === === === === === === === === === ==
	# Second layer

	await sleep 500

	$('.nn .network .neurons.layer-1 canvas.top').css 'opacity', 1

	# === === === === === === === === === === === === === === === === === === ==
	# Transition to third layer

	await sleep 400

	$('.nn .network .connections.layer-1 canvas.btm').css 'opacity', 0
	$('.nn .network .connections.layer-1 canvas.top').css 'opacity', 1

	# === === === === === === === === === === === === === === === === === === ==
	# Third layer

	await sleep 400

	$('.nn .network .neurons.layer-2 canvas.top').css 'opacity', 1

	# === === === === === === === === === === === === === === === === === === ==
	# Seven-segment display

	await sleep 400

	# Let's show the result!
	sevenseg $('.nn .io .output .sevenseg'), results[0]

	true

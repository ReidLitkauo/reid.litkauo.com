# /src/index/script/nn-guess.coffee
# Given the weights and biases of a neural network
# and an initial activation,
# calculate all hidden activations & the final activation,
# and guess what number the inputs correspond to.
# nn_guess(...)[0] is the guessed number.
# nn_guess(...)[1] is all the activations.
# This script took me many, many days to write.

window.nn_guess = (weights, biases, activation) =>

	# === === === === === === === === === === === === === === === === === === ==
	# Helper functions

	# Transpose a 2D array
	arr_transpose = (matrix) -> (t[i] for t in matrix) for i in [0...matrix[0].length]

	# Find index of max value of 1D array
	arr_maxi = (a) ->
		imax = 0
		for i, val of a
			if val >= a[imax]
				imax = i
		parseInt imax

	# Sigmoid
	sigmoid = (x) -> (1.0 / (1.0 + Math.exp(-x)))

	# === === === === === === === === === === === === === === === === === === ==
	# Feed-forward

	# Calculate one propogation of the network
	feed_forward = (w, b, a) ->

		# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		# Initialization

		# Return matrix z = a'
		z = []

		# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		# Audit matrix dimensions

		# Three audits need to be completed:
		# 1) w.cols == a.rows
		#    w*a is defined
		# 2) b.rows == w.rows
		# 3) b.cols == a.cols
		#    b can be added to the above matrix

		# 1)
		for i, wrow of w
			if wrow.length isnt a.length
				throw '[' + i + '] wcols != arows: ' + wrow.length + ' != ' + a.length

		# 2)
		if b.length isnt w.length
			throw 'brows != wrows: ' + b.length + ' != ' + w.length

		# 3)
		for i, brow of b
			if brow.length isnt a[0].length
				throw '[' + i + '] bcols != acols: ' + b[i].length + ' != ' + a[0].length

		# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		# Helper variables

		wrows = w.length
		wcols = w[0].length
		arows = a.length
		acols = a[0].length

		# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		# Compute sig( W*a + b ) over every element

		# Now this whole thing could probably be done in one single,
		# huge, messy comprehension.
		# But I'm not about to do that.

		# Loop over each row of w
		for wi in [0...wrows]

			# Add this row to z
			zrow = []

			# Loop over each column of a
			for aj in [0...acols]

				# Add this entry to zrow
				zentry = 0

				# Compute z[wi][aj] = sig(wa+b)
				# Start with wa, then add b, then sigmoid
				zentry += w[wi][n] * a[n][aj] for n in [0...wcols]
				zentry += b[wi][aj]
				zentry = sigmoid(zentry)

				# Insert entry into row
				zrow[aj] = zentry

			# Insert row into z
			z[wi] = zrow

		# Return z = a', the next iteration of the network
		z

	# === === === === === === === === === === === === === === === === === === ==
	# Run initial activations through neural network

	# Keep track of all activations
	# NOTE: We receive the initial activations as a 1D array.
	# Let's convert that into a column vector first...
	activation_list = [ arr_transpose([activation]) ]

	# Process a', a'', and so on
	for layeri in [0 ... biases.length]
		activation_list[layeri + 1] = feed_forward(
			weights[layeri],
			arr_transpose([ biases[layeri] ]),
			activation_list[layeri]
		)

	# === === === === === === === === === === === === === === === === === === ==
	# Return to calling script

	# Return looks like this:
	# ret[0] is the guess
	# ret[1] is an array of all the activations
	#console.log activation_list[ activation_list.length - 1 ]
	[ arr_maxi( arr_transpose(activation_list[ activation_list.length - 1 ])[0] ) , activation_list ]

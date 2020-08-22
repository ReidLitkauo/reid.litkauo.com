# nn-junk.coffee
# Junk drawer for neural network

################################################################################
# nn_bias2color
# Convert a bias to a color
window.nn_bias2color = (p, alpha = 100) ->

	if not window.nn_data?
		throw 'nn_data not loaded'

	if not this.min? or not this.max?
		this.min = 999999
		this.max = -999999
		for b in window.nn_data.biases
			for v in b
				if v > this.max
					this.max = v
				if v < this.min
					this.min = v

	# Normalize p to [0,1]
	p = (p - this.min) / (this.max - this.min)

	# Run through sigmoid to get a better spread of colours
	p = sigmoid( -8 * (1 - 2 * (p + .01)) )

	"hsla(" + (30 + Math.round(p * 300)) + "deg, 80%, 50%, " + alpha + "%)"

################################################################################
# nn_weight2color
# Convert a weight to a color
window.nn_weight2color = (p, alpha = 100) ->

	if not window.nn_data?
		throw 'nn_data not loaded'

	# Calculate minimum and maximum
	if not this.min? or not this.max?
		this.min = 999999 # Large number for min, little number for max
		this.max = -999999 # That way, we're bound to override them
		for w in window.nn_data.weights
			for r in w
				for v in r
					if v < this.min
						this.min = v
					if v > this.max
						this.max = v

	# Normalize p to [0,1]
	p = (p - this.min) / (this.max - this.min)

	# Run through sigmoid to get a better spread of colours
	p = sigmoid( -8 * (1 - 2 * (p)) )

	"hsla(" + (30 + Math.round(p * 300)) + "deg, 80%, 50%, " + alpha + "%)"

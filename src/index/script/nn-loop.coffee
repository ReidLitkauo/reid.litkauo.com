# nn-loop.coffee
# The main animation loop.
# Break this loop by setting nn_loop.break = true

window.nn_loop = () ->

	if not window.nn_data? or not window.nn_samples?
		return false

	this.break ?= false
	this.i ?= 0

	while not this.break

		nn_clear()

		await sleep 1500

		await nn_run nn_samples[this.i++ % window.nn_samples.length]

		await sleep 3000

	true

# contact.coffee
# Scripting for the "contact me" section

################################################################################
# Initialization
$ ->

	# === === === === === === === === === === === === === === === === === === ==
	# Retrieve the captcha to use

	$.ajax '/captcha/generate', {

		# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		success: (data, textstatus, jqxhr) ->

			# Update the displayed question
			$('section.contact form .captcha span').html data.q

			# Append hidden answer fields
			for ans in data.a
				$('section.contact form').append "<input type='hidden' name='captcha_answer[]' value='#{ans}'>"

		# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		error: (jqxhr, textstatus, error) ->
			console.log 'Error while getting captcha: ' + textstatus

	}

################################################################################
# Form submission hooks

window.contact_beforeSubmit = (e) ->

	# Disable the button and apply some styles
	$('section.contact form button').prop 'disabled', 'true'
	$('section.contact form button > *').not('.loading').css 'opacity', '0'
	$('section.contact form button .loading').css 'opacity', '1'

window.contact_success = (data, textstatus, jqxhr) ->
	$('section.contact form .fields').css 'opacity', '0'
	$('section.contact form .success').css {'opacity': '1', 'z-index': '2'}

window.contact_error = (jqxhr, textstatus, error) ->

	# Display the error message and re-enable the button
	$('section.contact form button').prop 'disabled', ''
	$('section.contact form button > *').not('.error').css 'opacity', '0'
	$('section.contact form button .error').css 'opacity', '1'
		.html jqxhr.responseJSON.msg

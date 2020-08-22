<? #############################################################################
# /framework/captcha.php
# Functions to generate and verify captchas in a stateless way

function captcha_generate () {

	global $secret;

	# Fetch raw captcha data
	$ret = json_decode(file_get_contents($secret['captcha_source']));

	# Salt and bcrypt answers
	for ( $i = 0; $i < count($ret->a); $i++ )
		$ret->a[$i] = password_hash( $ret->a[$i] . $secret['captcha_salt'], PASSWORD_DEFAULT );

	# $ret->q holds the written question
	# $ret->a is an array of hashes of all the valid answers
	return $ret;

}

function captcha_verify ($guess, $answers) {

	global $secret;

	# Prepare the guess in the same way my captcha source prepared it
	$guess_prep = md5(strtolower(trim( $guess ))) . $secret['captcha_salt'];

	# Validate the guess against each possible answer
	# Run the guess through
	foreach ($answers as $ans)
		if ( password_verify($guess_prep, $ans) )
			return true;

	# Validation failed
	return false;

}

<?php

header('Content-type: application/json');

# === === === === === === === === === === === === === === === === === === === ==
# Make sure the captcha is correct

if (!captcha_verify( $_POST['captcha_response'], $_POST['captcha_answer'] )) {
	echo json_encode(['msg' => 'Incorrect captcha response, please try again.']);
	http_response_code(403);
	exit();
}

# === === === === === === === === === === === === === === === === === === === ==
# Validate all other inputs

$email_name =  $_POST['name']    ? $_POST['name']    : '<empty name>';
$email_email = $_POST['email']   ? $_POST['email']   : '<empty email>';
$email_msg =   $_POST['message'] ? $_POST['message'] : '<empty message>';

# === === === === === === === === === === === === === === === === === === === ==
# Send the email

$mail = new PHPMailer\PHPMailer\PHPMailer(true);

try {

	# Settings
	$mail->isSMTP();
	$mail->Host       = $secret['phpmailer_host'];
	$mail->SMTPAuth   = true;
	$mail->Username   = $secret['phpmailer_user'];
	$mail->Password   = $secret['phpmailer_pass'];
	$mail->SMTPSecure = PHPMailer\PHPMailer\PHPMailer::ENCRYPTION_STARTTLS;
	$mail->Port       = 587;

	# To/From
	# TODO For some reason I can't add user-supplied from / reply-to
	$mail->setFrom($secret['phpmailer_user']);
	$mail->addAddress('reid@litkauo.com');

	# Content
	# TODO Make name/email into from or reply-to fields?
	$mail->Subject = 'Message from your personal website!';
	$mail->Body    = $email_name . "\n" . $email_email . "\n\n" . $email_msg;

	# Send it!
	$mail->send();

} catch (Exception $e) {
	# TODO Error logging? Still haven't figured out how to make that work
	http_response_code(500);
	echo json_encode(['msg' => 'Error encountered while sending email, please try again.']);
	exit();
}

# === === === === === === === === === === === === === === === === === === === ==
# Cleanup

echo json_encode(['msg' => 'Email sent successfully.']);

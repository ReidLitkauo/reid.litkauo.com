<? #############################################################################
# framework/$.php
# Entry point for including all private framework files.

################################################################################
# Secret

# This webapp requires access to certain secret information, things like
# passwords, credentials, salts, and private keys. The below file will create
# a publicly-available $secret variable and load all required information as
# key-value pairs:

# captcha_source: The URL from which I derive my written captchas.
# captcha_salt:   Used to render brute-force attacks on the captcha infeasible.

# phpmailer_host: An SMTP server used to send email.
# phpmailer_user: Email address used to log in to the SMTP server.
# phpmailer_pass: Password for logging into the SMTP server.

# Obviously I won't show you this file.

require_once __DIR__ . '/../secret/$.php';

################################################################################
# First-party

require_once 'template.php';
require_once 'captcha.php';

################################################################################
# Third-party

# PHPMailer
require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

<?php

header('Content-type: application/json');

echo json_encode( captcha_generate() );

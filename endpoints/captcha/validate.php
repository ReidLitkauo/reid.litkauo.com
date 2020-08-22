<?php

header('Content-type: application/json');

echo json_encode([ 'guess' => $_POST['guess'], 'answers' => $_POST['answers'], 'correct' => captcha_verify($_POST['guess'], $_POST['answers']) ]);

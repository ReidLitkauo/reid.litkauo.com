<?php

Phug::setOption('debug', false);


$templatesDirectories = [
    // Replace with your templates directories locations (could be one or more directories)
    __DIR__ . '/src',
];

\Phug\Phug::setOptions([
    'paths'     => $templatesDirectories,
	'keep_base_name' => true,
]);

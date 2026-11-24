<?php


return new \Phalcon\Config(array(
    'database' => array(
         'schema'   => getenv('DB_SCHEMA') ?: 'public',
         'adapter'  => getenv('DB_ADAPTER') ?: 'Postgresql',
         'host'     => getenv('DB_HOST') ?: 'localhost',
         'username' => getenv('DB_USER') ?: 'supersociedades',
         'password' => getenv('DB_PASS') ?: 'DB_SECURE_PASSWORD',
         'dbname'   => getenv('DB_NAME') ?: 'supersoc_chatbot',
    ),

    'application' => array(
        'controllersDir' => __DIR__ . '/../../app/controllers/',
        'modelsDir'      => __DIR__ . '/../../app/models/',
        'modelsCms'      => __DIR__ . '/../../app/models-cms/',
        'pluginsDir'     => __DIR__ . '/../../app/plugins/',
        'libraryDir'     => __DIR__ . '/../../app/library/',
        'constantsDir'   => __DIR__ . '/../../app/library/constants',
        'enumsDir'       => __DIR__ . '/../../app/library/constants/enums',
        'tasksDir'       => __DIR__ . '/../../app/tasks',
        'baseUri' => '/api_devel/',

    ),

));

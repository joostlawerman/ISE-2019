<?php

$config = json_decode(file_get_contents("../config.json"));

$pdo = new PDO("mssql:host=${config['database']['host']};dbname=${config['database']['dbname']};", $config['database']['user'], $config['database']['password']);

include_once "classes/Chessclub.php";

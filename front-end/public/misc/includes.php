<?php

$config = json_decode(file_get_contents("../config.json"), true);

$pdo = new PDO("sqlsrv:Server=".$config['database']['host'].";Database=".$config['database']['dbname']."", $config['database']['user'], $config['database']['password']);

include_once "classes/Chessclub.php";

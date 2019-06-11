<?php

$config = json_decode(file_get_contents("../config.json"), true);

$pdo = new PDO("sqlsrv:Server=".$config['database']['host'].";Database=".$config['database']['dbname']."", $config['database']['user'], $config['database']['password']);

include_once ("misc/functions.php");

foreach (scandir("classes") as $value) {
    if (substr($value, -4) == ".php") {
        include_once "classes/${value}";
    }
}


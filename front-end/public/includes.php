<?php

$config = json_decode(file_get_contents("config.json"));

$pdo = new PDO("mssql:host=localhost;dbname=ISE;");

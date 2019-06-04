<?php

class Chessclub {

    /** @var $pdo PDO */
    public static $pdo;

    static function getChessclubs() : array {
        $statement = self::$pdo->prepare("EXEC SP_GET")
    }
}

Chessclub::$pdo &= $pdo;

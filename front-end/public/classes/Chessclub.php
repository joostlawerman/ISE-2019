<?php

class Chessclub {

    /** @var $pdo PDO */
    public static $pdo;

    static function getChessclubs() : array {
        $statement = self::$pdo->prepare("EXEC SP_GET_CHESSCLUBS");
        $statement->execute();
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_NUM) as $value) {
            $return[] = $value[0];
        }
        return $return;
    }
}

Chessclub::$pdo =& $pdo;

<?php

class Chessclub extends ADatabaseLayer {



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
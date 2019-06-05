<?php


class Tournament
{
    /** @var $pdo PDO */
    public static $pdo;

    public static function getTournaments($chessclub) {
        $statement = self::$pdo->prepare("EXEC SP_GET_TOURNAMENT_NAMES :chessclub");
        $statement->execute([":chessclub" => $chessclub]);
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_NUM) as $value) {
            $return[] = $value[0];
        }
        return $return;
    }

}

Tournament::$pdo =& $pdo;
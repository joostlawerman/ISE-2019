<?php


class Round extends ADatabaseLayer
{
    public function __construct($chessclub, $tournament, $roundnumber)
    {
        $statement = self::$pdo->prepare("EXEC SP_GET_ROUNDS :chessclub, :tournament, :round");
        $statement->execute([':chessclub' => $chessclub, 'tournament' => $tournament, ':round' => $roundnumber]);
        $info = ['chessclubname', 'tournamentname', 'roundnumber', 'system',];

    }

    public static function getSystems()
    {
        $statement = self::$pdo->prepare("EXEC SP_GET_SYSTEMS");
        $statement->execute();
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_NUM) as $value) {
            $return[] = $value;
        }
        return $return;
    }
}
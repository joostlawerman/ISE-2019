<?php


class Poule extends ADatabaseLayer
{
    public $info = [
        'chessclubname'  => "",
        'tournamentname' => "",
        'roundnumber'    => "",
        'pouleno'        => "",
    ];

    public function __construct(string $chessclub, string $tournament, int $roundnumber, int $poule)
    {
        $statement  = self::$pdo->prepare("EXEC SP_GET_POULES_OF_ROUND :chessclub, :tournament, :roundnumber, :poule");
        $parameters = [
            ":chessclub"   => $chessclub,
            ":tournament"  => $tournament,
            ":roundnumber" => $roundnumber,
            ":poule"       => $poule,
        ];

        $statement->execute($parameters);
        $info       = $statement->fetch(PDO::FETCH_ASSOC);
        $this->info = !$info ? $this->info : $info;
    }

    public function getPlayers()
    {
        $statement  = self::$pdo->prepare("EXEC SP_GET_PLAYERS_OF_POULE :chessclub, :tournament, :roundnumber, :poule");
        $parameters = [
            ":chessclub"   => $this->info['chessclubname'],
            ":tournament"  => $this->info['tournamentname'],
            ":roundnumber" => $this->info['roundnumber'],
            ":poule"       => $this->info['pouleno'],
        ];
        $statement->execute($parameters);
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_NUM) as $value) {
            $return[] = new Player($value[0]);
        }

        return $return;

    }
}
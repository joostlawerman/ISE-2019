<?php


class Round extends ADatabaseLayer
{
    public $info = [
        'chessclubname'  => "",
        'tournamentname' => "",
        'roundnumber'    => "",
        'system'         => "",
        'starts'         => "",
        'ends'           => "",
    ];

    public function __construct($chessclub, $tournament, $roundnumber)
    {
        $statement = self::$pdo->prepare("EXEC SP_GET_ROUNDS :chessclub, :tournament, :round");
        $statement->execute([':chessclub' => $chessclub, 'tournament' => $tournament, ':round' => $roundnumber]);
        $info = $statement->fetch(PDO::FETCH_ASSOC);
        if ($info !== false) {
            $info['starts'] = new DateTime($info['starts']);
            $info['ends']   = new DateTime($info['ends']);
        }
        $this->info = !$info ? $this->info : $info;
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

    /**
     * @return Poule[]
     */
    public function getPoules() : array
    {
        $statement = self::$pdo->prepare("EXEC SP_GET_POULES_OF_ROUND :chessclub, :tournament, :round");
        $statement->execute([
            ':chessclub'  => $this->info['chessclubname'],
            ':tournament' => $this->info['tournamentname'],
            ':round'      => $this->info['roundnumber'],
        ]);
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_ASSOC) as $value) {
            $return[] = new Poule($value['chessclubname'], $value['tournamentname'], $value['roundnumber'], $value['pouleno']);
        }

        return $return;
    }
}
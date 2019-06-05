<?php


class Tournament extends ADatabaseLayer
{

    public $info = [
        'chessclubname' => "",
        'tournamentname' => "",
        'winner' => "",
        'contactname' => "",
        'starts' => "",
        'ends' => "",
        'registrationfee' => "",
        'addressline1' => "",
        'postalcode' => "",
        'city' => "",
        'registrationdeadline' => "",

    ];

    public static function getTournaments($chessclub) {
        $statement = self::$pdo->prepare("EXEC SP_GET_TOURNAMENT_NAMES :chessclub");
        $statement->execute([":chessclub" => $chessclub]);
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_NUM) as $value) {
            $return[] = $value[1];
        }
        return $return;
    }

    public function __construct(string $chessclub = null, string $tournamentname = null)
    {
        if ($chessclub == null || $tournamentname == null) {
            return;
        }

        $statement = self::$pdo->prepare("EXEC SP_GET_TOURNAMENT_INFO :chessclub, :tournamentname");
        $statement->execute([':chessclub' => $chessclub, ':tournamentname' => $tournamentname]);
        $info = $statement->fetch(PDO::FETCH_ASSOC);
        $this->info = !$info ? $this->info : $info;
    }


    /**
     * @return Round[] array
     */
    public function getRounds() :array {
        $statement = self::$pdo->prepare("EXEC SP_GET_ROUNDS :chessclub, :tournamentname");
        $statement->execute([':chessclub' => $this->info['chessclubname'], ':tournamentname' => $this->info['tournamentname']]);
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_ASSOC) as $value) {
            $return[] = new Round($value['chessclubname'], $value['tournamentname'], $value['roundnumber']);
        }
        return $return;
    }
}
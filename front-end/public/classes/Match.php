<?php


class Match extends ADatabaseLayer
{
    public $info = [
        'matchno'        => "",
        'chessclubname'  => "",
        'tournamentname' => "",
        'roundnumber'    => "",
        'pouleno'        => "",
        'playeridwhite'  => "",
        'playeridblack'  => "",
        'result'         => "",
    ];

    public function __construct(int $matchno)
    {
        $this->load($matchno);
    }

    public function load($matchno) {
        $statement  = self::$pdo->prepare("EXEC SP_GET_MATCH :match");
        $parameters = [
            ":match" => $matchno,
        ];



        $statement->execute($parameters);
        $info = $statement->fetch(PDO::FETCH_ASSOC);
        $this->info = !$info ? $this->info : $info;
    }

    public function setResult(string $result)
    {
        $statement  = self::$pdo->prepare("EXEC SP_INSERT_RESULT :match, :result");
        $parameters = [
            ":match"  => $this->info['matchno'],
            ":result" => $this->parseResult($result),
        ];
        echo fillQuery($statement->queryString, $parameters);
        $statement->execute($parameters);
        $this->load($this->info['matchno']);
    }

    public function getResultFromPlayer(int $playerId) : string {
        if ($this->info['result'] == null) {
            return "--";
        }
        if ($this->info['result'] == 'remise') {
            return '&frac12;';
        }
        if ($playerId == $this->info['playeridblack']) {
            return $this->info['result'] == "black" ? "1" : "0";
        }
        if ($playerId == $this->info['playeridwhite']) {
            return $this->info['result'] == "white" ? "1" : "0";
        }
    }

    private function parseResult(string $result) : string
    {
        if ($result == '0.5') {
            return 'remise';
        } elseif ($result == '--') {
            return null;
        } else {
            $result = str_split($result);
            if ($result[0] == $this->info['playeridblack']) {
                return $result[1] == 1 ? 'black' : 'white';
            } else {
                return $result[1] == 1 ? 'white' : 'black';
            }
        }
    }
}
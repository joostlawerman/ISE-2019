<?php


class Match extends ADatabaseLayer
{
    public $info = [

    ];

    public function __construct(int $matchno)
    {
        $statement  = self::$pdo->prepare("EXEC SP_GET_MATCH :match");
        $parameters = [
            ":match"   => $matchno,
        ];

        $statement->execute($parameters);
        $info       = $statement->fetch(PDO::FETCH_ASSOC);
        $this->info = !$info ? $this->info : $info;
        var_dump($this->info);
    }
}
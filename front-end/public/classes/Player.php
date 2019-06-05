<?php


class Player extends ADatabaseLayer
{
    public $info = [
        'playerid'      => "",
        'chessclubname' => "",
        'firstname'     => "",
        'lastname'      => "",
        'addressline1'  => "",
        'postalcode'    => "",
        'city'          => "",
        'birthdate'     => "",
        'emailaddress'  => "",
        'gender'        => "",
    ];

    public function __construct(int $playerId)
    {
        $statement = self::$pdo->prepare("EXEC SP_GET_PLAYER_INFO :playerid");
        $statement->execute([":playerid" => $playerId,]);
        $info       = $statement->fetch(PDO::FETCH_ASSOC);
        $this->info = !$info ? $this->info : $info;
    }

    public function getName() {
        return ucfirst($this->info['firstname']).' '.ucfirst($this->info['lastname']);
    }
}
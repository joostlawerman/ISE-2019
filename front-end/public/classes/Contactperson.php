<?php


class Contactperson
{
    /** @var $pdo PDO */
    public static $pdo;

    static function getContactpersons() : array {
        $statement = self::$pdo->prepare("EXEC SP_GET_CONTACTPERSONS");
        $statement->execute();
        $return = [];
        foreach ($statement->fetchAll(PDO::FETCH_NUM) as $value) {
            $return[] = $value[0];
        }
        return $return;
    }

}

Contactperson::$pdo =& $pdo;

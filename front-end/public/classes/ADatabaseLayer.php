<?php


abstract class ADatabaseLayer
{
    /** @var $pdo PDO */
    public static $pdo;
    public        $info = [];

    public function getInfo() : array
    {
        $this->info == false ? [] : $this->info;
    }
}

ADatabaseLayer::$pdo =& $pdo;
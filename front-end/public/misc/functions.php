<?php

function fillQuery(string $query, array $parameters) : string
{
    foreach ($parameters as $key => $value) {
        if ($key[0] != ':') {
            $key = ":{$key}";
        }
        $query = str_replace($key, "'".$value."'", $query);
    }

    return $query;
}
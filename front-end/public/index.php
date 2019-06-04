<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Creeer toernooi</title>
</head>
<body>
<?php
include "menu.php"
?>
<main>
    <h1>Cre&euml;er toernooi</h1>
    <form method="post" action="index.php?posted">
        <table>
            <tr>
                <td>Naam Toernooi</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="name">
                </td>
            </tr>
            <tr>
                <td>Start datum</td>
            </tr>
            <tr>
                <td>
                    <input type="date" name="start">
                </td>
            </tr>
            <tr>
                <td>Eind datum</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="end">
                </td>
            </tr>
            <tr>
                <td>Inschrijfgeld</td>
            </tr>
            <tr>
                <td>
                    <input type="number" min="0.00" step="any" name="entryfee">
                </td>
            </tr>
            <tr>
                <td>Adres</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="adres">
                </td>
            </tr>
            <tr>
                <td>Postcode</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="postcode">
                </td>
            </tr>
            <tr>
                <td>Stad</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="city">
                </td>
            </tr>
            <tr>
                <td>Registratie Tijdsgrens</td>
            </tr>
            <tr>
                <td>
                    <input type="date" name="deadline">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit">
                </td>
            </tr>
        </table>
    </form>
</main>
</body>
</html>
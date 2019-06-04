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
    <?php
    require_once "includes.php";

    if (isset($_POST['name'])) {
        $required = ['name', 'start', 'end', 'entryfee', 'adres', 'postcode', 'city', 'deadline'];
        foreach ($required as $value) {
            if (!isset($_POST[$value])) {
                $invalid = true;
                ?>
                <span class="error">
                    Er missen een aantal velden
                </span>
                <?php
                break;
            }
        }
    }

    if (!$invalid) {
        $parameters = [];
        foreach ($_POST as $key => $value) {
            $parameters[":".$key] = $value;
        }

        $statement = $pdo->prepare("EXEC SP_CREATE_TOURNAMENT")
SP_CREATE_TOURNAMENT
@chessclubname varchar(100),
@tournamentname varchar(100),
@contactname varchar(101),
@starts datetime,
@ends datetime,
@registrationfee money,
@addressline1 varchar(100),
@postalcode varchar(6),
@city varchar(100),
@registrationdeadline datetime


        return;

    } else {
        echo '
    <form method="post" action="index.php?posted">
        <table>
            <tr>
                <td>Naam Toernooi</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="name" value="'.$_POST['name'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>Organiserende Schaakclub</td>
            </tr>
            <tr>
                <td>
                <select name="chessclub">
                ';
        foreach (getChessClubs() as $value) {
            echo "<option>${$value}</option>";
        }
        echo '
                </select>
                </td>
            </tr>
            <tr>
                <td>Start datum</td>
            </tr>
            <tr>
                <td>
                    <input type="date" name="start" value="'.$_POST['start'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>Eind datum</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="end" value="'.$_POST['end'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>Inschrijfgeld</td>
            </tr>
            <tr>
                <td>
                    <input type="number" min="0.00" step="any" name="entryfee" value="'.$_POST['entryfee'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>Adres</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="adres" value="'.$_POST['adres'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>Postcode</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="postcode" value="'.$_POST['postcode'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>Stad</td>
            </tr>
            <tr>
                <td>
                    <input type="text" name="city" value="'.$_POST['city'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>Registratie Tijdsgrens</td>
            </tr>
            <tr>
                <td>
                    <input type="date" name="deadline" value="'.$_POST['deadline'] ?? "".'">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit">
                </td>
            </tr>
        </table>
    </form>';
    }
    ?>
</main>
</body>
</html>
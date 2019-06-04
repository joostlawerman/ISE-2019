<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Nieuwe Ronde maken</title>
</head>
<body>
<?php
include "menu.php"
?>

<main>
    <table>
        <tr>
            <td>
                Ronde Type Selecteren <select>
                <option>-- Kies rondetype --</option>
                <option value="roundRobin">Round Robin</option>
                <option value="bracket">Bracket</option>
            </select>
            </td>
        </tr>
        <tr>
            <td>Poule grootte</td>
        </tr>
        <tr>
            <td><input type="number"></td>
        </tr>
        <tr>
            <td>Ronde gebaseerd op:</td>
        </tr>
        <tr>
            <td><label><input type="radio"> Op vereniging</label><br/> <label><input type="radio"> Op punten van <select>
                <option>-- Kies een ronde --</option>
                <option value="ronde1">Ronde 1</option>
                <option value="ronde2">Ronde 2</option>
            </select> </label>
            </td>
        </tr>
        <tr>
            <td>Maak ronde</td>
        </tr>
    </table>
</main>
</body>
</html>
<?php

include_once 'misc/includes.php';

if (!empty($_POST['asideToernooi']) && $_POST['asideToernooi'] !== 'Kies een schaaktoernooi') {
    $tournament = new Tournament($config['chessclub']['name'], $_POST['asideToernooi']);
}
else {
    $tournament = new Tournament();
}
$info = $tournament->getInfo();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Toernooi info | <?php echo $info['tournamentname'];?></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <?php include "misc/menu.php"; ?>
        <div class="col-9 main-page">
            <div class="card">
                <div class="card-header bg-dark">
                    Toernooi info
                </div>
                <div class="card-body card-body-scroll">
                    <?php
                    echo '
                    <form>
                        <div class="form-group">
                            <label for="tournamentName">Naam Toernooi *</label>
                            <input type="text" class="form-control" id="tournamentName" value="'.$info['tournamentname'].'" readonly>
                        </div>
                        <div class="form-group">
                            <label for="contact"> Contactpersoon toernooi *</label>
                            <select id="contact" name="contact" class="custom-select" readonly>
                                <option>'.$info['contactname'].'</option>';

                                foreach (Contactperson::getContactPersons() as $value) {
                                    echo "<option>${value}</option>";
                                }
                                echo '
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="startTime">Starttijd *</label>
                            <input type="datetime-local" class="form-control" id="startTime" value="'.(new DateTime($info['starts']))->format("Y-m-d\Th:i").'" readonly>
                        </div>
                        <div class="form-group">
                            <label for="endTime">Eindtijd</label>
                            <input type="datetime-local" class="form-control" id="endTime" value="'.(new DateTime($info['ends']))->format("Y-m-d\Th:i").'" readonly>
                        </div>
                        <div class="form-group">
                            <label for="registrationFee">Inschrijfgeld *</label>
                            <input type="number" class="form-control" id="registrationFee" value="'.$info['registrationfee'].'" step=".01" readonly>
                        </div>
                        <div class="form-group">
                            <label for="address">Adres *</label>
                            <input type="text" class="form-control" id="address" value="'.$info['addressline1'].'" readonly>
                        </div>
                        <div class="form-group">
                            <label for="postalcode">Postcode *</label>
                            <input type="text" class="form-control" id="postalcode" value="'.$info['postalcode'].'" readonly>
                        </div>
                        <div class="form-group">
                            <label for="city">Stad *</label>
                            <input type="text" class="form-control" id="city" value="'.$info['city'].'" readonly>
                        </div>
                        <div class="form-group">
                            <label for="registrationDeadline">Registratie Tijdsgrens *</label>
                            <input type="datetime-local" class="form-control" id="registrationDeadline" value="'.(new DateTime($info['registrationdeadline']))->format("Y-m-d\Th:i").'" readonly>
                        </div>

                        <a class="btn btn-dark" href="editToernooiInfo.html" role="button">Verander de info</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>';
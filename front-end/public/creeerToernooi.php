<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Creeer toernooi</title>
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
                    Cre&euml;er toernooi
                </div>
                <?php
                if (isset($_POST['tournamentName'])) {
                    $required = ['tournamentName', 'contact', 'startTime', 'endTime', 'registrationFee', 'address', 'postalcode', 'city', 'registrationDeadline'];
                    $invalid = false;
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

                if (isset($invalid) && !$invalid) {
                    $dates = ['startTime', 'endTime', 'registrationDeadline'];
                    $parameters = [];
                    foreach ($_POST as $key => $value) {
                        if (in_array($key, $dates)) {
                            $value = (new DateTime($value))->format('Y-m-d H:i:s');
                        }
                        $parameters[":".$key] = $value;
                    }

                    $statement = $pdo->prepare("EXEC SP_CREATE_TOURNAMENT Horst, :tournamentName, :contact, :startTime, :endTime, :registrationFee, :address, :postalcode, :city, :registrationDeadline");
                    try {
                        $statement->execute($parameters);
                        if ($statement->errorCode() !== '00000') {
                            throw new PDOException($statement->errorInfo()[2], $statement->errorCode());
                        }
                        ?>
                            <span>Gelukt</span>
                        <?php

                        return;

                    }
                    catch (PDOException $e) {
                        ?>
                        <span class="error">
                                Een error
                            </span>
                        <?php
                    }
                }
                    ?>

                    <div class="card-body card-body-scroll">
                        <form method="post" action="creeerToernooi.php">
                            <div class="form-group">
                                <label for="tournamentName"> Organiserende Schaakvereniging *</label>
                                <select name="chessclub" id="chessclub" class="custom-select" required>
                                    <?php
                                    foreach (Chessclub::getChessclubs() as $value) {
                                        echo "<option>${value}</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="tournamentName"> Naam Toernooi *</label>
                                <input type="text" class="form-control" id="tournamentName" name="tournamentName" placeholder="Vul de toernooinaam in" required>
                            </div>
                            <div class="form-group">
                                <label for="contact"> Contactpersoon toernooi *</label>
                                <select id="contact" name="contact" class="custom-select" required>
                                    <?php
                                    foreach (Contactperson::getContactPersons() as $value) {
                                        echo "<option>${value}</option>";
                                    }
                                    ?>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="startTime"> Startdatum *</label>
                                <input type="datetime-local" class="form-control" id="startTime" name="startTime" placeholder="Vul de starttijd in" required>
                            </div>
                            <div class="form-group">
                                <label for="endTime"> Einddatum</label>
                                <input type="datetime-local" class="form-control" id="endTime" name="endTime" placeholder="Vul de eindtijd in">
                            </div>
                            <div class="form-group">
                                <label for="registrationFee"> Inschrijfgeld *</label>
                                <input type="number" class="form-control" id="registrationFee" name="registrationFee" placeholder="Vul het bedrag in" step=".01" required>
                            </div>
                            <div class="form-group">
                                <label for="address"> Adres *</label>
                                <input type="text" class="form-control" id="address" name="address" placeholder="Vul het adress in van de locatie van het toernooi" required>
                            </div>
                            <div class="form-group">
                                <label for="postalcode"> Postcode *</label>
                                <input type="text" class="form-control" id="postalcode" name="postalcode" pattern="[0-9]{4}[A-Z]{2}" placeholder="Vul de postcode in van de locatie van het toernooi" required>
                            </div>
                            <div class="form-group">
                                <label for="city"> Stad *</label>
                                <input type="text" class="form-control" id="city" name="city" placeholder="Vul de stad in van de locatie van het toernooi" required>
                            </div>
                            <div class="form-group">
                                <label for="registrationDeadline"> Registratie Tijdsgrens *</label>
                                <input type="datetime-local" class="form-control" id="registrationDeadline" name="registrationDeadline" placeholder="Vul de uiterlijke tijd van inschrijving in." required>
                            </div>

                            <button type="submit" class="btn btn-dark"> Maak toernooi aan</button>
                        </form>

                    </div>
            </div>

        </div>
    </div>

</div>

</body>

</html>
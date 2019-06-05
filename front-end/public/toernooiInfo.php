

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Toernooi info</title>
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
                    <form>
                        <div class="form-group">
                            <label for="tournamentName">Naam Toernooi *</label>
                            <input type="text" class="form-control" id="tournamentName" value="1ste schaaktoernooi" readonly>
                        </div>
                        <div class="form-group">
                            <label for="startTime">Starttijd *</label>
                            <input type="datetime-local" class="form-control" id="startTime" value="2019-05-28T10:30" readonly>
                        </div>
                        <div class="form-group">
                            <label for="endTime">Eindtijd</label>
                            <input type="datetime-local" class="form-control" id="endTime" value="2019-05-28T18:30" readonly>
                        </div>
                        <div class="form-group">
                            <label for="registrationFee">Inschrijfgeld *</label>
                            <input type="number" class="form-control" id="registrationFee" value="2.10" step=".01" readonly>
                        </div>
                        <div class="form-group">
                            <label for="address">Adres *</label>
                            <input type="text" class="form-control" id="address" value="Hoofdstraat 5" readonly>
                        </div>
                        <div class="form-group">
                            <label for="postalcode">Postcode *</label>
                            <input type="text" class="form-control" id="postalcode" value="9200AV" readonly>
                        </div>
                        <div class="form-group">
                            <label for="city">Stad *</label>
                            <input type="text" class="form-control" id="city" value="Arnhem" readonly>
                        </div>
                        <div class="form-group">
                            <label for="registrationDeadline">Registratie Tijdsgrens *</label>
                            <input type="datetime-local" class="form-control" id="registrationDeadline" value="2019-05-28T10:00" readonly>
                        </div>

                        <a class="btn btn-dark" href="editToernooiInfo.html" role="button">Verander de info</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
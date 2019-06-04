<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Nieuwe ronde toevoegen</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="container-fluid">
    <div class="row">
        <?php
        include "menu.php"
        ?>
        <div class="col-9 main-page">
            <div class="card">
                <div class="card-header bg-dark">
                    Manage rondes
                </div>
                <div class="card-body card-body-scroll">
                    <form>
                        <div class="form-group">
                            <label for="roundType">Ronde Type Selecteren *</label>
                            <select class="custom-select mr-sm-2" id="roundType" name="roundType">
                                <option>-- Kies rondetype --</option>
                                <option value="roundRobin">Round Robin</option>
                                <option value="bracket">Bracket</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="pouleSize">Poule grootte *</label>
                            <input class="form-control" id="pouleSize" name="pouleSize" value="4" type="number">
                        </div>

                        <fieldset class="form-group">
                            <div class="row">
                                <legend class="col-form-label col-sm-2 pt-0">Gebaseerd op *</legend>
                                <div class="col-sm-10">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="basedOn" id="basedOn1" value="club" checked>
                                        <label class="form-check-label" for="basedOn1"> Op vereniging </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="basedOn" id="basedOn2" value="round">
                                        <label class="form-check-label" for="basedOn2"> Op punten van
                                            <select name="basedOnRound">
                                                <option>-- Kies een ronde --</option>
                                                <option value="ronde1">Ronde 1</option>
                                                <option value="ronde2">Ronde 2</option>
                                            </select>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <button type="submit" class="btn btn-dark">Maak ronde aan</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

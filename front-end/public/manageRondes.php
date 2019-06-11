<?php

include_once 'misc/includes.php';

if (!empty($_POST['asideToernooi']) && $_POST['asideToernooi'] !== 'Kies een schaaktoernooi') {
    $tournament = new Tournament($config['chessclub']['name'], $_POST['asideToernooi']);
}
else {
    $tournament = new Tournament();
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Manage Rondes | <?php echo $tournament->getInfo()['tournamentname'];?></title>
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
                    Manage rondes
                </div>
                <div class="card-body card-body-scroll">
                    <form method="post">
                        <?php echo '<input type="hidden" name="toernooi" value="'.$tournament->getInfo()['tournamentname'].'">'; ?>
                    <div class="row poule-menu">
                        <select class="select mr-sm-2" name="ronde" id="ronde" required>
                            <?php
                            foreach ($tournament->getRounds() as $round) {
                                echo '<option value="'.$round->getInfo()['roundnumber'].'" >Ronde '.$round->getInfo()['roundnumber'].'</option>';
                            }
                            ?>
                        </select>
                        <button type="submit" class="btn btn-dark poules" formaction="manageRondes.php" disabled>Show</button>

                        <button type="submit" class="btn btn-dark poules" formaction="editRonde.php" disabled>Edit</button>
                        <a class="btn btn-dark poules" href="nieuweRonde.php" role="button" disabled>Maak een nieuwe ronde</a>
                        <button type="submit" class="btn btn-dark poules" formaction="insertResults.php">Vul resultaten ronde in</button>
                        <button type="submit" class="btn btn-dark poules" formaction="">Print poules</button>
                        <button type="submit" class="btn btn-dark poules" formaction="">Print resultaten</button>
                    </div>
                    </form>

                    <div class="row poules">
                        <div class="col-3">
                            <table class="table table-striped">

                                <thead>
                                <tr>
                                    <th>
                                        Poule 1
                                    </th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        1
                                    </td>
                                    <td>
                                        Speler 1
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        2
                                    </td>
                                    <td>
                                        Speler 2
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        3
                                    </td>
                                    <td>
                                        Speler 3
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        4
                                    </td>
                                    <td>
                                        Speler 4
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-3">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>
                                        Poule 2
                                    </th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        1
                                    </td>
                                    <td>
                                        Speler 5
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        2
                                    </td>
                                    <td>
                                        Speler 6
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        3
                                    </td>
                                    <td>
                                        Speler 7
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        4
                                    </td>
                                    <td>
                                        Speler 8
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-3">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>
                                        Poule 3
                                    </th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        1
                                    </td>
                                    <td>
                                        Speler 9
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        2
                                    </td>
                                    <td>
                                        Speler 10
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        3
                                    </td>
                                    <td>
                                        Speler 11
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        4
                                    </td>
                                    <td>
                                        Speler 12
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-3">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>
                                        Poule 4
                                    </th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        1
                                    </td>
                                    <td>
                                        Speler 13
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        2
                                    </td>
                                    <td>
                                        Speler 14
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        3
                                    </td>
                                    <td>
                                        Speler 15
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        4
                                    </td>
                                    <td>
                                        Speler 16
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>
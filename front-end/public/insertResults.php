<?php

include_once 'misc/includes.php';

var_dump($_POST);

if ((!empty($_POST['toernooi']) && $_POST['toernooi'] !== '') && (!empty($_POST['ronde']) && $_POST['ronde'] !== '')) {
    $tournament      = new Tournament($config['chessclub']['name'], $_POST['toernooi']);
    $tournamentRound = new Round($config['chessclub']['name'], $_POST['toernooi'], $_POST['ronde']);
} else {
    // header("Location: index.php");
}



?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Resultaten Invoeren</title>
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
                    Voeg resultaten toe
                </div>
                <div class="card-body card-body-scroll">
                    <form method="post" action="insertResults.php">
                        <input type="hidden" name="toernooi" value="<?php echo $_POST['toernooi']; ?>">
                        <div class="row poule-menu">
                            <select class="select mr-sm-2" name="ronde" id="ronde" required>
                                <?php
                                foreach ($tournament->getRounds() as $round) {
                                    echo '<option value="'.$round->getInfo()['roundnumber'].'" >Ronde '.$round->getInfo()['roundnumber'].'</option>';
                                }
                                ?>
                            </select>
                            <button type="submit" class="btn btn-dark poules">Opslaan</button>
                        </div>

                        <?php
                        foreach ($tournamentRound->getPoules() as $poule) {
                            if ($poule->getInfo()['pouleno'] % 2 == 1) {
                                ?>
                                <div class="row poules">
                                <?php
                            }
                            ?>
                                    <div class="col-6">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Poule <?php echo $poule->getInfo()['pouleno'].'</th>';
                                                $poulePlayers = $poule->getPlayers();
                                                $pouleSize    = count($poulePlayers);
                                                foreach ($poulePlayers as $player) {
                                                    echo '<th>'.$player->getName().'</th>';
                                                }
                                                    echo '<th>Total</th>
                                                </tr>
                                            </thead>';
                                        foreach ($poulePlayers as $key => $player) {
                                            echo '
                                            <tr>
                                                <td>'.$player->getName().'</td>';
                                            for ($i = 0; $i < $pouleSize; $i++) {
                                                if ($i == $key) {
                                                    echo '
                                                <td> X </td>';
                                                    continue;
                                                }
                                                echo '
                                                <td>
                                                    <select name="'.$poule->getMatchesBetweenPlayers($player->getInfo()['playerid'], $poulePlayers[$i]->getInfo()['playerid']).'">
                                                        <option>--</option>
                                                        <option value="0">0</option>
                                                        <option value="0.5">&frac12;</option>
                                                        <option value="1">1</option>
                                                    </select>
                                                </td>';
                                            }
                                        }
                                        echo '
                                            </tr>
                                        </table>
                                    </div>';
                            if ($poule->getInfo()['pouleno'] % 2 == 0) {
                                ?>
                                </div>
                                <?php
                            }
                        }
                            ?>
                    </form>
                </div>
            </div> <!--end card-->
        </div>
    </div>
</div>
</body>

</html>
<?php
    include_once "misc/includes.php";
?>

<div class="col-3 menu">
        <ul class="list-group list-dark">
            <li class="list-group-item list-group-item-dark">
                <a class="homepagelink" href="index.php">Schaaktoernooi applicatie</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu" href="creeerToernooi.php" role="button">Cre&euml;er toernooi</a>
            </li>
            <form action="toernooiInfo.php" method="post">
            <li class="list-group-item list-group-item-light">
                <select name="asideToernooi" class="custom-select" id="asideToernooi">
                    <option selected>Kies een schaaktoernooi</option>
                <?php
                    foreach (Tournament::getTournaments($config['chessclub']['name']) as $value) {
                        echo "<option>".$value."</option>";
                    }
                ?>
                </select>
            </li>
            <li class="list-group-item list-group-item-light">
                <button type="submit" class="btn btn-dark btn-menu" role="button">Toernooi Info</button>
            </li>
            </form>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu active" href="toernooiSpelerToevoegen.php" role="button" aria-pressed="true">Voeg toernooispelers toe</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu" href="manageRondes.php" role="button">Manage rondes</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu" href="schaakclubToevoegen.php" role="button">Voeg schaakclub toe</a>
            </li>
        </ul>
    </div>
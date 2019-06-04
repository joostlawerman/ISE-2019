<?php
echo '<div class="col-3 menu">
        <ul class="list-group list-dark">
            <li class="list-group-item list-group-item-dark">
                <a class="homepagelink" href="index.html">Schaaktoernooi applicatie</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu" href="creeerToernooi.html" role="button">Cre&euml;er toernooi</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <select name="asideToernooi" class="custom-select" id="asideToernooi">
                    <option selected>Kies een schaaktoernooi</option>
                    <option value="1">1ste schaaktoernooi</option>
                    <option value="2">2de schaaktoernooi</option>
                </select>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu" href="toernooiInfo.html" role="button">Toernooi Info</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu active" href="toernooiSpelerToevoegen.html" role="button" aria-pressed="true">Voeg toernooispelers toe</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu" href="manageRondes.html" role="button">Manage rondes</a>
            </li>
            <li class="list-group-item list-group-item-light">
                <a class="btn btn-dark btn-menu" href="schaakclubToevoegen.html" role="button">Voeg schaakclub toe</a>
            </li>
        </ul>
    </div>';
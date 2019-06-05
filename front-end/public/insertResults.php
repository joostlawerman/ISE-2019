<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Resultaten Invoeren</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
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
                        <div class="row poule-menu">
                            <select class="select mr-sm-2" id="ronde" required>
                                <option value="1" selected>Ronde 1</option>
                                <option value="2">Ronde 2</option>
                                <option value="3">Ronde 3</option>
                            </select>
                        </div>

                        <div class="row poules">
                            <div class="col-6">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>
                                                Poule 1
                                            </th>
                                            <th>
                                                1
                                            </th>
                                            <th>
                                                2
                                            </th>
                                            <th>
                                                3
                                            </th>
                                            <th>
                                                4
                                            </th>
                                            <th>
                                                Totaal
                                            </th>
                                        </tr>
                                    </thead>
                                    <tr>
                                        <td>
                                            Speler 1
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            <select name="match1">
                                                <option value="0">
                                                    0
                                                </option>
                                                <option value="0.5">
                                                    &frac12;
                                                </option>
                                                <option value="1">
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            0
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 2
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            0
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 3
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            0
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 4
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            <select>
                                                <option>
                                                    0
                                                </option>
                                                <option>
                                                    &frac12;
                                                </option>
                                                <option>
                                                    1
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            0
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-6">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>
                                                Poule 2
                                            </th>
                                            <th>
                                                5
                                            </th>
                                            <th>
                                                6
                                            </th>
                                            <th>
                                                7
                                            </th>
                                            <th>
                                                8
                                            </th>
                                        </tr>
                                    </thead>
                                    <tr>
                                        <td>
                                            Speler 5
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 6
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 7
                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 8
                                        </td>
                                        <td>
                                            
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                            x
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="row poules">
                            <div class="col-6">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>
                                                Poule 3
                                            </th>
                                            <th>
                                                9
                                            </th>
                                            <th>
                                                10
                                            </th>
                                            <th>
                                                11
                                            </th>
                                            <th>
                                                12
                                            </th>
                                        </tr>
                                    </thead>
                                    <tr>
                                        <td>
                                            Speler 9
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 10
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 11
                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 12
                                        </td>
                                        <td>
                                            
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                            x
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-6">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>
                                                Poule 4
                                            </th>
                                            <th>
                                                13
                                            </th>
                                            <th>
                                                14
                                            </th>
                                            <th>
                                                15
                                            </th>
                                            <th>
                                                16
                                            </th>
                                        </tr>
                                    </thead>
                                    <tr>
                                        <td>
                                            Speler 13
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 14
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 15
                                        </td>
                                        <td>

                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Speler 16
                                        </td>
                                        <td>
                                            
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                        
                                        </td>
                                        <td>
                                            x
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
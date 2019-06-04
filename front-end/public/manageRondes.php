<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Nieuwe speler toevoegen</title>
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
                    <div class="row poule-menu">
                        <select class="select mr-sm-2" id="ronde" required>
                            <option value="1" selected>Ronde 1</option>
                            <option value="2">Ronde 2</option>
                            <option value="3">Ronde 3</option>
                        </select>

                        <a class="btn btn-dark poules" href="editRonde.html" role="button">Edit</a>
                        <a class="btn btn-dark poules" href="nieuweRonde.html" role="button">Maak een nieuwe ronde</a>
                        <a class="btn btn-dark poules" href="insertResults.html" role="button">Vul resultaten ronde in</a>
                        <a class="btn btn-dark poules" href="" role="button">Print poules</a>
                        <a class="btn btn-dark poules" href="" role="button">Print resultaten</a>
                    </div>

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
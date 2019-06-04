<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Nieuwe speler toevoegen</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">

    <script>
        $(document).ready(function () {
            $('#example').DataTable({
                columnDefs: [{
                    orderable: false,
                    className: 'select-checkbox',
                    targets: 0
                }],
                select: {
                    style: 'os',
                    selector: 'td:first-child'
                },
                order: [[1, 'asc']]
            });
        });
    </script>
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

                            <a class="btn btn-dark pull-left poules" href="manageRondes.html" role="button">Accepteer</a>
                        </div>

                        <from>
                            <div class="row poules">
                                <div class="col-3">
                                    <table class="table table-striped" id="example">
                                        <thead>
                                            <tr>
                                                <th>
                                                    Poule 1
                                                </th>
                                                <th>

                                                </th>
                                                <th>
                                                    
                                                </th>
                                            </tr>
                                        </thead>
                                        <tr>
                                            <td>
                                                1
                                            </td>
                                            <td>
                                                Speler 1
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="1" name="switch" value="player1">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                2
                                            </td>
                                            <td>
                                                Speler 2
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="1" name="switch" value="player2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                3
                                            </td>
                                            <td>
                                                Speler 3
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="1" name="switch" value="player3">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                4
                                            </td>
                                            <td>
                                                Speler 4
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="1" name="switch" value="player4">
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
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tr>
                                            <td>
                                                5
                                            </td>
                                            <td>
                                                Speler 5
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="2" name="switch" value="player1">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                6
                                            </td>
                                            <td>
                                                Speler 6
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="2" name="switch" value="player2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                7
                                            </td>
                                            <td>
                                                Speler 7
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="2" name="switch" value="player3">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                8
                                            </td>
                                            <td>
                                                Speler 8
                                            </td>
                                            <td>
                                                <input type="checkbox" class="switch-checkbox" data-poule="2" name="switch" value="player4">
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
                        

                            <button type="submit" class="btn btn-dark">Wissel</button>
                        </from>
                    </div>
                </div>

            </div>
        </div>

    </div>

</body>

</html>
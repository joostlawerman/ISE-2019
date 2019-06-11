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
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <?php include "misc/menu.php"; ?>

            <div class="col-9 main-page">

                <div class="card">
                    <div class="card-header bg-dark">
                        Voeg een nieuwe schaakclub toe
                    </div>
                    <div class="card-body card-body-scroll">
                        <form>
                            <div class="form-group">
                                <label for="firstName">Naam schaakclub *</label>
                                <input type="text" class="form-control" id="firstName"
                                    placeholder="Vul de naam van de schaakclub in" required>
                            </div>
                            <div class="form-group">
                                    <label for="city">Stad *</label>
                                    <input type="text" class="form-control" id="city"
                                        placeholder="Vul de stad in van de locatie van de schaakclub" required>
                                </div>
                            <div class="form-group">
                                <label for="address">Adres *</label>
                                <input type="text" class="form-control" id="address"
                                    placeholder="Vul het adress in van de locatie van de schaakclub" required>
                            </div>
                            <div class="form-group">
                                <label for="postalcode">Postcode *</label>
                                <input type="text" class="form-control" id="postalcode"
                                    placeholder="Vul de postcode in van de locatie van de schaakclub" required>
                            </div>

                            <div class="form-group">
                                    <label for="emailAddress">Emailadres *</label>
                                    <input type="email" class="form-control" id="emailAddress"
                                        placeholder="Vul het emailadres van de schaakclub in" required>
                            </div>

                            <button type="submit" class="btn btn-dark">Maak schaakclub aan</button>
                        </form>

                    </div>
                </div>

            </div>
        </div>

    </div>

</body>

</html>
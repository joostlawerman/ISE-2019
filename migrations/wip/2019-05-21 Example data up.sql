
-- +migrate Up
INSERT INTO CHESSCLUB(chessclubname, city, addressline1, postalcode, emailaddress) VALUES
    ('Tilburg', 'Tilburg', 'Tilburgerstraat 10', '8445BU', 'tilburg@example.til'),
    ('Sneeker schakers', 'Sneek', 'Leeuwarderdyk 150', '8767BU', 'snitserskakers@example.frl');

-- +migrate Up
INSERT INTO PLAYER(playerid, chessclubname, firstname, lastname, addressline1, postalcode, city, birthdate, emailaddress, gender) VALUES
    (1, 'Tilburg', 'Joost', 'Lawerman', 'testerstraat 10', '1010TE', 'Arnhem', '1987-05-05', 'joosttester@tester.test', 'm'),
    (2, 'Sneeker schakers', 'Jelmer', 'Wijnja', 'example lane 14', '5049TE', 'Lettele', '1999-10-01', 'jelmertester@tester.test', 'm'),
    (3, 'Tilburg', 'Ivor', 'Staats', 'testinglane 18594', '8654TE', 'Apeldoorn', '2001-09-09', 'ivortester@tester.test', 'm'),
    (4, 'Sneeker schakers', 'Jasmijn', 'Bartels', 'voorbeeldstraat 100', '7444TE', 'Colmschate', '1970-01-01', 'jasmijntester@tester.test', 'v'),
    (5, 'Tilburg', 'Luca', 'Hogeweide', 'ergens op de wereld straat 1290', '9999TE', 'Doetinchem', '1990-02-02', 'luca@tester.test', 'm');

-- +migrate Up
INSERT INTO ROLE (playerid, chessclubname, role) VALUES
    (1, 'Tilburg', 'voorzitter'),
    (2, 'Sneeker schakers', 'voorzitter'),
    (3, 'Tilburg', 'secretaris');

-- +migrate Up
INSERT INTO CONTACTPERSON(contactname, emailaddress, phonenumber) VALUES
    ('Dirk van de Broek', 'dirkiedirk@dirk.dir', 0987654321)

-- +migrate Up
INSERT INTO TOURNAMENT(chessclubname, tournamentname, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline) VALUES
    ('Tilburg', 'Tilburger Toernooi', 'Dirk van de Broek', dateadd(DAY, 10, getdate()), dateadd(DAY, 11, getdate()), 10, 'Tilburgerstraat 10', '8445BU', 'Tilburg', dateadd(DAY, 9, getdate()));

-- +migrate Up
INSERT INTO TOURNAMENT_PLAYER(chessclubname, tournamentname, playerid, paid) VALUES
    ('Tilburg', 'Tilburger Toernooi', 1, 0),
    ('Tilburg', 'Tilburger Toernooi', 2, 1),
    ('Tilburg', 'Tilburger Toernooi', 3, 0),
    ('Tilburg', 'Tilburger Toernooi', 4, 1),
    ('Tilburg', 'Tilburger Toernooi', 5, 0);


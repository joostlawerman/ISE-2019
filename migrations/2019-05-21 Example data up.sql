-- +migrate Up
INSERT INTO CHESSCLUB (chessclubname, city, addressline1, postalcode, emailaddress) VALUES
    ('Tilburg', 'Tilburg', 'Tilburgerstraat 10', '8445BU', 'tilburg@example.til'),
    ('Sneeker schakers', 'Sneek', 'Leeuwarderdyk 150', '8767BU', 'snitserskakers@example.frl');

-- +migrate Up
INSERT INTO PLAYER (playerid, chessclubname, firstname, lastname, addressline1, postalcode, city, birthdate, emailaddress, gender)
VALUES
    (1, 'Tilburg', 'Joost', 'Lawerman', 'testerstraat 10', '1010TE', 'Arnhem', '1987-05-05', 'joosttester@tester.test',
     'm'),
    (2, 'Sneeker schakers', 'Jelmer', 'Wijnja', 'example lane 14', '5049TE', 'Lettele', '1999-10-01',
     'jelmertester@tester.test', 'm'),
    (3, 'Tilburg', 'Ivor', 'Staats', 'testinglane 18594', '8654TE', 'Apeldoorn', '2001-09-09', 'ivortester@tester.test',
     'm'),
    (4, 'Sneeker schakers', 'Jasmijn', 'Bartels', 'voorbeeldstraat 100', '7444TE', 'Colmschate', '1970-01-01',
     'jasmijntester@tester.test', 'v'),
    (5, 'Tilburg', 'Luca', 'Hogeweide', 'ergens op de wereld straat 1290', '9999TE', 'Doetinchem', '1990-02-02',
     'luca@tester.test', 'm');

-- +migrate Up
INSERT INTO ROLE (playerid, chessclubname, role) VALUES
    (1, 'Tilburg', 'voorzitter'),
    (2, 'Sneeker schakers', 'voorzitter'),
    (3, 'Tilburg', 'secretaris');

-- +migrate Up
INSERT INTO CONTACTPERSON (contactname, emailaddress, phonenumber) VALUES
    ('Dirk van de Broek', 'dirkiedirk@dirk.dir', '0987654321');

-- +migrate Up
INSERT INTO TOURNAMENT (chessclubname, tournamentname, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline)
VALUES
    ('Tilburg', 'Tilburger Toernooi', 'Dirk van de Broek', dateadd(DAY, 10, getdate()), dateadd(DAY, 11, getdate()), 10,
     'Tilburgerstraat 10', '8445BU', 'Tilburg', dateadd(DAY, 9, getdate()));

-- +migrate Up
INSERT INTO TOURNAMENT_PLAYER (chessclubname, tournamentname, playerid, paid) VALUES
    ('Tilburg', 'Tilburger Toernooi', 1, 0),
    ('Tilburg', 'Tilburger Toernooi', 2, 1),
    ('Tilburg', 'Tilburger Toernooi', 3, 0),
    ('Tilburg', 'Tilburger Toernooi', 4, 1),
    ('Tilburg', 'Tilburger Toernooi', 5, 0);

-- +migrate Up
INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber, system, starts, ends) VALUES
    ('Tilburg', 'Tilburger Toernooi', 1, 'round robin', dateadd(DAY, 10, getdate()),
     dateadd(MINUTE, 1, dateadd(DAY, 10, getdate()))),
    ('Tilburg', 'Tilburger Toernooi', 2, 'round robin', dateadd(MINUTE, 1, dateadd(DAY, 10, getdate())), dateadd(
        MINUTE, 2, dateadd(DAY, 10, getdate()))),
    ('Tilburg', 'Tilburger Toernooi', 3, 'round robin', dateadd(MINUTE, 2, dateadd(DAY, 10, getdate())), dateadd(
        MINUTE, 3, dateadd(DAY, 10, getdate()))),
    ('Tilburg', 'Tilburger Toernooi', 4, 'round robin', dateadd(MINUTE, 3, dateadd(DAY, 10, getdate())), dateadd(
        MINUTE, 4, dateadd(DAY, 10, getdate())));

-- +migrate Up
INSERT INTO POULE (chessclubname, tournamentname, roundnumber, pouleno) VALUES
    ('Tilburg', 'Tilburger Toernooi', 1, 1),
    ('Tilburg', 'Tilburger Toernooi', 1, 2),
    ('Tilburg', 'Tilburger Toernooi', 1, 3),
    ('Tilburg', 'Tilburger Toernooi', 1, 4),
    ('Tilburg', 'Tilburger Toernooi', 1, 5),
    ('Tilburg', 'Tilburger Toernooi', 2, 1),
    ('Tilburg', 'Tilburger Toernooi', 2, 2),
    ('Tilburg', 'Tilburger Toernooi', 2, 3),
    ('Tilburg', 'Tilburger Toernooi', 2, 4),
    ('Tilburg', 'Tilburger Toernooi', 2, 5),
    ('Tilburg', 'Tilburger Toernooi', 2, 6),
    ('Tilburg', 'Tilburger Toernooi', 3, 1),
    ('Tilburg', 'Tilburger Toernooi', 3, 2),
    ('Tilburg', 'Tilburger Toernooi', 3, 3),
    ('Tilburg', 'Tilburger Toernooi', 3, 4),
    ('Tilburg', 'Tilburger Toernooi', 3, 5),
    ('Tilburg', 'Tilburger Toernooi', 4, 1),
    ('Tilburg', 'Tilburger Toernooi', 4, 2),
    ('Tilburg', 'Tilburger Toernooi', 4, 3),
    ('Tilburg', 'Tilburger Toernooi', 4, 4),
    ('Tilburg', 'Tilburger Toernooi', 4, 5),
    ('Tilburg', 'Tilburger Toernooi', 4, 6),
    ('Tilburg', 'Tilburger Toernooi', 4, 7),
    ('Tilburg', 'Tilburger Toernooi', 4, 8);

-- +migrate Up
INSERT INTO ROUND_ROBIN_POULE (chessclubname, tournamentname, roundnumber, pouleno) VALUES
    ('Tilburg', 'Tilburger Toernooi', 1, 1),
    ('Tilburg', 'Tilburger Toernooi', 1, 2),
    ('Tilburg', 'Tilburger Toernooi', 1, 3),
    ('Tilburg', 'Tilburger Toernooi', 1, 4),
    ('Tilburg', 'Tilburger Toernooi', 1, 5),
    ('Tilburg', 'Tilburger Toernooi', 2, 1),
    ('Tilburg', 'Tilburger Toernooi', 2, 2),
    ('Tilburg', 'Tilburger Toernooi', 2, 3),
    ('Tilburg', 'Tilburger Toernooi', 2, 4),
    ('Tilburg', 'Tilburger Toernooi', 2, 5),
    ('Tilburg', 'Tilburger Toernooi', 2, 6),
    ('Tilburg', 'Tilburger Toernooi', 3, 1),
    ('Tilburg', 'Tilburger Toernooi', 3, 2),
    ('Tilburg', 'Tilburger Toernooi', 3, 3),
    ('Tilburg', 'Tilburger Toernooi', 3, 4),
    ('Tilburg', 'Tilburger Toernooi', 3, 5),
    ('Tilburg', 'Tilburger Toernooi', 4, 1),
    ('Tilburg', 'Tilburger Toernooi', 4, 2),
    ('Tilburg', 'Tilburger Toernooi', 4, 3),
    ('Tilburg', 'Tilburger Toernooi', 4, 4),
    ('Tilburg', 'Tilburger Toernooi', 4, 5),
    ('Tilburg', 'Tilburger Toernooi', 4, 6),
    ('Tilburg', 'Tilburger Toernooi', 4, 7),
    ('Tilburg', 'Tilburger Toernooi', 4, 8);

-- +migrate Up
INSERT INTO TOURNAMENT_PLAYER_OF_POULE (chessclubname, tournamentname, roundnumber, pouleno, playerid) VALUES
    ('Tilburg', 'Tilburger Toernooi', 1, 1, 1),
    ('Tilburg', 'Tilburger Toernooi', 1, 1, 2),
    ('Tilburg', 'Tilburger Toernooi', 1, 1, 3),
    ('Tilburg', 'Tilburger Toernooi', 1, 1, 4),
    ('Tilburg', 'Tilburger Toernooi', 1, 2, 5),
    ('Tilburg', 'Tilburger Toernooi', 2, 2, 1),
    ('Tilburg', 'Tilburger Toernooi', 2, 2, 2),
    ('Tilburg', 'Tilburger Toernooi', 2, 1, 3),
    ('Tilburg', 'Tilburger Toernooi', 2, 2, 4),
    ('Tilburg', 'Tilburger Toernooi', 2, 2, 5),
    ('Tilburg', 'Tilburger Toernooi', 3, 1, 1),
    ('Tilburg', 'Tilburger Toernooi', 3, 5, 2),
    ('Tilburg', 'Tilburger Toernooi', 3, 5, 3),
    ('Tilburg', 'Tilburger Toernooi', 3, 5, 4),
    ('Tilburg', 'Tilburger Toernooi', 3, 5, 5),
    ('Tilburg', 'Tilburger Toernooi', 4, 2, 1),
    ('Tilburg', 'Tilburger Toernooi', 4, 2, 2),
    ('Tilburg', 'Tilburger Toernooi', 4, 3, 3),
    ('Tilburg', 'Tilburger Toernooi', 4, 3, 4),
    ('Tilburg', 'Tilburger Toernooi', 4, 3, 5);

-- +migrate Up
INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
VALUES
    (1, 'Tilburg', 'Tilburger Toernooi', 1, 1, 1, 2),
    (2, 'Tilburg', 'Tilburger Toernooi', 1, 1, 3, 4),
    (3, 'Tilburg', 'Tilburger Toernooi', 1, 1, 1, 3),
    (4, 'Tilburg', 'Tilburger Toernooi', 1, 1, 2, 4),
    (5, 'Tilburg', 'Tilburger Toernooi', 1, 1, 1, 2),
    (6, 'Tilburg', 'Tilburger Toernooi', 2, 2, 1, 2),
    (7, 'Tilburg', 'Tilburger Toernooi', 2, 2, 4, 5),
    (8, 'Tilburg', 'Tilburger Toernooi', 2, 2, 2, 5),
    (9, 'Tilburg', 'Tilburger Toernooi', 2, 2, 1, 4),
    (10, 'Tilburg', 'Tilburger Toernooi', 2, 2, 1, 2),
    (11, 'Tilburg', 'Tilburger Toernooi', 3, 5, 2, 3),
    (12, 'Tilburg', 'Tilburger Toernooi', 3, 5, 4, 5),
    (13, 'Tilburg', 'Tilburger Toernooi', 3, 5, 2, 4),
    (14, 'Tilburg', 'Tilburger Toernooi', 3, 5, 3, 5),
    (15, 'Tilburg', 'Tilburger Toernooi', 3, 5, 2, 5),
    (16, 'Tilburg', 'Tilburger Toernooi', 4, 2, 1, 2),
    (17, 'Tilburg', 'Tilburger Toernooi', 4, 2, 2, 1),
    (18, 'Tilburg', 'Tilburger Toernooi', 4, 3, 3, 4),
    (19, 'Tilburg', 'Tilburger Toernooi', 4, 3, 3, 5),
    (20, 'Tilburg', 'Tilburger Toernooi', 4, 3, 5, 4);

-- +migrate Up
INSERT INTO CHESSMATCHMOVE (matchno, moveno, colour, piece, destination) VALUES
    (1, 1, 'w', 'p', 'f4'),
    (1, 1, 'b', 'p', 'e4'),
    (1, 2, 'w', 'p', 'h4'),
    (1, 2, 'b', 'q', 'qxh4+'),
    (1, 3, 'w', 'p', 'g3'),
    (1, 3, 'b', 'p', 'qxg3#');
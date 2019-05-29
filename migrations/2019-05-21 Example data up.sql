-- +migrate Up
INSERT INTO CHESSCLUB (chessclubname, city, addressline1, postalcode, emailaddress) VALUES
    ('Tilburg', 'Tilburg', 'Tilburgerstraat 10', '8445BU', 'tilburg@example.til'),
    ('Sneeker schakers', 'Sneek', 'Leeuwarderdyk 150', '8767BU', 'snitserskakers@example.frl'),
	('Han scakers', 'Arnhem', 'Ruitenberglaan 26', '1234AB', 'hanschaak@gmail.nl'),
	('Deventer schakers', 'Deventer', 'Colmsgateweg 33', '2143CB', 'deventerschaakmensjes@gmail.nl'),
	('Apeldoornse scakers', 'Apeldoorn', 'hoofdtraat 55', '8472QB', 'apeldoornchaakmensjes@gmail.nl'),
	('Amsterdamse scakers', 'Amsterdamse', 'kalverstraat 88', '6482BC', 'dureschakers@gmail.nl');

-- +migrate Up
INSERT INTO PLAYER (playerid, chessclubname, firstname, lastname, addressline1, postalcode, city, birthdate, emailaddress, gender)
VALUES
    (1, 'Tilburg', 'Joost', 'Lawerman', 'testerstraat 10', '1010TE', 'Arnhem', '1987-05-05', 'joosttester@tester.test',
     'm'),
    (2, 'Sneeker schakers', 'Jelmer', 'Wijnja', 'example lane 14', '5049TE', 'Lettele', '1999-10-01',
     'jelmertester@tester.test', 'm'),
    (3, 'Tilburg', 'Ivor', 'Staats', 'testinglane 18594', '8654TE', 'Apeldoorn', '2001-09-09', 'ivortester@tester.test',
     'm'),
    (4, 'Sneeker schakers', 'Jasmyn', 'Bartelds', 'voorbeeldstraat 100', '7444TE', 'Colmschate', '1970-01-01',
     'jasmijntester@tester.test', 'v'),
    (5, 'Tilburg', 'Luca', 'Hogeweide', 'ergens op de wereld straat 1290', '9999TE', 'Doetinchem', '1990-02-02',
     'luca@tester.test', 'm'),
	(6, 'Han scakers', 'Jan', 'Smith', 'Aalscholverstraat 12', '4323DE', 'Rotterdam', '1999-08-22',
     'jan@tester.test', 'm'),
	(7, 'Deventer schakers', 'Henk', 'Jansen', 'Alexanderlaan 300', '9381QW', 'Amsterdam', '1995-10-12',
     'henk@tester.test', 'm'),
	(8, 'Apeldoornse scakers', 'Sanne', 'Bakker', 'Brediusweg 93', '7319HD', 'Utrecht', '1993-09-02',
     'sanne@tester.test', 'v'),
	(9, 'Han scakers', 'Luuk', 'Visser', 'Driftweg 99', '9372LO', 'Eindhover', '1999-02-27',
     'luuk@tester.test', 'm'),
	(10, 'Deventer schakers', 'Lieke', 'De Jong', 'Energiestraat 84', '4628FD', 'Groningen', '1990-12-05',
     'lieke@tester.test', 'v'),
	(11, 'Apeldoornse scakers', 'Mees', 'Van Dijk', 'Fazantweg 77', '8392PL', 'Arnhem', '1991-06-15',
     'mees@tester.test', 'm'),
	(12, 'Amsterdamse scakers', 'Sem', 'Vos', 'Huizerpoortstraat 48', '1527CV', 'Maastricht', '1994-03-09',
     'sem@tester.test', 'm'),
	(13, 'Amsterdamse scakers', 'Daan', 'De Graaf', 'Jansteenlaan 26', '8920HJ', 'Leiden', '1997-02-01',
     'daan@tester.test', 'm'),
	(14, 'Han scakers', 'Merel', 'De Wit', 'Keverdijk 66', '9271JP', 'Haarlem', '1996-04-19',
     'merel@tester.test', 'v');

-- +migrate Up
INSERT INTO ROLE (playerid, chessclubname, role) VALUES
    (1, 'Tilburg', 'voorzitter'),
    (2, 'Sneeker schakers', 'voorzitter'),
    (3, 'Tilburg', 'secretaris'),
	(6, 'Han scakers', 'voorzitter'),
	(10, 'Deventer schakers', 'voorzitter'),
	(11, 'Apeldoornse scakers', 'voorzitter'),
	(12, 'Amsterdamse scakers', 'voorzitter');

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
    ('Tilburg', 'Tilburger Toernooi', 5, 0),
	('Tilburg', 'Tilburger Toernooi', 6, 0),
	('Tilburg', 'Tilburger Toernooi', 7, 0),
	('Tilburg', 'Tilburger Toernooi', 8, 0),
	('Tilburg', 'Tilburger Toernooi', 9, 0),
	('Tilburg', 'Tilburger Toernooi', 10, 0),
	('Tilburg', 'Tilburger Toernooi', 11, 0),
	('Tilburg', 'Tilburger Toernooi', 12, 0),
	('Tilburg', 'Tilburger Toernooi', 13, 0),
	('Tilburg', 'Tilburger Toernooi', 14, 1);

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
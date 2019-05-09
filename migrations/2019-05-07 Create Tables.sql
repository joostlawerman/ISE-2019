-- +migrate Up 
CREATE TABLE CHESSCLUB (
    chessclubname VARCHAR(15)  NOT NULL,
    city          CHAR(15)     NOT NULL,
    addressline1  VARCHAR(25)  NOT NULL,
    postalcode    VARCHAR(6)   NOT NULL,
    chairman      VARCHAR(101) NOT NULL,
    secretary     VARCHAR(101) NOT NULL,
    emailaddress  VARCHAR(30)  NOT NULL,
    CONSTRAINT PK_CHESSCLUB PRIMARY KEY NONCLUSTERED (chessclubname)
);
-- +migrate Up 
CREATE TABLE PLAYER (
    playerid      INT         NOT NULL,
    chessclubname VARCHAR(15) NULL,
    firstname     VARCHAR(50) NOT NULL,
    lastname      VARCHAR(50) NOT NULL,
    addressline1  VARCHAR(25) NOT NULL,
    postalcode    VARCHAR(6)  NOT NULL,
    city          CHAR(15)    NOT NULL,
    birthdate     DATETIME    NOT NULL,
    emailaddress  VARCHAR(30) NOT NULL,
    CONSTRAINT PK_PLAYER PRIMARY KEY NONCLUSTERED (playerid),
    CONSTRAINT FK_PLAYER_PLAYER_IN_CHESSCLU FOREIGN KEY (chessclubname) REFERENCES CHESSCLUB (chessclubname)
);
-- +migrate Up
CREATE TABLE CONTACTPERSON (
    contactname  VARCHAR(101) NOT NULL,
    emailaddress VARCHAR(30)  NOT NULL,
    phonenumber  NUMERIC(10)  NOT NULL,
    CONSTRAINT PK_CONTACTPERSON PRIMARY KEY NONCLUSTERED (contactname)
);
-- +migrate Up
CREATE TABLE TOURNAMENT (
    chessclubname    VARCHAR(15)  NOT NULL,
    tournamentname   VARCHAR(50)  NOT NULL,
    winner           INT          NULL,
    contactname      VARCHAR(101) NOT NULL,
    starts           DATETIME     NOT NULL,
    ends             DATETIME     NOT NULL,
    registrationfee  MONEY        NOT NULL,
    addressline1     VARCHAR(25)  NOT NULL,
    postalcode       VARCHAR(6)   NOT NULL,
    city             CHAR(15)     NOT NULL,
    registrationtime DATETIME     NOT NULL,
    CONSTRAINT PK_TOURNAMENT PRIMARY KEY NONCLUSTERED (chessclubname, tournamentname),
    CONSTRAINT FK_TOURNAME_CONTACTPE_CONTACTP FOREIGN KEY (contactname) REFERENCES CONTACTPERSON (contactname),
    CONSTRAINT FK_TOURNAME_TOURNAMEN_CHESSCLU FOREIGN KEY (chessclubname) REFERENCES CHESSCLUB (chessclubname),
    CONSTRAINT FK_TOURNAME_WINNER_OF_PLAYER FOREIGN KEY (winner) REFERENCES PLAYER (playerid)
);
-- +migrate Up
CREATE TABLE TOURNAMENT_ROUND (
    chessclubname  VARCHAR(15) NOT NULL,
    tournamentname VARCHAR(50) NOT NULL,
    roundnumber    INT         NOT NULL,
    system         VARCHAR(25) NOT NULL,
    starts         DATETIME    NOT NULL,
    ends           DATETIME    NOT NULL,
    CONSTRAINT PK_TOURNAMENT_ROUND PRIMARY KEY NONCLUSTERED (chessclubname, tournamentname, roundnumber),
    CONSTRAINT FK_TOURNAME_TOURNAMEN_TOURNAME FOREIGN KEY (chessclubname, tournamentname) REFERENCES TOURNAMENT (chessclubname, tournamentname)
);
-- +migrate Up
CREATE TABLE POULE (
    chessclubname  VARCHAR(15) NOT NULL,
    tournamentname VARCHAR(50) NOT NULL,
    roundnumber    INT         NOT NULL,
    pouleno        INT         NOT NULL,
    CONSTRAINT PK_POULE PRIMARY KEY NONCLUSTERED (chessclubname, tournamentname, roundnumber, pouleno),
    CONSTRAINT FK_POULE_TOURNAMEN_TOURNAME FOREIGN KEY (chessclubname, tournamentname, roundnumber) REFERENCES TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber)
);
-- +migrate Up
CREATE TABLE TOURNAMENT_PLAYER (
    chessclubname  VARCHAR(15) NOT NULL,
    tournamentname VARCHAR(50) NOT NULL,
    playerid       INT         NOT NULL,
    paid           BIT         NOT NULL,
    CONSTRAINT PK_TOURNAMENT_PLAYER PRIMARY KEY (chessclubname, tournamentname, playerid),
    CONSTRAINT FK_TOURNAME_PLAYER_FR_TOURNAME FOREIGN KEY (chessclubname, tournamentname) REFERENCES TOURNAMENT (chessclubname, tournamentname),
    CONSTRAINT FK_TOURNAME_TOURNAMEN_PLAYER FOREIGN KEY (playerid) REFERENCES PLAYER (playerid)
);
-- +migrate Up
CREATE TABLE TOURNAMENT_PLAYER_OF_POULE (
    chessclubname  VARCHAR(15) NOT NULL,
    playerid       INT         NOT NULL,
    tournamentname VARCHAR(50) NOT NULL,
    roundnumber    INT         NOT NULL,
    pouleno        INT         NOT NULL,
    CONSTRAINT PK_TOURNAMENT_PLAYER_OF_POULE PRIMARY KEY (chessclubname, playerid, tournamentname, roundnumber, pouleno),
    CONSTRAINT FK_PLAYER_POULE_POULE FOREIGN KEY (chessclubname, tournamentname, roundnumber, pouleno) REFERENCES POULE (chessclubname, tournamentname, roundnumber, pouleno),
    CONSTRAINT FK_TOURPLAY_PLAYER_POULE FOREIGN KEY (chessclubname, tournamentname, playerid) REFERENCES TOURNAMENT_PLAYER (chessclubname, tournamentname, playerid),
);
-- +migrate Up
CREATE TABLE CHESSMATCH (
    matchno        INT         NOT NULL,
    chessclubname  VARCHAR(15) NOT NULL,
    tournamentname VARCHAR(50) NOT NULL,
    roundnumber    INT         NOT NULL,
    pouleno        INT         NOT NULL,
    playeridwhite  INT         NOT NULL,
    playeridblack  INT         NOT NULL,
    result         CHAR(6)     NOT NULL,
    CONSTRAINT PK_CHESSMATCH PRIMARY KEY NONCLUSTERED (matchno),
    CONSTRAINT FK_CHESSMAT_BLACK_PLA_PLAYER FOREIGN KEY (playeridblack) REFERENCES PLAYER (playerid),
    CONSTRAINT FK_CHESSMAT_CHESSMATC_POULE FOREIGN KEY (chessclubname, tournamentname, roundnumber, pouleno) REFERENCES POULE (chessclubname, tournamentname, roundnumber, pouleno),
    CONSTRAINT FK_CHESSMAT_WHITE_PLA_PLAYER FOREIGN KEY (playeridwhite) REFERENCES PLAYER (playerid)
);
-- +migrate Up
CREATE TABLE ROUND_ROBIN_POULE (
    chessclubname  VARCHAR(15) NOT NULL,
    tournamentname VARCHAR(50) NOT NULL,
    roundnumber    INT         NOT NULL,
    pouleno        INT         NOT NULL,
    CONSTRAINT PK_ROUND_ROBIN_POULE PRIMARY KEY (chessclubname, tournamentname, roundnumber, pouleno),
    CONSTRAINT FK_ROUND_RO_IS_A_POUL_POULE FOREIGN KEY (chessclubname, tournamentname, roundnumber, pouleno) REFERENCES POULE (chessclubname, tournamentname, roundnumber, pouleno)
);
-- +migrate Up
CREATE TABLE SPONSOR (
    chessclubname  VARCHAR(15)  NOT NULL,
    tournamentname VARCHAR(50)  NOT NULL,
    sponsorname    VARCHAR(30)  NOT NULL,
    contactname    VARCHAR(101) NOT NULL,
    sponsoramount  MONEY        NOT NULL,
    CONSTRAINT PK_SPONSOR PRIMARY KEY NONCLUSTERED (chessclubname, tournamentname, sponsorname),
    CONSTRAINT FK_SPONSOR_CONTACTPE_CONTACTP FOREIGN KEY (contactname) REFERENCES CONTACTPERSON (contactname),
    CONSTRAINT FK_SPONSOR_SPONSOR_O_TOURNAME FOREIGN KEY (chessclubname, tournamentname) REFERENCES TOURNAMENT (chessclubname, tournamentname)
);


-- +migrate Down
DROP TABLE ROUND_ROBIN_POULE;
-- +migrate Down
DROP TABLE TOURNAMENT_PLAYER_OF_POULE;
-- +migrate Down
DROP TABLE CHESSMATCH;
-- +migrate Down
DROP TABLE SPONSOR;
-- +migrate Down
DROP TABLE POULE;
-- +migrate Down
DROP TABLE TOURNAMENT_ROUND;
-- +migrate Down
DROP TABLE TOURNAMENT_PLAYER;
-- +migrate Down
DROP TABLE TOURNAMENT;
-- +migrate Down
DROP TABLE PLAYER;
-- +migrate Down
DROP TABLE CONTACTPERSON;
-- +migrate Down
DROP TABLE CHESSCLUB;




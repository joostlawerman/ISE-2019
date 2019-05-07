-- +migrate Up 
create table CHESSCLUB (
   CHESSCLUBNAME        varchar(15)          not null,
   CITY                 char(15)             not null,
   ADDRESSLINE1         varchar(25)          not null,
   POSTALCODE           varchar(6)           not null,
   CHAIRMAN             varchar(30)          not null,
   SECRETARY            varchar(30)          not null,
   EMAILADDRESS         varchar(30)          not null,
   constraint PK_CHESSCLUB primary key nonclustered (CHESSCLUBNAME)
)
;

-- +migrate Up 
create table PLAYER (
   PLAYERID             int                  not null,
   CHESSCLUBNAME        varchar(15)          null,
   FIRSTNAME            varchar(10)          not null,
   LASTNAME             varchar(20)          not null,
   ADDRESSLINE1         varchar(25)          not null,
   POSTALCODE           varchar(6)           not null,
   CITY                 char(15)             not null,
   BIRTHDATE            datetime             not null,
   EMAILADDRESS         varchar(30)          not null,
   constraint PK_PLAYER primary key nonclustered (PLAYERID),
   constraint FK_PLAYER_PLAYER_IN_CHESSCLU foreign key (CHESSCLUBNAME)
      references CHESSCLUB (CHESSCLUBNAME)
)
;

-- +migrate Up 
create table TOURNAMENT_ROUND (
   CHESSCLUBNAME        varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   ROUNDNUMBER          int                  not null,
   STARTS               datetime             not null,
   ENDS                 datetime             not null,
   constraint PK_TOURNAMENT_ROUND primary key nonclustered (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER)
)
;

-- +migrate Up 
create table POULE (
   CHESSCLUBNAME        varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   ROUNDNUMBER          int                  not null,
   POULENO              int                  not null,
   constraint PK_POULE primary key nonclustered (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO),
   constraint FK_POULE_TOURNAMEN_TOURNAME foreign key (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER)
      references TOURNAMENT_ROUND (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER)
)
;

-- +migrate Up 
create table CHESSMATCH (
   MATCHNO              int                  not null,
   CHESSCLUBNAME        varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   ROUNDNUMBER          int                  not null,
   POULENO              int                  not null,
   PLAYERIDBLACK        int                  not null,
   PLAYERIDWHITE        int                  not null,
   RESULT               char(6)              not null,
   constraint PK_CHESSMATCH primary key nonclustered (MATCHNO),
   constraint FK_CHESSMAT_BLACK_PLA_PLAYER foreign key (PLAYERIDWHITE)
      references PLAYER (PLAYERID),
   constraint FK_CHESSMAT_WHITE_PLA_PLAYER foreign key (PLAYERIDBLACK)
      references PLAYER (PLAYERID),
   constraint FK_CHESSMAT_CHESSMATC_POULE foreign key (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO)
      references POULE (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO)
)
;

-- +migrate Up 
create index BLACK_PLAYER_OF_MATCH_FK on CHESSMATCH (
PLAYERIDWHITE ASC
)
;

-- +migrate Up 
create index WHITE_PLAYER_OF_MATCH_FK on CHESSMATCH (
PLAYERIDBLACK ASC
)
;

-- +migrate Up 
create index CHESSMATCH_OF_POULE_FK on CHESSMATCH (
CHESSCLUBNAME ASC,
TOURNAMENTNAME ASC,
ROUNDNUMBER ASC,
POULENO ASC
)
;

-- +migrate Up 
create table CONTACTPERSON (
   CONTACTNAME          varchar(30)          not null,
   EMAILADDRESS         varchar(30)          not null,
   PHONENUMBER          numeric(15)          not null,
   constraint PK_CONTACTPERSON primary key nonclustered (CONTACTNAME)
)
;

-- +migrate Up 
create index PLAYER_IN_CLUB_FK on PLAYER (
CHESSCLUBNAME ASC
)
;

-- +migrate Up 
create index TOURNAMENT_ROUND_IN_POULE_FK on POULE (
CHESSCLUBNAME ASC,
TOURNAMENTNAME ASC,
ROUNDNUMBER ASC
)
;

-- +migrate Up 
create table ROUND_ROBIN_POULE (
   CHESSCLUBNAME        varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   ROUNDNUMBER          int                  not null,
   POULENO              int                  not null,
   constraint PK_ROUND_ROBIN_POULE primary key (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO),
   constraint FK_ROUND_RO_IS_A_POUL_POULE foreign key (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO)
      references POULE (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO)
)
;

-- +migrate Up 
create table TOURNAMENT (
   CHESSCLUBNAME        varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   PLAYERID             int                  null,
   CONTACTNAME          varchar(30)          not null,
   STARTS               datetime             not null,
   ENDS                 datetime             not null,
   REGISTRATIONFEE      numeric(8,2)         not null,
   ADDRESSLINE1         varchar(25)          not null,
   POSTALCODE           varchar(6)           not null,
   CITY                 char(15)             not null,
   REGISTRATIONTIME     timestamp            not null,
   constraint PK_TOURNAMENT primary key nonclustered (CHESSCLUBNAME, TOURNAMENTNAME),
   constraint FK_TOURNAME_TOURNAMEN_CHESSCLU foreign key (CHESSCLUBNAME)
      references CHESSCLUB (CHESSCLUBNAME),
   constraint FK_TOURNAME_CONTACTPE_CONTACTP foreign key (CONTACTNAME)
      references CONTACTPERSON (CONTACTNAME),
   constraint FK_TOURNAME_WINNER_OF_PLAYER foreign key (PLAYERID)
      references PLAYER (PLAYERID)
)
;

-- +migrate Up 
create table SPONSOR (
   CHESSCLUBNAME        varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   CONTACTNAME          varchar(30)          not null,
   constraint PK_SPONSOR primary key nonclustered (CHESSCLUBNAME, TOURNAMENTNAME),
   constraint FK_SPONSOR_SPONSOR_O_TOURNAME foreign key (CHESSCLUBNAME, TOURNAMENTNAME)
      references TOURNAMENT (CHESSCLUBNAME, TOURNAMENTNAME),
   constraint FK_SPONSOR_CONTACTPE_CONTACTP foreign key (CONTACTNAME)
      references CONTACTPERSON (CONTACTNAME)
)
;

-- +migrate Up 
create index SPONSOR_OF_TOURNAMENT_FK on SPONSOR (
CHESSCLUBNAME ASC,
TOURNAMENTNAME ASC
)
;

-- +migrate Up 
create index CONTACTPERSON_OF_SPONSOR_FK on SPONSOR (
CONTACTNAME ASC
)
;

-- +migrate Up 
create index TOURNAMENT_OF_CHESSCLUB_FK on TOURNAMENT (
CHESSCLUBNAME ASC
)
;

-- +migrate Up 
create index CONTACTPERSON_OF_TOURNAMENT_FK on TOURNAMENT (
CONTACTNAME ASC
)
;

-- +migrate Up 
create index WINNER_OF_TOURNAMENT_FK on TOURNAMENT (
PLAYERID ASC
)
;

-- +migrate Up 
create table TOURNAMENT_PLAYER (
   CHESSCLUBNAME        varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   PLAYERID             int                  not null,
   PAID                 smallint             not null,
   constraint PK_TOURNAMENT_PLAYER primary key nonclustered (CHESSCLUBNAME, TOURNAMENTNAME, PLAYERID),
   constraint FK_TOURNAME_PLAYER_FR_TOURNAME foreign key (CHESSCLUBNAME, TOURNAMENTNAME)
      references TOURNAMENT (CHESSCLUBNAME, TOURNAMENTNAME),
   constraint FK_TOURNAME_TOURNAMEN_PLAYER foreign key (PLAYERID)
      references PLAYER (PLAYERID)
)
;

-- +migrate Up 
create index PLAYER_FROM_TOURNAMENT_FK on TOURNAMENT_PLAYER (
CHESSCLUBNAME ASC,
TOURNAMENTNAME ASC
)
;

-- +migrate Up 
create index TOURNAMENT_FROM_PLAYER_FK on TOURNAMENT_PLAYER (
PLAYERID ASC
)
;

-- +migrate Up 
create table TOURNAMENT_PLAYER_OF_POULE (
   CHESSCLUBNAME        varchar(15)          not null,
   TOU_TOURNAMENTNAME   varchar(50)          not null,
   PLAYERID             int                  not null,
   POU_CHESSCLUBNAME    varchar(15)          not null,
   TOURNAMENTNAME       varchar(50)          not null,
   ROUNDNUMBER          int                  not null,
   POULENO              int                  not null,
   constraint PK_TOURNAMENT_PLAYER_OF_POULE primary key nonclustered (CHESSCLUBNAME, TOU_TOURNAMENTNAME, PLAYERID, POU_CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO),
   constraint FK_TOURNAME_TOURNAMEN_POULE foreign key (POU_CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO)
      references POULE (CHESSCLUBNAME, TOURNAMENTNAME, ROUNDNUMBER, POULENO)
)
;

-- +migrate Up 
create index TOURNAMENT_PLAYER_OF_POULE_FK on TOURNAMENT_PLAYER_OF_POULE (
POU_CHESSCLUBNAME ASC,
TOURNAMENTNAME ASC,
ROUNDNUMBER ASC,
POULENO ASC
)
;

-- +migrate Up 
create index TOURNAMENT_PLAYER_OF_POULE2_FK on TOURNAMENT_PLAYER_OF_POULE (
CHESSCLUBNAME ASC,
TOU_TOURNAMENTNAME ASC,
PLAYERID ASC
)
;

-- +migrate Up 
create index TOURNAMENT_ROUND_OF_TOURNAMENT_FK on TOURNAMENT_ROUND (
CHESSCLUBNAME ASC,
TOURNAMENTNAME ASC
)
;


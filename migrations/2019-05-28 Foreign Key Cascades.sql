-- +migrate Up
ALTER TABLE TOURNAMENT_ROUND DROP CONSTRAINT FK_TOURNAME_TOURNAMEN_TOURNAME;
-- +migrate Up
ALTER TABLE POULE DROP CONSTRAINT FK_POULE_TOURNAMEN_TOURNAME;
-- +migrate Up
ALTER TABLE TOURNAMENT_PLAYER DROP CONSTRAINT FK_TOURNAME_PLAYER_FR_TOURNAME;
-- +migrate Up
ALTER TABLE TOURNAMENT_PLAYER_OF_POULE DROP CONSTRAINT FK_TOURNAME_POULE_POULE;
-- +migrate Up
ALTER TABLE CHESSMATCH_OF_POULE DROP CONSTRAINT FK_CHESSMAT_CHESSMATC_POULE;
-- +migrate Up
ALTER TABLE ROUND_ROBIN_POULE DROP CONSTRAINT FK_ROUND_RO_IS_A_POUL_POULE;
-- +migrate Up
ALTER TABLE SPONSOR DROP CONSTRAINT FK_SPONSOR_SPONSOR_O_TOURNAME;

-- +migrate Up
ALTER TABLE TOURNAMENT_ROUND ADD CONSTRAINT FK_TOURNAME_TOURNAMEN_TOURNAME FOREIGN KEY (chessclubname, tournamentname) REFERENCES TOURNAMENT (chessclubname, tournamentname) ON UPDATE CASCADE;
-- +migrate Up
ALTER TABLE POULE ADD CONSTRAINT FK_POULE_TOURNAMEN_TOURNAME FOREIGN KEY (chessclubname, tournamentname, roundnumber) REFERENCES TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber) ON UPDATE CASCADE;
-- +migrate Up
ALTER TABLE TOURNAMENT_PLAYER ADD CONSTRAINT FK_TOURNAME_PLAYER_FR_TOURNAME FOREIGN KEY (chessclubname, tournamentname) REFERENCES TOURNAMENT (chessclubname, tournamentname) ON UPDATE CASCADE;
-- +migrate Up
ALTER TABLE TOURNAMENT_PLAYER_OF_POULE ADD CONSTRAINT FK_TOURNAME_POULE_POULE FOREIGN KEY (chessclubname, tournamentname, roundnumber, pouleno) REFERENCES POULE (chessclubname, tournamentname, roundnumber, pouleno) ON UPDATE CASCADE;
-- +migrate Up
ALTER TABLE CHESSMATCH_OF_POULE ADD CONSTRAINT FK_CHESSMAT_CHESSMATC_POULE FOREIGN KEY (chessclubname, tournamentname, roundnumber, pouleno) REFERENCES POULE (chessclubname, tournamentname, roundnumber, pouleno) ON UPDATE CASCADE;
-- +migrate Up
ALTER TABLE ROUND_ROBIN_POULE ADD CONSTRAINT FK_ROUND_RO_IS_A_POUL_POULE FOREIGN KEY (chessclubname, tournamentname, roundnumber, pouleno) REFERENCES POULE (chessclubname, tournamentname, roundnumber, pouleno) ON UPDATE CASCADE;
-- +migrate Up
ALTER TABLE SPONSOR ADD CONSTRAINT FK_SPONSOR_SPONSOR_O_TOURNAME FOREIGN KEY (chessclubname, tournamentname) REFERENCES TOURNAMENT (chessclubname, tournamentname) ON UPDATE CASCADE;
-- +migrate Up 
EXEC tSQLt.NewTestClass 'ir13'
;

-- +migrate Down
EXEC tSQLt.DropClass 'ir13'
;

-- +migrate Up 
CREATE OR ALTER PROCEDURE ir13.test_tournament_of_player_poule_does_not_collide AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'
        EXEC tSQLt.ApplyConstraint @SchemaName = 'dbo', @Tablename = 'TOURNAMENT_PLAYER_OF_POULE',
                                   @ConstraintName = 'UC_TOURNAMENT_POULE_IN_TOURNAMENT_PLAYER_OF_POULE'

        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
            ChessClubName, PlayerID, TournamentName, RoundNumber, PouleNo
        ) VALUES (
            'Arnhemse Schaak Club', 300, 'In het Gemaal', 1, 10
        )

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
            ChessClubName, PlayerID, TournamentName, RoundNumber, PouleNo
        ) VALUES (
            'Arnhemse Schaak Club', 200, 'In het Gemaal', 1, 10
        )

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
            ChessClubName, PlayerID, TournamentName, RoundNumber, PouleNo
        ) VALUES (
            'Arnhemse Schaak Club', 300, 'In het Gemaal', 2, 10
        )
    END
;

-- +migrate Up 
CREATE OR ALTER PROCEDURE ir13.test_tournament_of_player_poule_does_not_collides AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'
        EXEC tSQLt.ApplyConstraint @SchemaName = 'dbo', @Tablename = 'TOURNAMENT_PLAYER_OF_POULE',
                                   @ConstraintName = 'UC_TOURNAMENT_POULE_IN_TOURNAMENT_PLAYER_OF_POULE'

        EXEC tSQLt.ExpectException

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
            ChessClubName, PlayerID, TournamentName, RoundNumber, PouleNo
        ) VALUES (
            'Arnhemse Schaak Club', 300, 'In het Gemaal', 1, 10
        )

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
            ChessClubName, PlayerID, TournamentName, RoundNumber, PouleNo
        ) VALUES (
            'Arnhemse Schaak Club', 300, 'In het Gemaal', 1, 9
        )
    END
;
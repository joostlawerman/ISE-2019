-- +migrate Up
EXEC tSQLt.NewTestClass 'SP21';

-- +migrate Down
EXEC tSQLt.DropClass 'SP21';

-- +migrate Up
CREATE PROCEDURE SP21.SetUp AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCHMOVE'
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
        INSERT INTO CHESSMATCHMOVE (matchno, moveno, colour, destination) VALUES
            (1, 10, 'W', 'e4'),
            (1, 11, 'W', 'h4'),
            (1, 11, 'B', 'd4')

        INSERT INTO CHESSMATCH_OF_POULE (matchno) VALUES (1)
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmatch_does_not_exist AS
    BEGIN
        EXEC tSQLt.ExpectException 'There is no chessmatch with this number'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 2, 1, 'B', 'e4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_incorrect_player_colour AS
    BEGIN
        EXEC tSQLt.ExpectException 'Player should be either "W" or "B"'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'G', 'e4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_movenotation_is_to_short AS
    BEGIN
        EXEC tSQLt.ExpectException 'This cannot be a valid move'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'e'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_whites_move_was_already_registered AS
    BEGIN
        EXEC tSQLt.ExpectException 'There is already a move recorded for this player with this movenumber'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 10, 'W', 'e4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_blacks_move_was_already_registered AS
    BEGIN
        EXEC tSQLt.ExpectException 'There is already a move recorded for this player with this movenumber'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 11, 'B', 'e4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_move_file_out_of_bounds AS
    BEGIN
        EXEC tSQLt.ExpectException 'This is not a valid move'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'i4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_move_rank_out_of_bounds AS
    BEGIN
        EXEC tSQLt.ExpectException 'This is not a valid move'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'a9'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_unknown_piece_moves AS
    BEGIN
        EXEC tSQLt.ExpectException 'This is not a valid move'
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Wa9'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_queenside_castling AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'O-O-O'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_queenside_castling_check AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'O-O-O+'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_kingside_castling AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'O-O'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_kingside_castling_checkmate AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'O-O#'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_pawn_to_e4 AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'e4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_king_to_e4 AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Ke4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_pawn_to_e4_check AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'e4+'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_king_takes_e4 AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Kxe4'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_pawn_a1_to_queen AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'a1=Q'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_king_takes_e4_mate AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Kxe4#'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_queen_file_a_takes_a1 AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Qaxa1'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_rook_rank_4_takes_a1 AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'R4xa1'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_pawn_a1_to_queen_mate AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'a1=Q#'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_knight_file_a_takes_c2 AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Naxc2'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_rook_rank_a_moves_to_a1 AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Raa1'
    END;

-- +migrate Up
CREATE PROCEDURE SP21.test_chessmove_rook_rank_a_moves_to_a1_check AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        EXEC SP_INSERT_CHESSMOVE 1, 1, 'B', 'Raa1+'
    END;

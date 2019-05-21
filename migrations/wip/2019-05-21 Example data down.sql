-- +migrate Down
DELETE FROM TOURNAMENT_PLAYER;

-- +migrate Down
DELETE FROM TOURNAMENT;

-- +migrate Down
DELETE FROM CONTACTPERSON;

-- +migrate Down
DELETE FROM ROLE;

-- +migrate Down
DELETE FROM PLAYER;

-- +migrate Down
DELETE FROM CHESSCLUB;

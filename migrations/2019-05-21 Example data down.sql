-- +migrate Down
DELETE FROM CHESSMATCHMOVE;

-- +migrate Down
DELETE FROM ROUND_ROBIN_POULE;

-- +migrate Down
DELETE FROM SPONSOR;

-- +migrate Down
DELETE FROM CHESSMATCH_OF_POULE;

-- +migrate Down
DELETE FROM TOURNAMENT_PLAYER_OF_POULE;

-- +migrate Down
DELETE FROM ROLE;


-- +migrate Down
DELETE FROM POULE;

-- +migrate Down
DELETE FROM TOURNAMENT_ROUND;

-- +migrate Down
DELETE FROM TOURNAMENT_PLAYER;

-- +migrate Down
DELETE FROM TOURNAMENT;

-- +migrate Down
DELETE FROM CONTACTPERSON;

-- +migrate Down
DELETE FROM PLAYER;

-- +migrate Down
DELETE FROM CHESSCLUB;
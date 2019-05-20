-- +migrate Up
CREATE TRIGGER TRIGGER_PLAYER_WITH_ROLE_IS_MEMBER_OF_CHESSCLUB
ON ROLE
AFTER INSERT, UPDATE
AS
BEGIN TRY
			IF EXISTS (SELECT 1
						FROM Inserted i INNER JOIN ROLE r ON i.playerid = r.playerid AND i.chessclubname = r.chessclubname
						WHERE NOT EXISTS(
										SELECT 1
										FROM PLAYER p
										WHERE p.playerId = r.playerId and p.chessclubname = r.chessclubname ))
      		BEGIN
              	   THROW 50000, 'Only players that are members of a chessclub can have a role in that chessclub', 1
      		END
END TRY
BEGIN CATCH
   	THROW
END CATCH;

-- +migrate Down
DROP TRIGGER TRIGGER_PLAYER_WITH_ROLE_IS_MEMBER_OF_CHESSCLUB;
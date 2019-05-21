-- +migrate Up
CREATE TRIGGER TRIGGER_LOCATION_DEFAULT_CHESSCLUB_LOCATION
ON TOURNAMENT
AFTER INSERT, UPDATE
AS

IF @@ROWCOUNT = 0
	RETURN
        
SET NOCOUNT ON

BEGIN TRY
	UPDATE TOURNAMENT SET	addressline1=	(SELECT c.addressline1 FROM CHESSCLUB c
											WHERE c.chessclubname = t.chessclubname), 
							city=			(SELECT c.city FROM CHESSCLUB c
											WHERE c.chessclubname = t.chessclubname), 
							postalcode=		(SELECT c.postalcode FROM CHESSCLUB c
											WHERE c.chessclubname = t.chessclubname)
	FROM TOURNAMENT t
	WHERE t.chessclubname IN (SELECT i.chessclubname FROM inserted i 
							WHERE i.addressline1 IS NULL OR i.city IS NULL OR i.postalcode IS NULL)
	AND t.tournamentname IN (SELECT i.tournamentname FROM inserted i 
							WHERE i.addressline1 IS NULL OR i.city IS NULL OR i.postalcode IS NULL)
END TRY
BEGIN CATCH
	THROW
END CATCH;

-- +migrate Down
DROP TRIGGER TRIGGER_LOCATION_DEFAULT_CHESSCLUB_LOCATION;
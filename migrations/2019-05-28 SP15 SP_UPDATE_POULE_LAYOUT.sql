-- +migrate Up
CREATE PROC SP_UPDATE_POULE_LAYOUT (
    @chessclubname varchar(100),
    @tournamentname varchar(100),
    @roundnumber int,
    @playerA int,
    @playerB int
)
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  

	BEGIN TRY
		IF NOT EXISTS(
            SELECT 1 
            FROM TOURNAMENT_PLAYER_OF_POULE
            WHERE roundnumber = @roundnumber
                AND tournamentname = @tournamentname
                AND chessclubname = @chessclubname
        )
            THROW 50001, 'The given tournament round cannot be found.', 1
        ELSE IF NOT EXISTS(
            SELECT 1 
            FROM TOURNAMENT_PLAYER_OF_POULE
            WHERE roundnumber = @roundnumber
                AND tournamentname = @tournamentname
                AND chessclubname = @chessclubname
                AND playerid in (@playerA, @playerB)
            HAVING COUNT(*) = 2
        )
            THROW 50001, 'Could not find these players within this round.', 1
		ELSE
			BEGIN
                SELECT 
                    pouleno,
                    IIF(playerid = @playerA, @playerB, @playerA) playerid,
                    roundnumber,
                    tournamentname,
                    chessclubname
                INTO #tmp
                FROM TOURNAMENT_PLAYER_OF_POULE
                WHERE roundnumber = @roundnumber
                    AND tournamentname = @tournamentname
                    AND chessclubname = @chessclubname
                    AND playerid in (@playerA, @playerB)

                UPDATE TOURNAMENT_PLAYER_OF_POULE
                SET pouleno = (
                    select pouleno
                    from #tmp
                    WHERE #tmp.playerid = TOURNAMENT_PLAYER_OF_POULE.playerid
                )
                
                DROP TABLE #tmp
			END		

        IF @orginTranCount = 0  
            COMMIT TRANSACTION 
	END TRY
	BEGIN CATCH
		IF @orginTranCount = 0  
            ROLLBACK TRANSACTION  
        ELSE  
			IF XACT_STATE() <> -1  
            ROLLBACK TRANSACTION ProcedureSave  
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END;

-- +migrate Down
DROP PROC SP_UPDATE_POULE_LAYOUT; 
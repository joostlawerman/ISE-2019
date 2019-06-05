-- +migrate Up
CREATE TRIGGER TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE
    ON CHESSMATCH_OF_POULE
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY

        IF EXISTS(SELECT 1
                  FROM
                      (
                           /*(
                             (
                                  SELECT
                                      i.chessclubname,
                                      i.tournamentname,
                                      i.roundnumber,
                                      i.pouleno,
                                      concat(playeridblack, '-', playeridwhite) AS match
                                  FROM inserted i
                                      INNER JOIN TOURNAMENT_ROUND tr ON tr.tournamentname = i.tournamentname AND
                                                                        tr.chessclubname = i.chessclubname AND
                                                                        tr.roundnumber = i.roundnumber
                                  WHERE playeridwhite > playeridblack AND tr.system = 'round robin'
                              )
                              UNION ALL
                              (
                                  SELECT
                                      i.chessclubname,
                                      i.tournamentname,
                                      i.roundnumber,
                                      i.pouleno,
                                      concat(i.playeridwhite, '-', playeridblack) AS match
                                  FROM inserted i
                                      INNER JOIN TOURNAMENT_ROUND tr ON tr.tournamentname = i.tournamentname AND
                                                                        tr.chessclubname = i.chessclubname AND
                                                                        tr.roundnumber = i.roundnumber
                                  WHERE playeridwhite < playeridblack AND tr.system = 'round robin'
                              )
                          )
                          UNION ALL */
                          (
                              (
                                  SELECT
                                      cp.chessclubname,
                                      cp.tournamentname,
                                      cp.roundnumber,
                                      cp.pouleno,
                                      concat(cp.playeridblack, '-', cp.playeridwhite) AS match
                                  FROM CHESSMATCH_OF_POULE cp
                                      INNER JOIN inserted i ON cp.tournamentname = i.tournamentname AND
                                                               cp.chessclubname = i.chessclubname AND
                                                               cp.roundnumber = i.roundnumber AND
                                                               cp.pouleno = i.pouleno
                                      INNER JOIN TOURNAMENT_ROUND tr ON tr.tournamentname = i.tournamentname AND
                                                                        tr.chessclubname = i.chessclubname AND
                                                                        tr.roundnumber = i.roundnumber
                                  WHERE cp.playeridwhite > cp.playeridblack AND tr.system = 'round robin'
                              )
                              UNION ALL
                              (
                                  SELECT
                                      cp.chessclubname,
                                      cp.tournamentname,
                                      cp.roundnumber,
                                      cp.pouleno,
                                      concat(cp.playeridwhite, '-', cp.playeridblack) AS match
                                  FROM CHESSMATCH_OF_POULE cp
                                      INNER JOIN inserted i ON cp.tournamentname = i.tournamentname AND
                                                               cp.chessclubname = i.chessclubname AND
                                                               cp.roundnumber = i.roundnumber AND
                                                               cp.pouleno = i.pouleno

                                      INNER JOIN TOURNAMENT_ROUND tr ON tr.tournamentname = i.tournamentname AND
                                                                        tr.chessclubname = i.chessclubname AND
                                                                        tr.roundnumber = i.roundnumber
                                  WHERE cp.playeridwhite < cp.playeridblack AND tr.system = 'round robin'
                              )
                          )
                      ) uni
                  GROUP BY chessclubname, tournamentname, roundnumber, pouleno, match
                  HAVING COUNT(MATCH) > 1)
            BEGIN
                THROW 50001, 'There is a match that is duplicate in a round robin poule', 1
            END
        END TRY
        BEGIN CATCH
        THROW
        END CATCH
    END;

-- +migrate Down
DROP TRIGGER TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE;


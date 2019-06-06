-- +migrate Up
CREATE TRIGGER TRIGGER_PLAYER_HAS_EVEN_NUMBER_OF_WHITE_MATCHES_AS_BLACK_MATCHES
ON CHESSMATCH_OF_POULE
AFTER INSERT, UPDATE
AS
    IF @@ROWCOUNT = 0
        RETURN
        
    SET NOCOUNT ON
    BEGIN TRY
        IF EXISTS (
            select 1
            from Inserted i
            where exists (
                select 1
                from (
                    select 
                        chessclubname,
                        tournamentname,
                        roundnumber,
                        playeridwhite as player,
                        count(*) matches,
                        'WHITE' color
                    from CHESSMATCH_OF_POULE
                    group by chessclubname,
                        tournamentname,
                        roundnumber,
                        playeridwhite
                ) cmp 
                where cmp.chessclubname = i.chessclubname
                    and cmp.tournamentname = i.tournamentname
                    and cmp.roundnumber = i.roundnumber
                    and cmp.player in (i.playeridwhite, i.playeridblack)
                    and (
                        exists (
                            select 1
                            from CHESSMATCH_OF_POULE icm
                            where icm.playeridblack = cmp.player
                                and icm.chessclubname = cmp.chessclubname
                                and icm.tournamentname = cmp.tournamentname
                                and icm.roundnumber = cmp.roundnumber
                            group by icm.chessclubname,
                                icm.tournamentname,
                                icm.roundnumber,
                                icm.playeridblack
                            having (count(*) - cmp.matches) > 1
                        )
                            or (
                                not exists (
                                    select 1
                                    from CHESSMATCH_OF_POULE icm
                                    where icm.playeridblack = cmp.player
                                        and icm.chessclubname = cmp.chessclubname
                                        and icm.tournamentname = cmp.tournamentname
                                        and icm.roundnumber = cmp.roundnumber
                                )
                                and cmp.matches > 1
                            )
                    )
            )
                or exists (
                    select 1
                    from (
                        select 
                            chessclubname,
                            tournamentname,
                            roundnumber,
                            playeridblack as player,
                            count(*) matches,
                            'BLACK' color
                        from CHESSMATCH_OF_POULE
                        group by chessclubname,
                            tournamentname,
                            roundnumber,
                            playeridblack
                    ) cmp 
                    where cmp.chessclubname = i.chessclubname
                        and cmp.tournamentname = i.tournamentname
                        and cmp.roundnumber = i.roundnumber
                        and cmp.player in (i.playeridwhite, i.playeridblack)
                        and (
                            exists (
                                select 1
                                from CHESSMATCH_OF_POULE icm
                                where icm.playeridwhite = cmp.player
                                    and icm.chessclubname = cmp.chessclubname
                                    and icm.tournamentname = cmp.tournamentname
                                    and icm.roundnumber = cmp.roundnumber
                                group by icm.chessclubname,
                                    icm.tournamentname,
                                    icm.roundnumber,
                                    icm.playeridwhite
                                having (count(*) - cmp.matches) > 1
                            )
                                or (
                                    not exists (
                                        select 1
                                        from CHESSMATCH_OF_POULE icm
                                        where icm.playeridwhite = cmp.player
                                            and icm.chessclubname = cmp.chessclubname
                                            and icm.tournamentname = cmp.tournamentname
                                            and icm.roundnumber = cmp.roundnumber
                                    )
                                    and cmp.matches > 1
                                )
                        )
                    )
            )
            BEGIN
                THROW 50000, 'One of the players has been added too many black or white matches within a poule.', 1
            END
    END TRY
    BEGIN CATCH
   	    THROW
    END CATCH;

-- +migrate Down
DROP TRIGGER TRIGGER_PLAYER_HAS_EVEN_NUMBER_OF_WHITE_MATCHES_AS_BLACK_MATCHES;


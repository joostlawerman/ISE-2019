
begin transaction

EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH'

insert into CHESSMATCH
    (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
values
    ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 200, 100)
;

insert into CHESSMATCH
    (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
values
    ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 100, 200)
;

insert into CHESSMATCH
    (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
values
    ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 100, 400)
;

insert into CHESSMATCH
    (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
values
    ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 100, 300)
;

insert into CHESSMATCH
    (chessclubname, tournamentname, roundnumber, pouleno, matchno, playeridblack, playeridwhite)
values
    ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 99, 100, 300)
;

insert into CHESSMATCH
    (chessclubname, tournamentname, roundnumber, pouleno, matchno, playeridblack, playeridwhite)
values
    ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 900, 900, 300)

;
select 
    *
from CHESSMATCH cm
;;


select 
    i.*
from CHESSMATCH i
where i.matchno = 900
    and exists (
        select 1
        from CHESSMATCH cmblack
            left join (
                select *
                from CHESSMATCH cm
                where cm.chessclubname = i.chessclubname
                    and cm.tournamentname = i.tournamentname
                    and cm.roundnumber = i.roundnumber
                    and cm.pouleno = i.pouleno
                    and i.playeridblack = i.playeridblack
            ) as cmwhite on cmwhite.chessclubname = cmblack.chessclubname
                and cmwhite.tournamentname = cmblack.tournamentname
                and cmwhite.roundnumber = cmblack.roundnumber
                and cmwhite.pouleno = cmblack.pouleno
                and cmwhite.playeridwhite = i.playeridblack
        where cmblack.chessclubname = i.chessclubname
            and cmblack.tournamentname = i.tournamentname
            and cmblack.roundnumber = i.roundnumber
            and cmblack.pouleno = i.pouleno
            and cmblack.playeridblack = i.playeridblack
    )



;

-- select 1
-- from CHESSMATCH i
-- where i.matchno = 900
-- and exists (
--     select 1
--     from (
--         select 
--             cm.chessclubname,
--             cm.tournamentname,
--             cm.roundnumber,
--             cm.pouleno,
--             cm.playeridwhite as player,
--             'WHITE' as color
--         from CHESSMATCH cm
--         group by
--             cm.chessclubname, 
--             cm.tournamentname,
--             cm.roundnumber,
--             cm.pouleno,
--             cm.playeridwhite
--         union
--         select 
--             cm.chessclubname,
--             cm.tournamentname,
--             cm.roundnumber,
--             cm.pouleno,
--             cm.playeridblack as player,
--             'BLACK' as color
--         from CHESSMATCH cm
--         group by
--             cm.chessclubname, 
--             cm.tournamentname,
--             cm.roundnumber,
--             cm.pouleno,
--             cm.playeridblack
--     ) matches
--     where matches.chessclubname = i.chessclubname
--         and matches.tournamentname = i.tournamentname
--         and matches.roundnumber = i.roundnumber
--         and matches.pouleno = i.pouleno
--         and (
--             matches.player = i.playeridwhite
--         )
--     group by matches.chessclubname, 
--         matches.tournamentname,
--         matches.roundnumber,
--         matches.pouleno
--     having (SUM(IIF(matches.color = 'WHITE', 1, 0)) - SUM(IIF(matches.color = 'BLACK', 1, 0))) > 1
-- )
-- ;



rollback transaction




-- -- +migrate Up
-- CREATE TRIGGER TRIGGER_PLAYER_HAS_EVEN_NUMBER_OF_WHITE_MATCHES_AS_BLACK_MATCHES
-- ON CHESSMATCH
-- AFTER INSERT, UPDATE
-- AS
--     IF @@ROWCOUNT = 0
--         RETURN
        
--     SET NOCOUNT ON
--     BEGIN TRY
--         IF EXISTS (
--             select 1
--             from Inserted i
--             where exists (
--                 select 1
--                 from (
--                     select 
--                         cm.chessclubname,
--                         cm.tournamentname,
--                         cm.roundnumber,
--                         cm.pouleno,
--                         cm.playeridwhite as player,
--                         'WHITE' as color
--                     from CHESSMATCH cm
--                     group by
--                         cm.chessclubname, 
--                         cm.tournamentname,
--                         cm.roundnumber,
--                         cm.pouleno,
--                         cm.playeridwhite
--                     union
--                     select 
--                         cm.chessclubname,
--                         cm.tournamentname,
--                         cm.roundnumber,
--                         cm.pouleno,
--                         cm.playeridblack as player,
--                         'BLACK' as color
--                     from CHESSMATCH cm
--                     group by
--                         cm.chessclubname, 
--                         cm.tournamentname,
--                         cm.roundnumber,
--                         cm.pouleno,
--                         cm.playeridblack
--                 ) matches
--                 where matches.chessclubname = i.chessclubname
--                     and matches.tournamentname = i.tournamentname
--                     and matches.roundnumber = i.roundnumber
--                     and matches.pouleno = i.pouleno
--                     and (
--                         matches.player = i.playeridblack
--                             or matches.player = i.playeridwhite
--                     )
--                 group by matches.chessclubname, 
--                     matches.tournamentname,
--                     matches.roundnumber,
--                     matches.pouleno
--                 having (SUM(IIF(matches.color = 'WHITE', 1, 0)) - SUM(IIF(matches.color = 'BLACK', 1, 0))) > 1
--             )
--         )
--             BEGIN
--                     THROW 50000, 'A poule can not be changed when a match in that poule has started', 1
--             END
--     END TRY
--     BEGIN CATCH
--    	    THROW
--     END CATCH;

-- -- +migrate Down
-- DROP TRIGGER TRIGGER_PLAYER_HAS_EVEN_NUMBER_OF_WHITE_MATCHES_AS_BLACK_MATCHES;


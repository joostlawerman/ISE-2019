# ISE-2019

## Git flow usage
### Nieuwe feature starten

`git flow feature start ch#-nieuwe-feature` 
Hierbij is de # het nummer van de clubhouse story

In het geval van een samenwerking op dezelfde branch hoeft maar een persoon dit te doen.
Dit moet dan wel gevolgd worden met: `git flow feature publish`. Anders kan de andere niet werken aan hetzelfde.

Wanneer `git flow feature publish` is uitgevoerd hoeft dit niet nogmaals gedaan te worden.

### Afronden van een feature
Commit de veranderingen door middel van `git add .` en `git commit`(oneline `git add . && git commit`)

Indien de feature nog niet aanwezig is op de [globale repository][repo] moet `git flow feature publish` uitgevoerd worden.
Anders kan `git push` uitgevoerd worden.

Hierna moet er een nieuwe [pull request][pr] worden aangemaakt.

Switch na dat gedaan te hebben weer naar de develop branch door middel van `git checkout develop`

## SQL migrate
### Nieuwe up migratie toevoegen
Plak `-- +migrate Up` voor elke SQL statement die uitgevoerd moet worden.

### Nieuwe down migratie toevoegen
Plak `-- +migrate Up` voor elke SQL statement die uitgevoerd moet worden.
Aan te raden om voor elke `CREATE` ook een down migratie te maken. Deze moet er voor zorgen dat de uigevoerde `CREATE` 
ongedaan wordt gemaakt.

### Migratie uitvoeren
In principe zorgt de post-checkout en post-merge hook ervoor dat de migraties worden uitgevoerd. 
Mocht dit op enig moment fout gaan, voer dan `sql-migrate down && sql-migrate up` uit. Als hier een error uit komt 
rollen is de migratie niet goed, en is dit dus een bug


[repo]: (https://github.com/joostlawerman/ISE-2019)
[pr]: (https://github.com/joostlawerman/ISE-2019/pulls)
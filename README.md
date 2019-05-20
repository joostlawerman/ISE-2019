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



[repo]: (https://github.com/joostlawerman/ISE-2019)
[pr]: (https://github.com/joostlawerman/ISE-2019/pulls)
select TeamName
from (
    select distinct TeamId, TeamName from (
        select ContestId, TeamId, TeamName from Teams natural join Contests
        except
        select ContestId, TeamId, TeamName from Teams natural join Sessions natural join Runs
    ) as r1
) as r
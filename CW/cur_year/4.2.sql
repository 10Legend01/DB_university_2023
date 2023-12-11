select TeamId, count(*) as Opened from (
    select distinct TeamId, ContestId, Letter from Runs natural join Sessions
) as r
group by TeamId
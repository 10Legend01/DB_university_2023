insert into Sessions (Start, ContestId, TeamId)
    select current_timestamp, :ContestId, TeamId from Teams
    where TeamId not in (
        select TeamId from Sessions where ContestId = :ContestId
    )
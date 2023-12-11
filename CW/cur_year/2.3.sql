select distinct TeamId from Runs, Sessions
where
    Runs.Sessionid = Sessions.Sessionid and
    Sessions.ContestId = :ContestId and
    Runs.Accepted = 0
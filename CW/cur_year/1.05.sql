select ProblemName
from (
    select ProblemName, Letter from Problems where Letter not in (
        select Letter from Problems natural join Runs where Accepted = 1
    )
) as r
select ProblemName
from (
    select ProblemName, Letter from Problems where Letter not in (
        select Letter from Problems natural join Runs
    )
) as r
select GroupName, AvgAvgMark from Groups left join
(select GroupId, avg(cast(AvgMark as float)) as AvgAvgMark from Students left join
(
    select StudentId, avg(cast(Mark as float)) as AvgMark from Marks group by StudentId
) as res1
    on Students.StudentId = res1.StudentId
    group by GroupId
) as res2
    on Groups.GroupId = res2.GroupId
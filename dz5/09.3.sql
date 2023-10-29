select GroupName, AvgMark from Groups left join
(select GroupId, cast(sum(SumMark) as float) / sum(Count) as AvgMark from Students left join
(
    select StudentId, sum(Mark) as SumMark, count(*) as Count from Marks group by StudentId
) as res1
    on Students.StudentId = res1.StudentId
    group by GroupId
) as res2
    on Groups.GroupId = res2.GroupId
select StudentName, AvgMark from Students left join
(
    select StudentId, avg(cast(Mark as float)) as AvgMark from Marks group by StudentId
) as res
    on Students.StudentId = res.StudentId
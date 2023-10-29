select GroupName, SumMark from Groups left join
(select GroupId, sum(SumMark) as SumMark
 from Students
          left join
      (select StudentId, sum(Mark) as SumMark
       from Marks
       group by StudentId) as res1
      on Students.StudentId = res1.StudentId
 group by GroupId) as res2
    on Groups.GroupId = res2.GroupId
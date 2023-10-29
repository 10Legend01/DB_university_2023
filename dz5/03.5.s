select StudentId, StudentName, GroupId from Students natural join
(
    select StudentId from Marks natural join Plan where Mark = :Mark and LecturerId = :LecturerId
) as r2
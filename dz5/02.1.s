select StudentId, StudentName, GroupName from Students inner join Groups on Students.GroupId = Groups.GroupId where StudentId = :StudentId
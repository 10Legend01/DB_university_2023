select StudentId, CourseId from Marks union
select StudentId, CourseId from Students, Plan where Students.Groupid = Plan.Groupid
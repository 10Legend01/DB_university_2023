select StudentName, CourseName from
(
    select StudentId, CourseId, StudentName, CourseName from Students natural join Plan natural join Courses except
    select StudentId, CourseId, StudentName, CourseName from Students natural join Marks natural join Courses
) as res
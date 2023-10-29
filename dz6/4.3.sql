select StudentName, CourseName from Students, Courses
    where exists
(
    select * from Plan
    where Plan.GroupId = Students.GroupId and Plan.Courseid = Courses.CourseId
)
    and not exists
(
    select * from Marks
    where Marks.StudentId = Students.StudentId
    and Marks.Courseid = Courses.CourseId
    and Mark > 2
)
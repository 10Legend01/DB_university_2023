update Students set Marks =
(
    select count(distinct CourseId) from Marks where StudentId = Students.StudentId
)
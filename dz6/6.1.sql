select GroupId, CourseId from Groups, Courses where GroupId not in
(
    select GroupId from Students where Studentid not in
    (
        select Studentid from Marks
        where Courses.CourseId = Marks.CourseId
    )
)
select StudentId from Students where not exists
(
    select * from Plan where Students.GroupId = Plan.GroupId and LecturerId in
            (
                select LecturerId from Lecturers where LecturerName = :LecturerName
            )
    where StudentId not in
        (
            select StudentId from Marks where CourseId = LecturerCourses.CourseId
        )
)
select StudentId from Students where StudentId not in
(
    select StudentId from (
        select CourseId from Plan where LecturerId in
            (
                select LecturerId from Lecturers where LecturerName = :LecturerName
            )
    ) as LecturerCourses
    where StudentId not in
        (
            select StudentId from Marks where CourseId = LecturerCourses.CourseId
        )
)
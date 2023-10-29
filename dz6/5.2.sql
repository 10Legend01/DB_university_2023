select StudentId from Students where GroupId not in
(
    select GroupId from Plan
    where Students.StudentId in
    (
        select StudentId from Marks where Marks.CourseId = Plan.CourseId
    )
    and LecturerId in
    (
        select LecturerId from Lecturers where LecturerName = :LecturerName
    )
)
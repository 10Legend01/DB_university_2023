update Marks set Mark = coalesce(
    (
        select Mark
        from NewMarks
        where NewMarks.StudentId = Marks.StudentId and NewMarks.CourseId = Marks.CourseId
    ),
    Mark
)
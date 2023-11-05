update Marks set Mark = coalesce(
    (
        select case when Marks.Mark < NewMarks.Mark then NewMarks.Mark else Marks.Mark end
        from NewMarks
        where NewMarks.StudentId = Marks.StudentId and NewMarks.CourseId = Marks.CourseId
    ),
    Mark
)
insert into Marks select NewMarks.StudentId, NewMarks.CourseId, NewMarks.Mark
from NewMarks left join Marks
on NewMarks.StudentId = Marks.StudentId and NewMarks.CourseId = Marks.CourseId
where Marks.Mark is null
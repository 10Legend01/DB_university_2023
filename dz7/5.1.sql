create view StudentMarks(StudentId, Marks) as
select StudentId, count(Mark) from Students natural left join Marks group by StudentId
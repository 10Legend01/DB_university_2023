create view Debts(StudentId, Debts) as
select StudentId, count(distinct CourseId)
from Students natural join Plan natural left join Marks
where Mark is null
group by StudentId
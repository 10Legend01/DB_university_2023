create view AllMarks(StudentId, Marks) as
select StudentId, count(Mark)
from Students natural left join (select * from Marks union all select * from NewMarks) as UnionMarks
group by StudentId
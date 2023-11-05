delete from Students where StudentId in
(
    select distinct StudentId from Students natural join Plan natural left join Marks
    where Mark is null
)
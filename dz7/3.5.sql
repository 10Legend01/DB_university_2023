update Students set Debts =
(
    select count(distinct CourseId) from Students natural join Plan natural left join Marks
    where Mark is null and StudentId = :StudentId
)
where StudentId = :StudentId
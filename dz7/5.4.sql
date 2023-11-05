create view StudentDebts(StudentId, Debts) as
select StudentId, coalesce(cnt, 0) from Students natural left join
(
    select StudentId, count(distinct CourseId) as cnt
    from Students natural left join Plan natural left join Marks
    where Mark is null
    group by StudentId
) as res
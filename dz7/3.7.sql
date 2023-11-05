update Students as st set Debts =
(
    select count(distinct CourseId) from Students natural join Plan natural left join Marks
    where Mark is null and StudentId = st.StudentId
)
where GroupId in
(
    select GroupId from Groups where GroupName = :GroupName
)
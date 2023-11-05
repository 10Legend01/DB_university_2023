update Students as st set
Debts =
(
    select count(distinct CourseId) from Students natural join Plan natural left join Marks
    where Mark is null and StudentId = st.StudentId
),
Marks =
(
    select count(*) from Marks where StudentId = st.StudentId
)
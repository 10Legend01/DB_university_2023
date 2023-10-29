select StudentId from Marks
except
select StudentId from
(
    select StudentId, res1.CourseId from Marks cross join
    (
        select CourseId from Lecturers natural join Plan where LecturerName = :LecturerName
    ) as res1
    except
    select StudentId, CourseId from Marks
) as res2
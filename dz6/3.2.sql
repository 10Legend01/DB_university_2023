select StudentName, CourseName
from Students,
     Courses
where exists(select StudentId, CourseId
             from Marks
             where Marks.StudentId = Students.StudentId
               and Marks.Courseid = Courses.Courseid
             union
             select StudentId, CourseId
             from Plan
             where Plan.Groupid = Students.Groupid
               and Plan.Courseid = Courses.Courseid)
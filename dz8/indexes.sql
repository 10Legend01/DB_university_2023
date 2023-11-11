-- ДЗ-5.1.1. Информацию о студентах
-- c заданным идентификатором (:StudentId)
-- ДЗ-5.2.1. Полную информацию о студентах
-- c заданным идентификатором (:StudentId)
-- ДЗ-5.8.1. Суммарный балл одного студента (:StudentId)
-- Подойдет хэш индекс вместо упорядоченного индекса,
-- так как запросы происходят по точному значению:
-- StudentId = :StudentId
-- Без использования unique из-за особенностей некоторых диалектов,
-- например, PostgreSQL:
-- https://www.postgresql.org/docs/10/indexes-unique.html
-- "Currently, only B-tree indexes can be declared unique."
create index ix_students__student_id on Students using hash (StudentId);

-- ДЗ-5.1.2. Информацию о студентах с заданным ФИО (:StudentName)
-- ДЗ-5.2.2. Полную информацию о студентах
-- с заданным ФИО (:StudentName)
-- ДЗ-6.1.1. Информацию о студентах с заданным ФИО (:StudentName)
-- Хотим дополнительно использовать покрывающий индекс,
-- чтобы можно было получать StudentId, не обращаясь к таблице,
-- поэтому подходит только упорядоченный индекс.
create unique index ix_students__student_name__student_id on Students using btree (StudentName, StudentId);
-----------
create index ix_groups__group_id on Groups using hash (GroupId);
create index ix_groups__group_name on Groups using hash (GroupName);
create index ix_groups__group_name on Groups using btree (GroupName, GroupId) ;
-----------

-----------------
-- 2 задание
select avg(Mark) from Students natural join Marks
where GroupId in (
    select GroupId from Groups where GroupName = :GroupName
)
and CourseId in (
    select CourseId from Courses where CourseName = :CourseName
);

create index ix_marks__student_id on Marks using hash (StudentId);
create index ix_students__student_id on Students using hash (StudentId);
create index ix_groups__group_name on Groups using hash (GroupName);
create index ix_courses__course_name on Courses using hash (CourseName);

## 1. Запросы из предыдущих ДЗ
Для каждой таблицы укажите объявления индексов на языке SQL (create index, в одну строку). Перед каждым индексом в комментарии (--) укажите обоснование типа индекса и номера запросов, которые он ускорит в формате "ДЗ-X.Y.Z. Формулировка задания", по одному на строке. Если индекс ускоряет много запросов, достаточно указать три из них.

Между объявлением индекса и комментарием к следующему индексу оставьте пустую строку. Комментарии длиннее 70 символов разбивайте на несколько строк.

### 1.S. Индексы на таблицу Students
```sql
-- ДЗ-5.1.1. Информацию о студентах
-- c заданным идентификатором (:StudentId)
-- ДЗ-5.2.1. Полную информацию о студентах
-- c заданным идентификатором (:StudentId)
-- ДЗ-5.8.1. Суммарный балл одного студента (:StudentId)
-- Подойдет хэш индекс вместо упорядоченного индекса,
-- так как запросы происходят по точному значению:
-- StudentId = :StudentId
-- Без использования unique здесь и в других индексах с типом hash 
-- из-за особенностей некоторых диалектов, например, PostgreSQL:
-- https://www.postgresql.org/docs/10/indexes-unique.html
-- "Currently, only B-tree indexes can be declared unique."
create index ix_hash_students__student_id on Students using hash (StudentId);

-- ДЗ-5.1.2. Информацию о студентах с заданным ФИО (:StudentName)
-- ДЗ-5.2.2. Полную информацию о студентах
-- с заданным ФИО (:StudentName)
-- ДЗ-6.1.1. Информацию о студентах с заданным ФИО (:StudentName)
-- Подойдет хэш индекс вместо упорядоченного индекса,
-- так как запросы происходят по точному значению:
-- StudentName = :StudentName
create index ix_hash_students__student_name on Students using hash (StudentName);

-- ДЗ-6.2.1. Полную информацию о студентах
-- для всех студентов (StudentId, StudentName, GroupName).
-- ДЗ-6.3.1. Студенты и дисциплины, такие что у студента была 
-- дисциплина (по плану или есть оценка) 
-- Идентификаторы (StudentId, CourseId).
-- ДЗ-7.1.1 Напишите запросы, удаляющие студентов 
-- учащихся в группе, заданной идентификатором (GroupId).
-- Поиск по GroupId. Подойдет hash вместо btree,
-- т.к. запросы по точному значению: Students.GroupId = ...
create index ix_hash_students__group_id on Students using hash (GroupId);
```

### 1.G. Индексы на таблицу Groups
```sql
-- ДЗ-5.2.1 Полную информацию о студентах c заданным идентификатором. 
-- ДЗ-5.2.2 Полную информацию о студентах с заданным ФИО.
-- ДЗ-5.8.3 Суммарный балл каждой группы
-- Поиск по GroupId. Подойдет hash вместо btree,
-- т.к. запросы по точному значению: Groups.GroupId = ...
create index ix_hash_groups__group_id on Groups using hash (GroupId);

-- ДЗ-6.1.2 Информацию о студентах учащихся в заданной группе.
-- ДЗ-7.1.2 Напишите запросы, удаляющие студентов 
-- учащихся в группе, заданной названием (GroupName).
-- ДЗ-7.2.4 Напишите запросы, обновляющие данные студентов 
-- перевод всех студентов из группы в группу по названиям.
-- Поиск по GroupName. Частично покрывающий индекс для GroupId.
-- Покрывающий индекс не работает через hash, но - через btree.
create unique index ix_groups__group_name__group_id on Groups using btree (GroupName, GroupId);
```

### 1.C. Индексы на таблицу Courses
```sql
-- ДЗ-5.4.1 Информацию о студентах не имеющих оценки по дисциплине
-- среди всех студентов.
-- ДЗ-5.5.2 Для каждого студента ФИО и названия дисциплин 
-- есть, но у него нет оценки.
-- ДЗ-5.5.3 Для каждого студента ФИО и названия дисциплин 
-- есть, но у него не 4 или 5.
-- Поиск по CourseId. Подойдет hash вместо btree,
-- т.к. запросы по точному значению: Courses.CourseId = ...
create index ix_hash_courses__group_id on Courses using hash (CourseId);

-- ДЗ-6.1.4 Информацию о студентах 
-- с заданной оценкой по дисциплине, заданной названием.
-- ДЗ-6.2.3 Полную информацию о студентах
-- студентов, не имеющих оценки по дисциплине, заданной названием.
-- ДЗ-6.2.5 Полную информацию о студентах
-- студентов, не имеющих оценки по дисциплине, 
-- у которых есть эта дисциплина.
-- Поиск по CourseName. Частично покрывающий индекс для CourseId.
-- Покрывающий индекс не работает через hash, но - через btree.
create unique index ix_courses__group_name__group_id on Courses using btree (CourseName, CourseId);
```

### 1.L. Индексы на таблицу Lecturers
```sql
-- ДЗ-5.3.6 Информацию о студентах с заданной оценкой по дисциплине
-- которую вёл лектор, заданный ФИО.
-- ДЗ-5.6.1 Идентификаторы студентов по преподавателю
-- имеющих хотя бы одну оценку у преподавателя.
-- ДЗ-5.6.2 Идентификаторы студентов по преподавателю
-- не имеющих ни одной оценки у преподавателя.
-- Поиск по LecturerId. Подойдет hash вместо btree, т.к. запросы
-- по точному значению: Lecturers.LecturerId = ...
create index ix_hash_lecturers__lecturer_id on Lecturers using hash (LecturerId);

-- ДЗ-6.5.2 Идентификаторы студентов по преподавателю
-- не имеющих ни одной оценки у преподавателя.
-- ДЗ-6.5.3 Идентификаторы студентов по преподавателю
-- имеющих оценки по всем дисциплинам преподавателя.
-- ДЗ-6.5.4 Идентификаторы студентов по преподавателю
-- имеющих оценки по всем дисциплинам преподавателя, 
-- которые он вёл у этого студента.
-- Поиск по LecturerName. Частично покрывающий индекс для LecturerId.
-- Покрывающий индекс не работает через hash, но - через btree.
create unique index ix_lecturers__lecturer_name__lecturer_id on Lecturers using btree (LecturerName, LecturerId);
```

### 1.P. Индексы на таблицу Plan
```sql
-- ДЗ-5.3.3 Информацию о студентах с заданной оценкой по дисциплине
-- которую у них вёл лектор заданный идентификатором.
-- ДЗ-5.3.4 Информацию о студентах с заданной оценкой по дисциплине
-- которую у них вёл лектор, заданный ФИО.
-- ДЗ-5.6.1 Идентификаторы студентов по преподавателю
-- имеющих хотя бы одну оценку у преподавателя.
-- Возможен поиск в запросах по GroupId и затем по Courseid
-- Возможен поиск по GroupId 
-- и частично покрывающий индекс для Courseid.
create index ix_plans__group_id__course_id on Plan using btree (GroupId, Courseid);

-- ДЗ-5.3.3 Информацию о студентах с заданной оценкой по дисциплине
-- которую у них вёл лектор заданный идентификатором.
-- ДЗ-6.2.4 Полную информацию о студентах
-- студентов, не имеющих оценки по дисциплине, 
-- у которых есть эта дисциплина.
-- ДЗ-6.2.5 Полную информацию о студентах, 
-- не имеющих оценки по дисциплине, 
-- у которых есть эта дисциплина.
-- Возможен поиск в запросах по Courseid и затем по GroupId. 
-- Возможен поиск по CourseId 
-- и частично покрывающий индекс для GroupId.
create index ix_plans__course_id__group_id on Plan using btree (CourseId, GroupId);

-- ДЗ-5.6.3 Идентификаторы студентов по преподавателю
-- имеющих оценки по всем дисциплинам преподавателя.
-- Поиск по LecturerId. Частично покрывающий индекс для Courseid.
-- Покрывающий индекс не работает через hash, но - через btree.
create index ix_plans__lecturer_id__course_id on Plan using btree (LecturerId, Courseid);
```

### 1.M. Индексы на таблицу Marks
```sql
-- ДЗ-6.5.1 Идентификаторы студентов по преподавателю
-- имеющих хотя бы одну оценку у преподавателя.
-- ДЗ-6.6.1 Группы и дисциплины, такие что 
-- все студенты группы имеют оценку по предмету: Идентификаторы 
-- ДЗ-6.6.2 Группы и дисциплины, такие что 
-- все студенты группы имеют оценку по предмету: Названия
-- Поиск по CourseId и покрывающий индекс для StudentId.
-- Покрывающий индекс не работает через hash, но - через btree.
-- Возможен поиск по CourseId и StudentId.
create index ix_marks__course_id__student_id on Marks using btree (CourseId, StudentId);

-- ДЗ-5.9.1 Средний балл одного студента
-- ДЗ-5.9.2 Средний балл каждого студента
-- ДЗ-5.9.3 Средний балл каждой группы
-- Поиск по StudentId. Подойдет hash вместо btree, т.к. запросы
-- по точному значению: Marks.StudentId = ... 
create index ix_hash_marks__student_id on Marks using hash (StudentId);
```

## 2. Статистический запрос

### 2.Q. Запрос
```sql
select avg(Mark) from Students natural join Marks
where GroupId in (
    select GroupId from Groups where GroupName = :GroupName
)
and CourseId in (
    select CourseId from Courses where CourseName = :CourseName
);
```

### 2.I. Индексы
```sql
-- Ускоряет объединение Students и Marks по StudentId.
-- Достаточно hash вместо btree по точному запросу.
create index ix_hash_marks__student_id on Marks using hash (StudentId);

-- Ускоряет фильтрацию по GroupId. 
-- Достаточно hash вместо btree по точному запросу.
create index ix_hash_students__student_id on Students using hash (GroupId);

-- Ускоряет фильтрацию по CourseId.
-- Достаточно hash вместо btree по точному запросу.
create index ix_hash_marks__course_id on Marks using hash (CourseId);

-- Поиск по GroupName и покрывающий индекс для GroupId.
-- Покрывающий индекс не работает через hash, но - через btree.
create index ix_groups__group_name on Groups using btree (GroupName, GroupId);

-- Поиск по CourseName и покрывающий индекс для CourseId.
-- Покрывающий индекс не работает через hash, но - через btree.
create index ix_courses__course_name on Courses using btree (CourseName, CourseId);
```

## 3. Новые запросы
Перед запросом в комментарии (--) укажите, что он делает

Объявления индексов записываются в формате из раздела 1, без указания ускоряемого запроса. При удалении индекса укажите, почему он стал бесполезным в комментарии перед удалением.

### 3.1.Q. Запрос 1
```sql
-- Вывести студента и предмет, где оценка ниже :Mark
select StudentId, CourseId from Marks where Mark < :Mark
```

### 3.1.I. Дополнительные индексы для запроса 1
```sql
-- Индекс с использованием btree для поиска в диапазоне
-- Поиск по Mark, покрывающий индекс для StudentId и CourseId
create index ix_marks__mark__student_id__course_id on Marks using btree (Mark, StudentId, CourseId);
```

### 3.2.Q. Запрос 2
```sql
-- Вывести id всех групп, которые проходят курс лектора 
-- (GroupId по :CourseName, :LecturerName)
select GroupId from Plan 
where CourseId in 
(
    select CourseId from Courses where CourseName = :CourseName
)
and LecturerId in
(
    select LecturerId from Lecturers where LecturerName = :LecturerName
)
```

### 3.2.I. Дополнительные индексы для запроса 2
```sql
-- Индекс для поиска по CourseId и LecturerId 
-- и покрывающий индекс для GroupId
create index ix_plans__course_id__lecturer_id__group_id on Plan using btree (CourseId, LecturerId, GroupId);
```

### 3.3.Q. Запрос 3
```sql
-- Вывести id студентов, которые находятся внутри диапазона 
-- (StudentId по :StudentIdLeft, :StudentIdRight)  
select StudentId from Students 
where :StudentIdLeft <= StudentId and StudentId <= :StudentIdRight 
```

### 3.3.I. Дополнительные индексы для запроса 3
```sql
-- Поиск по StudentId в диапазоне. Например, поиск студентов в ИСУ.
-- Диапазон работает только с btree.
create index ix_students__student_id on Students using btree (StudentId);
```
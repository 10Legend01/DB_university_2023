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
-- Без использования unique из-за особенностей некоторых диалектов,
-- например, PostgreSQL:
-- https://www.postgresql.org/docs/10/indexes-unique.html
-- "Currently, only B-tree indexes can be declared unique."
create index ix_students__student_id on Students using hash (StudentId);

-- ДЗ-5.1.2. Информацию о студентах с заданным ФИО (:StudentName)
-- ДЗ-5.2.2. Полную информацию о студентах
-- с заданным ФИО (:StudentName)
-- ДЗ-6.1.1. Информацию о студентах с заданным ФИО (:StudentName)
-- Подойдет хэш индекс вместо упорядоченного индекса,
-- так как запросы происходят по точному значению:
-- StudentName = :StudentName
create index ix_students__student_name on Students using hash (StudentName);
```

### 1.G. Индексы на таблицу Groups
```sql
create index ix_groups__group_id on Groups using hash (GroupId);
create index ix_groups__group_name on Groups using hash (GroupName);
create index ix_groups__group_name on Groups using btree (GroupName, GroupId);
```

### 1.C. Индексы на таблицу Courses
```sql

```

### 1.L. Индексы на таблицу Lecturers
```sql

```

### 1.P. Индексы на таблицу Plan
```sql

```

### 1.M. Индексы на таблицу Marks
```sql

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
create index ix_marks__student_id on Marks using hash (StudentId);
create index ix_students__student_id on Students using hash (StudentId);
create index ix_groups__group_name on Groups using hash (GroupName);
create index ix_courses__course_name on Courses using hash (CourseName);
```

## 3. Новые запросы
Перед запросом в комментарии (--) укажите, что он делает

Объявления индексов записываются в формате из раздела 1, без указания ускоряемого запроса. При удалении индекса укажите, почему он стал бесполезным в комментарии перед удалением.

### 3.1.Q. Запрос 1
```sql

```

### 3.1.I. Дополнительные индексы для запроса 1
```sql

```

### 3.2.Q. Запрос 2
```sql

```

### 3.2.I. Дополнительные индексы для запроса 2
```sql

```

### 3.3.Q. Запрос 3
```sql

```

### 3.3.I. Дополнительные индексы для запроса 3
```sql

```
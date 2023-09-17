### 0. Диаграммы ERM и PDM
Картинка размером не больше 1920x1080. 
В левой половине — ERM. В правой — PDM. 
Для удобства чтения таблицы должны находиться на тех же местах, что и сущности/связи/ассоциации, из которых они получены. 
Рекомендуется использовать прямые линии (а не дуги) и избегать пересечений.


### 1. Модель сущность-связь

1.0 Нотация <br>
Укажите тип используемой нотации, в том числе (не)обязательность по умолчанию для атрибутов и связей.
```text
Нотация - Crow's foot. 
Из-за ограничений drawio переделаны правила обозначений:
- Слабая сущность обозначается широкой полупрозрачной обводкой (вместо двойной границы)
- Идентифицирующая связь обозначается тройной сплошной линией (вместо двойной сплошной линии)

По умолчанию связь - одна необязательная.
```

1.1. Сущности и атрибуты <br>
Опишите выделенные сущности (в том числе, слабые), их атрибуты
```text
1) Человек - сущность, описывающая персону, имеющую номер в системе ИСУ университета.
- person_id - Номер ИСУ.
- first_name - Имя.
- last_name - Фамилия.
- patronymic - Отчество, опциональный аттрибут.
2) Студент - слабая сущность, идентификация от сущности "человек". Студент в университете.
3) Преподаватель - слабая сущность, идентификация от сущности "человек". Преподаватель в университете.
4) Группа - группа в университете.
- group_id - случайный идентификатор.
- name - уникальное имя группы. Например, "M34391"
- year - год начала обучения группы.
5) Имя дисциплины - сущность, содержащее только имена дисциплин.
- subject_name_id - случайный идентификатор
- name - имя дисциплины
6) Дисциплина - слабая сущность. Дисциплина для конкретной группы.
- subject_id - случайный идентификатор
- semester - указание семестра для многосеместровых дисциплин. Опциональный атрибут.
```

1.2. Связи и ассоциации <br>
Опишите выделенные связи и ассоциации
```text
Ассоциации:
1) Оценка - оценка студента по определенному предмету.

Связи:
1) Студент-группа - Текущая или крайняя группа, в которой студент обучается(лся).
2) Студент-оценка - Оценка какого студента.
3) Дисциплина-оценка - Оценка по какой дисциплине.
4) Дисциплина-группа - Дисциплина для какой группы и какого года обучения.
5) Дисциплина-преподаватель - Кто из преподавателей преподаёт(вал) эту дисциплину. 
6) Дисциплина-имя дисциплины - как называется эта дисциплина.
7) Студент-человек - данные по студенту.
8) Преподаватель-человек - данные по преподавателю.
```

______________

### 2. Физическая модель

2.0. Нотация <br>
Укажите тип используемой нотации, в том числе (не)обязательность по умолчанию для столбцов
```text
Обычный тип нотаций для физической модели БД. По умолчанию поля необязательны.
```

2.1. Домены <br>
Опишите преобразование доменов, по одному на строке в формате  «домен → тип» .

В этом и последующем домашнем задании:
- кавычки не являются частью синтаксиса
- можно вместо «→» использовать «->».

Например
- hello_world_message -> char(12)
- hello_world_index -> numeric(3)
```text
isu_id -> int
id -> int
name -> varchar(100)
str -> varchar(100)
year -> int
int -> int
value_grade -> numeric(5, 2)
```

2.2. Преобразование <br>
Опишите особенности преобразования (в частности, для слабых сущностей и ассоциаций)
```text
1) Слабая сущность "Студент" -> таблица "student":
- идентифицирующая связь студент-человек -> создание ключевого столбца student.student_id внешней ссылкой на person.isu_id
- связь студент-группа -> создание столбца student.current_group_id внешней ссылкой на group_university.group_id

2) Слабая сущность "Преподаватель" -> таблица "teacher":
- идентифицирующая связь преподаватель-человек -> создание ключевого столбца teacher.teacher_id внешней ссылкой на person.isu_id

3) Слабая сущность "Дисциплина" -> таблица "subject":
- связь дисциплина-преподаватель -> создание столбца subject.teacher_id внешней ссылкой на teacher.teacher_id
Ключевые столбцы, связанные с ключевым столбцом semester, образующие составной ключ:
- идентифицирующая связь дисциплина-группа -> создание ключевого столбца subject.group_id внешней ссылкой на group_university.group_id
- идентифицирующая связь дисциплина-имя дисциплины -> создание ключевого столбца subject.subject_name_id внешней ссылкой на subject_name.subject_name_id

4) Ассоциация "Оценка" -> Таблица "grade"
Ключевые столбцы, образующие составной ключ:
- связь оценка-дисциплина -> создание ключевого столбца grade.subject_id внешней ссылкой на subject.subject_id
- связь оценка-студент -> создание ключевого столбца grade.student_id внешней ссылкой на student.student_id
```

### 3. SQL <br>
Помните, что SQL – это язык программирования, и не забывайте о форматировании и отступах

3.1. DDL <br>
Схема базы данных
```postgresql
create table person (
    isu_id int not null,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    patronymic varchar(100),
    check ( isu_id >= 0 ),
    check ( length(first_name) >= 1 ),
    check ( length(last_name) >= 1 ),
    check ( patronymic is null or length(patronymic) >= 1 ),
    primary key (isu_id)
);

create table group_university (
    group_id int not null,
    name varchar(100) not null,
    year int not null,
    primary key (group_id),
    unique (name, year)
);

create table student (
    student_id int not null,
    current_group_id int not null,
    primary key (student_id),
    foreign key (student_id) references person(isu_id),
    foreign key (current_group_id) references group_university(group_id)
);

create table teacher (
    teacher_id int not null,
    primary key (teacher_id),
    foreign key (teacher_id) references person(isu_id)
);

create table subject_name (
    subject_name_id int not null,
    name varchar(100) not null,
    check ( length(name) >= 1 ),
    primary key (subject_name_id),
    unique (name)
);

create table subject (
    subject_id int not null,
    subject_name_id int not null,
    group_id int not null,
    teacher_id int not null,
    semester int,
    check (semester is null or (1 <= semester and semester <= 12)),
    primary key (subject_id),
    unique (subject_name_id, group_id, semester),
    foreign key (subject_name_id) references subject_name(subject_name_id),
    foreign key (group_id) references group_university(group_id),
    foreign key (teacher_id) references teacher(teacher_id)
);

create table grade (
    subject_id int not null,
    student_id int not null,
    value numeric(5, 2) not null,
    check (0 <= value and value <= 100),
    primary key (subject_id, student_id),
    foreign key (subject_id) references subject(subject_id),
    foreign key (student_id) references student(student_id)
);
```

3.2. DML <br>
Пример тестовых данных. Достаточно 2-3 записей на таблицу, если они в полной мере демонстрируют особенности БД.

Для удобства чтения данные должны быть записаны в том же порядке, что и в схеме.
```postgresql
insert into person
    (isu_id, first_name, last_name, patronymic) values
    (311645, 'Михаил', 'Назаров', null),
    (152885, 'Аксенов', 'Виталий', 'Евгеньевич'),
    (105590, 'Георгий', 'Корнеев', 'Александрович');

insert into group_university
    (group_id, name, year) values
    (1, 'M32361', 2020),
    (2, 'M34341', 2020);

insert into student
    (student_id, current_group_id) values
    (311645, 2);

insert into teacher
    (teacher_id) values
    (152885),
    (105590);

insert into subject_name
    (subject_name_id, name) values
    (1, 'Дополнительные главы алгоритмов и структур данных'),
    (2, 'Проектирование баз данных');

insert into subject
    (subject_id, subject_name_id, group_id, teacher_id, semester) values
    (1, 1, 1, 152885, 3),
    (2, 1, 1, 152885, 4),
    (3, 2, 2, 105590, null);

insert into grade
    (subject_id, student_id, value) values
    (1, 311645, 100),
    (2, 311645, 72.45),
    (3, 311645, 0);
```

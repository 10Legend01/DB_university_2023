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

insert into group_university
    (group_id, group_name) values
    (1, 'M32361'),
    (2, 'M34341');

insert into student
    (student_id, student_name, group_id) values
    (311645, 'Назаров Михаил Александрович', 2);

insert into lecturer
    (lecturer_id, lecturer_name) values
    (152885, 'Аксенов Виталий Евгеньевич'),
    (242347, 'Орешников Даниил Михайлович'),
    (105590, 'Корнеев Георгий Александрович');

insert into course
    (course_id, course_name) values
    (1, 'Дополнительные главы алгоритмов и структур данных'),
    (2, 'Проектирование баз данных');

insert into course_lecturer_of_group
    (group_id, course_id, lecturer_id) values
    (2, 1, 152885),
    (1, 1, 152885),
    (2, 2, 105590);

insert into mark
    (student_id, course_id, mark) values
    (311645, 1, 72.45),
    (311645, 2, 20);

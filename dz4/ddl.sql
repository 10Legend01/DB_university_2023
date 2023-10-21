create table group_university (
    group_id int not null,
    group_name varchar(100) not null,
    primary key (group_id),
    unique (group_name)
);

create table student (
    student_id int not null,
    student_name varchar(100) not null,
    group_id int not null,
    primary key (student_id),
    foreign key (group_id) references group_university(group_id)
);

create table lecturer (
    lecturer_id int not null,
    lecturer_name varchar(100) not null,
    primary key (lecturer_id)
);

create table course (
    course_id int not null,
    course_name varchar(100) not null,
    primary key (course_id)
);

create table course_lecturer_of_group (
    group_id int not null,
    course_id int not null,
    lecturer_id int not null,
    primary key (group_id, course_id),
    foreign key (group_id) references group_university(group_id),
    foreign key (course_id) references course(course_id),
    foreign key (lecturer_id) references lecturer(lecturer_id)
);

create table mark (
    student_id int not null,
    course_id int not null,
    mark numeric(5, 2) not null,
    primary key (student_id, course_id),
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id)
);

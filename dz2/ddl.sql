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

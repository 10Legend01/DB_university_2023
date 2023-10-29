create table Groups (
    GroupId int not null,
    GroupName varchar(100) not null,
    primary key (GroupId),
    unique (GroupName)
);

create table Students (
    StudentId int not null,
    StudentName varchar(100) not null,
    GroupId int not null,
    primary key (StudentId)
);

create table Courses (
    CourseId int not null,
    CourseName varchar(100) not null,
    primary key (CourseId)
);

create table Lecturers (
    LecturerId int not null,
    LecturerName varchar(100) not null,
    primary key (LecturerId)
);

create table Plan (
    GroupId int not null,
    CourseId int not null,
    LecturerId int not null,
    PRIMARY KEY (GroupId, CourseId, LecturerId)
);

create table Marks (
    StudentId int not null,
    CourseId int not null,
    Mark int not null,
    primary key (StudentId, CourseId)
);

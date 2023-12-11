drop table if exists Teams cascade;
create table Teams (
    TeamId int not null,
    TeamName varchar(100) not null,
    primary key (TeamId)
);

drop table if exists Contests cascade;
create table Contests (
    ContestId int not null,
    ContestName varchar(100) not null,
    primary key (ContestId)
);

drop table if exists Sessions cascade;
create table Sessions (
    SessionId int not null,
    Start timestamp not null,
    ContestId int not null,
    TeamId int not null,
    primary key (SessionId),
    foreign key (ContestId) references Contests(ContestId),
    foreign key (TeamId) references Teams(TeamId)
);

drop table if exists Problems cascade;
create table Problems (
    Letter char(1) not null,
    ProblemName varchar(100) not null,
    ContestId int not null,
    primary key (Letter, ContestId),
    foreign key (ContestId) references Contests(ContestId)
);

drop table if exists Runs cascade;
create table Runs (
    RunId int not null,
    SubmitTime int not null,
    Accepted int not null,
    Letter char(1) not null,
    ContestId int not null,
    SessionId int not null,
    primary key (RunId),
    foreign key (Letter, ContestId) references Problems(Letter, ContestId),
    foreign key (SessionId) references Sessions(SessionId)
);

insert into Teams
    (TeamId, TeamName)
values (1, 'Ones'),
       (2, 'M34391'),
       (3, 'Гоша ран');

insert into Contests
    (ContestId, ContestName)
values (1, 'ICPC'),
       (2, 'ИОИП');

insert into Sessions
    (SessionId, Start, ContestId, TeamId)
values (1, '10.10.2020 11:00'::timestamp, 1, 1),
       (2, '10.10.2020 12:00'::timestamp, 1, 2),
       (3, '10.10.2021 11:00'::timestamp, 2, 2),
       (4, '10.10.2021 10:00'::timestamp, 2, 3);


insert into Problems
    (Letter, ProblemName, ContestId)
values ('A', 'Got It', 1),
       ('B', 'Put It', 1),
       ('A', 'Не подглядывай', 2),
       ('B', 'ЭЩКЕРЕ', 2);

insert into Runs
    (RunId, SubmitTime, Accepted, Letter, ContestId, SessionId)
values (1, 10, 0, 'A', 1, 1),
       (2, 20, 1, 'A', 1, 1),
       (3, 30, 1, 'B', 1, 1),
       (4, 10, 1, 'B', 1, 2),
       (6, 15, 0, 'B', 2, 3),
       (7, 5, 0, 'A', 1, 4);
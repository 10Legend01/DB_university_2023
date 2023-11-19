create table Flights (
    FlightId int not null,
    FlightTime timestamp not null,
    PlaneId integer not null,
    CanOrder boolean not null default true,
    primary key (FlightId),
    unique (FlightId, PlaneId)
);

create table Seats (
    SeatId int not null,
    PlaneId int not null,
    SeatNo varchar(4) not null,
    primary key (SeatId),
    unique (PlaneId, SeatNo),
    unique (SeatId, PlaneId)
);

create table Users (
    UserId integer not null,
    Pass varchar(256) not null,
    primary key (UserId)
);

create type order_type as enum ('book', 'buy');

create table Orders (
    OrderId int not null generated always as identity,
    FlightId int not null,
    PlaneId int not null,
    SeatId int not null,
    UserId int,
    OrderType order_type not null,
    CreatedAt timestamp not null default now(),
    primary key (OrderId),
    unique (FlightId, SeatId),
    foreign key (FlightId, PlaneId) references Flights(FlightId, PlaneId),
    foreign key (SeatId, PlaneId) references Seats(SeatId, PlaneId),
    foreign key (UserId) references Users(UserId)
);

create unique index if not exists orders_flightid_seatid_key on Orders (FlightId, SeatId);

-- Таблица рейсов. Поле CanOrder отвечает за возможность делать брони и покупки.
create table Flights (
    FlightId int not null,
    FlightTime timestamp not null,
    PlaneId integer not null,
    CanOrder boolean not null default true,
    primary key (FlightId),
    unique (FlightId, PlaneId)
);

-- таблица мест в самолетах
create table Seats (
    SeatId int not null,
    PlaneId int not null,
    SeatNo varchar(4) not null,
    primary key (SeatId),
    unique (PlaneId, SeatNo),
    unique (SeatId, PlaneId)
);

-- Таблица пользователей
create table Users (
    UserId integer not null,
    Pass varchar(256) not null,
    primary key (UserId)
);

-- Енум для таблицы заказов
create type order_type as enum ('book', 'buy');

-- Таблица заказов. Можно заказать бронь, можно заказать покупку билета.
-- Примечание: столбец PlaneId имеет foreign key на таблицы рейсов и мест самолетов,
-- таким образом гарантируется: Flights.PlaneId = Seats.PlaneId
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

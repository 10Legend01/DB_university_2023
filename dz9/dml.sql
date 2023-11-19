create or replace function create_datetime(add interval)
    returns timestamp
    language plpgsql as
$$
begin
    return now() + create_datetime.add;
end;
$$;

insert into Flights
    (flightid, flighttime, planeid)
VALUES (1, create_datetime('4 days'), 1),
       (2, create_datetime('2 days'), 1),
       (3, create_datetime('3 hours'), 2),
       (4, create_datetime('4 days'), 3);

insert into Seats
    (seatid, planeid, seatno)
values (1, 1, '123A'),
       (2, 1, '123B'),
       (3, 2, '123A'),
       (4, 2, '123B'),
       (5, 2, '123C'),
       (6, 3, '123A'),
       (7, 4, '123A'),
       (8, 4, '123C');

insert into Users
    (userid, pass)
values (1, '1234'),
       (2, '1234'),
       (3, '1234'),
       (4, '1234');

insert into Orders
    (flightid, seatid, planeid, userid, ordertype)
values (1, 1, 1, 1, 'book');

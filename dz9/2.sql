create or replace function Reserve(UserId int, Pass varchar(256), FlightId int, SeatNo varchar(4))
returns boolean as
$$
declare
    SI int;
    PI int;
begin
    if (
        not authorize(Reserve.UserId, Reserve.Pass)
        or Reserve.SeatNo not in (select FreeSeats(Reserve.FlightId))
    ) then return false; end if;
    select Seats.SeatId, Seats.PlaneId into SI, PI from Seats
    where Seats.SeatNo = Reserve.SeatNo and Seats.PlaneId = (
        select Flights.PlaneId from Flights
        where Flights.FlightId = Reserve.FlightId
    );
    if (SI is null) then return false; end if;
    insert into Orders(FlightId, PlaneId, SeatId, UserId, OrderType)
        values (Reserve.FlightId, PI, SI, Reserve.UserId, 'book')
        on conflict on constraint orders_flightid_seatid_key
            do update set UserId = Reserve.UserId, CreatedAt = now();
    return true;
end
$$ language plpgsql;

select Reserve(1, '123', 1, '123A');

select Reserve(1, '1234', 1, '123A');

select Reserve(1, '1234', 1, '123B');

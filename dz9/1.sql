create or replace function FreeSeats(FlightId int)
returns table(SeatNo varchar(4)) as
$$
declare
    FT timestamp;
    CO boolean;
    PI int;
begin
    select FlightTime, CanOrder, PlaneId into FT, CO, PI from Flights where Flights.FlightId = FreeSeats.FlightId;
    if (FT < now() + interval '3 days' or CO = false) then return;
    end if;
    return query
    select Seats.SeatNo from Seats where Seats.PlaneId = PI and Seats.SeatId not in (
        select Orders.SeatId from Orders
        where Orders.FlightId = FreeSeats.FlightId
        and not book_is_expired(Orders.CreatedAt)
    );
end;
$$ language plpgsql;

select FreeSeats(1);

select FreeSeats(2);

select FreeSeats(3);

select FreeSeats(4);
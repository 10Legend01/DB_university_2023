create or replace function ExtendReservation(UserId int, Pass varchar(256), FlightId int, SeatNo varchar(4))
returns boolean as
$$
declare OI int;
begin
    if (not authorize(ExtendReservation.UserId, ExtendReservation.Pass)
        or not is_on_order(ExtendReservation.FlightId))
    then return false;
    end if;
    select Orders.OrderId into OI from Orders where Orders.FlightId = ExtendReservation.FlightId
        and Orders.SeatId = get_seat_id_by_flight_id_and_seat_no(
            ExtendReservation.FlightId, ExtendReservation.SeatNo
        )
        and Orders.UserId = ExtendReservation.UserId
        and now() + interval '3 days' < (
            select FlightTime from Flights where Flights.FlightId = ExtendReservation.FlightId
        );
    if (OI is null) then return false; end if;
    update Orders set CreatedAt = now() where Orders.OrderId = OI;
    return true;
end;
$$ language plpgsql;

select ExtendReservation(1, '1234', 1, '123A');

select ExtendReservation(1, '1234', 1, '123B');

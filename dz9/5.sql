create or replace function BuyReserved(UserId int, Pass varchar(256), FlightId int, SeatNo varchar(4))
returns boolean as
$$
declare OI int;
begin
    if (not authorize(BuyReserved.UserId, BuyReserved.Pass)
        or not is_on_order(BuyReserved.FlightId))
    then return false;
    end if;
    select Orders.OrderId into OI from Orders where Orders.FlightId = BuyReserved.FlightId
        and Orders.SeatId = get_seat_id_by_flight_id_and_seat_no(
            BuyReserved.FlightId, BuyReserved.SeatNo
        )
        and Orders.UserId = BuyReserved.UserId
        and Orders.OrderType = 'order'
        and now() + interval '3 hours' < (
            select FlightTime from Flights where Flights.FlightId = BuyReserved.FlightId
        );
    if (OI is null) then return false;
    end if;
    update Orders set CreatedAt = now(), OrderType = 'buy' where Orders.OrderId = OI;
    return true;
end;
$$ language plpgsql;

select BuyReserved(1, '1234', 1, '123A');

select BuyReserved(1, '1234', 1, '123B');

create or replace function BuyFree(FlightId int, SeatNo varchar(4))
returns boolean as
$$
declare OI int;
declare SI int;
declare PI int;
begin
    if (now() + interval '3 hours' > (
            select FlightTime from Flights where Flights.FlightId = BuyFree.FlightId
        )
        or not is_on_order(BuyFree.FlightId))
    then return false;
    end if;
    select Seats.SeatId, Seats.PlaneId into SI, PI from Seats
    where Seats.SeatNo = BuyFree.SeatNo and Seats.PlaneId = (
        select Flights.PlaneId from Flights
        where Flights.FlightId = BuyFree.FlightId
    );
    if (SI is null) then return false; end if;
    select Orders.OrderId into OI from Orders
        where Orders.FlightId = BuyFree.FlightId
          and Orders.SeatId = SI
          and now() < Orders.CreatedAt + interval '3 days';
    if (OI is not null) then return false; end if;
    insert into Orders(FlightId, PlaneId, SeatId, UserId, OrderType)
        values (BuyFree.FlightId, PI, SI, null, 'buy')
        on conflict on constraint orders_flightid_seatid_key
            do update set UserId = null, OrderType = 'buy', CreatedAt = now();
    return true;
end;
$$ language plpgsql;

select BuyFree(1, '123A');

select BuyFree(1, '123B');

create or replace function FlightStat(UserId int, Pass varchar(256), FlightId int)
returns table(CanBook boolean, CanBuy boolean, Free int, Booked int, Sold int) as
$$
declare FT timestamp;
declare PI int;
declare CO boolean;
declare CanBook boolean;
declare CanBuy boolean;
declare FreeCount int;
declare BookedCount int;
declare SoldCount int;
begin
    select FlightTime, PlaneId, CanOrder into FT, PI, CO from Flights where Flights.FlightId = FlightStat.FlightId;
    select
        coalesce(sum(case when Orders.OrderType = 'book'
            and not book_is_expired(Orders.CreatedAt) then 1 else 0 end), 0),
        coalesce(sum(case when Orders.OrderType = 'buy' then 1 else 0 end), 0)
        into BookedCount, SoldCount
        from Orders where Orders.FlightId = FlightStat.FlightId;
    FreeCount := (select count(Seats.SeatId) from Seats where Seats.PlaneId = PI) - BookedCount - SoldCount;
    CanBuy := FreeCount > 0 and now() + interval '3 hours' < FT;

    if (not authorize(FlightStat.UserId, FlightStat.Pass)
        or not CO)
    then
        return query (select false, CanBuy and CO, FreeCount, BookedCount, SoldCount);
        return;
    end if;
    CanBuy := CanBuy or exists(
        select OrderId from Orders
        where Orders.Flightid = FlightStat.FlightId
        and Orders.UserId = FlightStat.UserId
        and not book_is_expired(Orders.CreatedAt)
    );
    CanBook := FreeCount > 0 and now() + interval '3 days' < FT;
    return query (select CanBook, CanBuy, FreeCount, BookedCount, SoldCount);
end;
$$ language plpgsql;

select FlightStat(1, '1233', 1);

select FlightStat(1, '1234', 2);

create or replace procedure CompressSeats(FlightId int) as
$$
declare
    SI int;
    all_cur cursor for
        select Seats.SeatId from Seats where Seats.PlaneId = (
            select PlaneId from Flights where Flights.FlightId = CompressSeats.FlightId
        )
        order by SeatNo;
    buy_cur cursor for
        select * from Orders
        where Orders.FlightId = CompressSeats.FlightId and Orders.OrderType = 'buy';
    book_cur cursor for
        select * from Orders
        where Orders.FlightId = CompressSeats.FlightId
        and Orders.OrderType = 'book'
        and not book_is_expired(Orders.CreatedAt);
begin
    delete from Orders
    where Orders.FlightId = CompressSeats.FlightId
    and Orders.OrderType = 'book'
    and book_is_expired(Orders.CreatedAt);

    drop table if exists Temp;
    create temporary table Temp (
        FlightId int not null,
        PlaneId int not null,
        SeatId int not null,
        UserId int,
        OrderType order_type not null,
        CreatedAt timestamp not null
    );
    open all_cur;
    for buy_it in buy_cur loop
        fetch all_cur into SI;
        insert into Temp(FlightId, PlaneId, SeatId, UserId, OrderType, CreatedAt)
        values (buy_it.FlightId, buy_it.PlaneId, SI, buy_it.UserId, 'buy', buy_it.CreatedAt);
    end loop;
    for book_it in book_cur loop
        fetch all_cur into SI;
        insert into Temp(FlightId, PlaneId, SeatId, UserId, OrderType, CreatedAt)
        values (book_it.FlightId, book_it.PlaneId, SI, book_it.UserId, 'book', book_it.CreatedAt);
    end loop;
    delete from Orders where Orders.FlightId = CompressSeats.FlightId;
    insert into Orders (FlightId, PlaneId, SeatId, UserId, OrderType, CreatedAt) select * from Temp;
end
$$ language plpgsql;

call CompressSeats(1);

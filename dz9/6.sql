create or replace function FlightsStatistics(UserId int, Pass varchar(256))
returns table(FlightId int, CanBook boolean, CanBuy boolean, Free int, Booked int, Sold int) as
$$
begin
    return query (
        select Flights.FlightId, stat.CanBook, stat.CanBuy, stat.Free, stat.Booked, stat.Sold
        from Flights, FlightStat(UserId, Pass, Flights.FlightId) as stat
    );
end;
$$ language plpgsql;

select FlightsStatistics(1, '123');

select FlightsStatistics(1, '1234');

select FlightsStatistics(3, '1234');

select FlightsStatistics(4, '1234');

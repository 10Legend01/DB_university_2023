-- Включает возможность бронирования и покупок мест
create or replace procedure on_order(FlightId int) as
$$
begin
    update Flights set CanOrder = true where FlightId = on_order.FlightId and CanOrder = false;
end;
$$ language plpgsql;

-- Отключает возможность бронирования и покупок мест
create or replace procedure off_order(FlightId int) as
$$
begin
    update Flights set CanOrder = false where FlightId = off_order.FlightId and CanOrder = true;
end;
$$ language plpgsql;

-- авторизация пользователя. Возвращает true, если авторизация успешна
create or replace function authorize(UserId int, Pass varchar(256))
    returns boolean as
$$
begin
    return exists(select Users.UserId from Users where Users.UserId = authorize.UserId and Users.Pass = authorize.Pass);
end;
$$ language plpgsql;

-- регистрация пользователя
create or replace procedure registration(UserId int, Pass varchar(256)) as
$$
begin
    insert into Users values (registration.UserId, registration.Pass);
end;
$$ language plpgsql;

-- получение id места по id рейса и номеру места
create or replace function get_seat_id_by_flight_id_and_seat_no(FlightId int, SeatNo varchar(4)) returns int as
$$
begin
    return (
        select Seats.SeatId from Seats
        where Seats.SeatNo = get_seat_id_by_flight_id_and_seat_no.SeatNo
        and Seats.PlaneId = (
            select Flights.PlaneId from Flights
            where Flights.FlightId = get_seat_id_by_flight_id_and_seat_no.FlightId
        )
    );
end;
$$ language plpgsql;

-- Проверка, что не отключена возможность бронировать и покупать места
create or replace function is_on_order(FlightId int) returns boolean as
$$
begin
    return exists(select 1 from Flights where Flights.FlightId = is_on_order.FlightId and CanOrder = true);
end;
$$ language plpgsql;

-- проверка, что бронь истекла
create or replace function book_is_expired(CreatedAt timestamp) returns boolean as
$$
begin
    return book_is_expired.CreatedAt + interval '3 days' < now();
end;
$$ language plpgsql;

-- проверка, что самолет уже улетел
create or replace function plane_took_off(FlightTime timestamp) returns boolean as
$$
begin
    return now() < plane_took_off.FlightTime;
end;
$$ language plpgsql;

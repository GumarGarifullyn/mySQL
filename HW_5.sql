DROP DATABASE IF EXISTS home_Work_5;
CREATE DATABASE IF NOT EXISTS home_Work_5;

USE home_Work_5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    model VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
create view carsCopy as
select * from cars
where cost <= 25000;

select * from carsCopy;


-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

ALTER VIEW carsCopy as
select * from cars
where cost <= 30000;

select * from carsCopy;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

create view carsCopy2 as
select * from cars
where model in ('Skoda','Audi');

select * from carsCopy2;

-- Доп задания:
-- 1* Получить ранжированный список автомобилей по цене в порядке возрастания
select dense_rank() over(order by cost desc) as rank1,
model, cost from cars;

-- 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость

select dense_rank() over(order by cost desc) as rank1,
model, cost, SUM(cost) OVER() from cars
ORDER BY cost DESC
LIMIT 3;

SELECT SUM(cost) from 
(select dense_rank() over(order by cost desc) as rank1,
model, cost from cars
LIMIT 3) as newTable;

-- 3* Получить список автомобилей, у которых цена больше предыдущей цены (т.е. у которых произошло повышение цены)

-- 4* Получить список автомобилей, у которых цена меньше следующей цены (т.е. у которых произойдет снижение цены)

-- 5*Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля
/* 
1. Используя операторы языка SQL, 
создайте таблицу “sales”. Заполните ее данными.
Справа располагается рисунок к первому заданию.
 */


DROP DATABASE IF EXISTS Home_work_2;
CREATE DATABASE IF NOT EXISTS Home_work_2;

USE Home_work_2;

DROP TABLE IF EXISTS sales;
CREATE TABLE IF NOT EXISTS `sales`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`order_date` date,
`count_product` int
);

INSERT INTO `sales` (`order_date`, `count_product`)
VALUES
('2022-01-01', 156), 
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

select * from sales;

/*
2.  Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ
*/

SELECT id as "id заказа", 
	CASE
		WHEN count_product > 0 AND count_product < 100 THEN "Маленький заказ"
		WHEN count_product >= 100 AND count_product < 300 THEN "Средний заказ"
        WHEN count_product >= 300 THEN "Большой заказ"
	END as "Тип заказа"
FROM sales;

/*
3. Создайте таблицу “orders”, заполните ее значениями
*/

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS `orders`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`employee_id` varchar(10),
`amount` double,
`order_status` varchar(20)
);

INSERT INTO `orders` (`employee_id`, `amount`, `order_status`)
VALUES
('e03', 15.00, 'OPEN'), 
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

select * from orders;
/*
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»
*/

SELECT employee_id, amount, order_status,
	CASE
		WHEN order_status = "OPEN" THEN "Order is in open state"
		WHEN order_status = "CLOSED" THEN "Order is closed"
        WHEN order_status = "CANCELLED" THEN "Order is cancelled"
	END as "full_order_status"
FROM orders;

/*
4. Чем 0 отличается от NULL?
Напишите ответ в комментарии к домашнему заданию на платформе
*/

-- NULL - это отсутствие любого значения, фактически это полностью пустая ячейка
-- "0" - это значение типа данных INT, поэтому ячейка "заполнена" и данное значение можно использовать и обращаться к нему
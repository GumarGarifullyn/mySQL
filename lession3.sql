DROP DATABASE IF EXISTS lesson3;
CREATE DATABASE IF NOT EXISTS lesson3;

USE lesson3;

DROP TABLE IF EXISTS staff;
CREATE TABLE IF NOT EXISTS `staff`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`firstname` VARCHAR(45),
`lastname` VARCHAR(45),
`post` VARCHAR(45),
`seniority` INT,
`salary` INT, 
`age` INT);

INSERT INTO `staff` (`firstname`, `lastname`, `post`,`seniority`,`salary`, `age`)
VALUES
('Вася', 'Васькин', 'Начальник', 40, 100000, 60), 
('Петр', 'Власов', 'Начальник', 8, 70000, 30),
('Катя', 'Катина', 'Инженер', 2, 70000, 25),
('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

DROP TABLE IF EXISTS `activity_staff`;
CREATE TABLE IF NOT EXISTS `activity_staff`
(`id` INT PRIMARY KEY AUTO_INCREMENT,
`staff_id` INT,
FOREIGN KEY(staff_id) REFERENCES staff(id),
`date_activity` DATE,
`count_pages` INT
);

INSERT activity_staff (`staff_id`, `date_activity`, `count_pages`)
VALUES
(1,'2022-01-01',250),
(2,'2022-01-01',220),
(3,'2022-01-01',170),
(1,'2022-01-02',100),
(2,'2022-01-01',220),
(3,'2022-01-01',300),
(7,'2022-01-01',350),
(1,'2022-01-03',168),
(2,'2022-01-03',62),
(3,'2022-01-03',84);


select * from staff;

-- средняя зарплатаalter
select avg(salary)
from staff;

-- выведем инфу о сотрудникахб зп которых выше среднейalter

select * from staff
where salary > (select avg(salary) from staff);

-- order by
-- получим инфу о зп от меньшего к большему
select * from staff
order by salary asc; -- asg в mysql не обязательно (от меньшего к большему)

select * from staff
order by salary desc; -- desc обязательный параметр, от большего к меньшемуalter

select salary, id, post, seniority
from staff
where seniority > 5 and post = "Рабочий"
order by salary;

-- Выведите все записи, отсортированные по полю "age" по возрастанию
select * from staff
order by age asc;

-- Выведите все записи, отсортированные по полю “firstname"
select * from staff
order by firstname asc;

-- Выведите записи полей "firstname ", “lastname", "age", отсортированные по полю "firstname " в алфавитном порядке по убыванию
select firstname, lastname, age
from staff
order by firstname desc;

-- Выполните сортировку по полям " firstname " и "age" по убыванию
select firstname, age
from staff
order by firstname desc, age desc;

--  найти уникальные фамилииalter
select count(distinct lastname)
from staff;


-- 1. Выведите уникальные (неповторяющиеся) значения полей "firstname"

select distinct firstname
from staff;

-- 2. Отсортируйте записи по возрастанию значений поля "id". Выведите первые   две записи данной выборки
select * from staff
order by id
limit 2;
-- 3. Отсортируйте записи по возрастанию значений поля "id". Пропустите первые 4 строки данной выборки и извлеките следующие 3
select * from staff
order by id
limit 4,3;
-- 4. Отсортируйте записи по убыванию поля "id". Пропустите две строки данной выборки и извлеките следующие за ними 3 строки
select * from staff
order by id desc
limit 2,3;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- минимальная и максим зп по должностямa
select
salary, lastname, 
post,
max(salary) "Макс зп по должности",
min(salary) "Мин зп по должности"
from staff
group by post;

-- Выведем максимальную и минимальную зарплату по должностям 
SELECT 
SUM(salary), COUNT(lastname),
post,
MAX(salary) "Максимальная зарплата по должности",
MIN(salary) "Минимальная зарплата по должности",
MAX(salary) - MIN(salary) "Разница мин макс"
FROM staff
GROUP BY post;

-- 1. Выведите общее количество напечатанных страниц каждым сотрудником
SELECT 
sum(count_pages)
FROM activity_staff
GROUP BY staff_id;

-- 2. Посчитайте количество страниц за каждый день
SELECT 
SUM(count_pages), 
date_activity
FROM activity_staff
GROUP BY date_activity;


-- 3. Найдите среднее арифметическое по количеству ежедневных страниц
SELECT 
avg(count_pages), 
date_activity
FROM activity_staff
GROUP BY date_activity;

/* Сгруппируйте данные о сотрудниках по возрасту: 
1 группа – младше 20 лет
2 группа – от 20 до 40 лет
3 группа – старше  40 лет 
Для каждой группы  найдите суммарную зарплату
*/
SELECT SUM(salary), 
	CASE
		WHEN age > 0 AND age < 20 THEN "1 группа"
		WHEN age >= 20 AND age < 40 THEN "2 группа"
        WHEN age >= 40  THEN "3 группа"
	END AS группа_сотрудников
FROM staff
GROUP BY группа_сотрудников;

SELECT  name_age, SUM(salary)
   FROM 
	(SELECT salary,
		CASE 
			WHEN age < 20 THEN 'Младше 20 лет'
			WHEN age between 20 AND 40 THEN 'от 20 до 40 лет'
			WHEN age > 40 THEN 'Старше 40 лет'
			ELSE 'Не определено'
		END AS name_age 
	FROM staff ) AS list
   GROUP BY name_age;
   
   
   SELECT salary,
 IF (age <20,'1 группа',
 IF (age between 20 and 40,'2 группа',
 IF (age >48,'3 группа','error')) )
 AS `status`
FROM staff;



select salary, 
group_concat(lastname) as "сотрудники"
from staff
group by salary
having salary > 50000;

-- 1. Выведите id сотрудников, которые напечатали более 500 страниц за всех дни
SELECT 
staff_id, sum(count_pages)
FROM activity_staff
GROUP BY staff_id
having sum(count_pages) > 500;
 
-- 2.  Выведите  дни, когда работало более 3 сотрудников Также укажите кол-во сотрудников, которые работали в выбранные дни.
SELECT 
    staff_id, date_activity, COUNT(staff_id)
FROM
    activity_staff
GROUP BY staff_id
HAVING COUNT(staff_id) > 2;
-- 3. Выведите среднюю заработную плату по должностям, которая составляет более 30000





SELECT `status`, SUM(salary)
FROM 
	(SELECT salary,
		IF (age <20,'1 группа',
			IF (age between 20 and 40,'2 группа',
				IF (age >48,'3 группа','error')))
	AS `status`
FROM staff) AS `list2`
GROUP BY `status`;

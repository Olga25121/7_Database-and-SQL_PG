-- Урок 6. Семинар: SQL – выборка данных, сортировка, агрегатные функции

/* Синтаксис
SELECT expressions
FROM tables
[WHERE conditions]
ORDER BY expression [ ASC | DESC ];
*/

DROP DATABASE IF EXISTS lesson_3;
CREATE DATABASE lesson_3;
use lesson_3;

-- Персонал
DROP DATABASE IF EXISTS staff;
CREATE TABLE staff(
	id INT AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT,
	salary INT,
	age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000 , 60),
('Толик', 'Ветров', 'Инженер', '8', 70000 , 30),
('Саша', 'Ильин', 'Рабочий', '12', 50000 , 35),
('Саша', 'Иванов', 'Уборщик', '40', 25000 , 27);

SELECT * FROM staff; 

/*
1. Выведите все записи, отсортированные по полю "age" по возрастанию.
2. Выведите все записи, отсортированные по полю "firstname".
3. Выведите все записи полей "firstname", "lastname", "age",
отсортированные по полю "firstname" в алфавитном порядке по убыванию.
4. Выполните сортировку по полям "firstname" и "age" по убыванию.
*/

-- 1
SELECT * FROM staff
ORDER BY age;

-- 2
SELECT * FROM staff
ORDER BY firstname;

-- 3
SELECT firstname, lastname, age 
FROM staff
ORDER BY firstname DESC;

-- 4
SELECT * FROM staff
ORDER BY firstname, age;

/*
Операторы сортировки LIMIT, DISTINCT
DISTINCT -  для выборки уникальных производителей по нескольким столбцам
	SELECT DISTINCT поле1, поле2
    FROM staff;
LIMIT - позволяет извлечь определённый диапазон записей из одной или нескольких таблиц
	SELECT firstname, lastname, age 
	FROM staff
    LIMIT [смещение_относительно_начала,] количество_извлекаемых_строк
*/

/*
1. Выведите уникальные(неповторяющиеся) значения полей 'firstname'.
2. Отсортируйте записи по возрастанию значений поля 'id'.
	Выведите первые 2 записи данной выборки.
3. Отсортируйте записи по возрастанию значений поля 'id'.
	Пропустите первые 2 строки данной выборки и извлеките следующие 2.
4. Отсортируйте записи по убыванию значений поля 'id'.
	Пропустите первые 2 строки данной выборки и извлеките следующие 2.
*/

-- 1
SELECT DISTINCT firstname FROM staff;

-- 2
SELECT * FROM staff
ORDER BY id
LIMIT 2;

-- 3
SELECT * FROM staff
ORDER BY id
LIMIT 2, 2;

-- 4
SELECT * FROM staff
ORDER BY id DESC
LIMIT 2, 2;

/*
Агрегатные функции — count, sum, avg, обработка Null
AVG: вычисляет среднее значение
SUM: вычисляет сумму значений
MIN: вычисляет наименьшее значение
MAX: вычисляет наибольшее значение
COUNT: вычисляет количество строк в запросе
*/
-- Персонал
DROP DATABASE IF EXISTS employee_tbl;
CREATE TABLE employee_tbl(
	id_emp INT AUTO_INCREMENT PRIMARY KEY,
    id INT NOT NULL,
	fname VARCHAR(50) NOT NULL,
	work_date DATE,
	daily_typing_pages INT
);

-- Наполнение данными
INSERT INTO employee_tbl (id, fname, work_date, daily_typing_pages)
VALUES
(1, 'Вася', '2007-01-24', 250),
(2, 'Толик', '2007-03-26', 250),
(3, 'Саша', '2007-04-13', 250),
(4, 'Семен', '2007-05-25', 250);

SELECT * FROM employee_tbl; 

/*
1. Рассчитайте общее кол-во всех страниц daily_typing_pages.
2. Выведите общее кол-во напечатанных страниц каждым человеком (с помощью предложения GROUP BY).
3. Посчитайте кол-во записей в таблице.
4. Выведите кол-во имен уникальных.
5. Найдите среднее арифметическое по кол-ву ежедневных страниц набора (daily_typing_pages).
*/

-- 1
SELECT SUM(daily_typing_pages) AS sum FROM employee_tbl; 	

-- 2
SELECT fname, SUM(daily_typing_pages) AS sum FROM employee_tbl
GROUP BY fname;

-- 3
SELECT COUNT(*) FROM employee_tbl; 

-- 4
SELECT COUNT(DISTINCT fname) FROM employee_tbl; 

-- 5
SELECT AVG(daily_typing_pages) AS 'среднее' FROM employee_tbl; 

/*
Группировка — GROUP BY -  определяет, как строки будут группироваться.
Например, сгруппируем товары по производителю
SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM Products
GROUP BY Manufacturer
*/
-- Персонал
DROP DATABASE IF EXISTS employee_salary;
CREATE TABLE employee_salary(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
	age INT,
    salary INT
);

-- Наполнение данными
INSERT INTO employee_salary (name, age, salary)
VALUES
('Вася', 23, 100),
('Кира', 23, 150),
('Митя', 23, 170),
('Толик', 24, 200),
('Коля', 24, 200),
('Семен', 25, 300);

SELECT * FROM employee_salary; 

/*
1. Сгруппируйте поля по возрасту (будет 3 группы - 23 года, 24 и 25). 
	Для каждой группы найдите суммарную зарплату.
2. Сгруппируйте поля по возрасту (будет 3 группы - 23 года, 24 и 25). 
	Найдите максимальную зпл внутри группы.
3. Сгруппируйте поля по возрасту (будет 3 группы - 23 года, 24 и 25). 
	Найдите минимальную зпл внутри группы.
*/
-- 1
SELECT age, SUM(salary ) AS sum 
FROM employee_salary
GROUP BY age;

-- 2
SELECT age, MAX(salary ) AS max 
FROM employee_salary
GROUP BY age;

-- 3
SELECT age, MIN(salary ) AS min
FROM employee_salary
GROUP BY age;

/*
HAVING
MySQL оператор HAVING используется в сочетании с оператором GROUP BY, 
чтобы ограничить группы возвращаемых строк только тех, чье условие TRUE.
Синтаксис оператора HAVING в MySQL:
SELECT expression1, expression2, ... expression_n,
aggregate_function (expression)
FROM tables
[WHERE conditions]
GROUP BY expression1, expression2, ... expression_n
HAVING condition;
*/

/*
1. Выведите только те строки, в которых суммарная зарплата больше или равна 400.
2. Выведите только те группы, в которых количество строк меньше или равно двум.
3. Выведите только те группы, в которых количество строк меньше или равно двум.
	Для решения используйте оператор 'BETWEEN'.
4.* Выведите только те группы, в которых количество строк меньше или равно двум.
	Для решения используйте оператор 'IN'.
*/
-- 1
SELECT age, SUM(salary) AS sum 
FROM employee_salary
GROUP BY age
HAVING sum >= 400;

-- 2
SELECT age, COUNT(*) AS count 
FROM employee_salary
GROUP BY age
HAVING count <= 2;

-- 3
SELECT age, COUNT(*) AS count 
FROM employee_salary
GROUP BY age
HAVING count BETWEEN 0 AND 2;

-- 4
SELECT age, COUNT(*) AS count 
FROM employee_salary
GROUP BY age
HAVING count IN (0,1,2);


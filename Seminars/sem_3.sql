use lesson_4;

CREATE TABLE members
(
member_id INT AUTO_INCREMENT,
name VARCHAR(100),
PRIMARY KEY (member_id)
);

CREATE TABLE commitees
(
commitee_id INT AUTO_INCREMENT,
name VARCHAR(100),
PRIMARY KEY (commitee_id)
);

INSERT INTO members (name)
VALUES ('John'), ('Jane'), ('Kim'), ('David'), ('Amelia');
INSERT INTO commitees (name)
VALUES ('John'), ('Mary'), ('Ole'), ('Jot');

/*
Задание 1. INNER JOIN 
Выведите участников, которые также являются членами комитета.
Используйте INNER JOIN (пересечение 2х таблиц по имени).
*/

SELECT * FROM members;
SELECT * FROM commitees;

SELECT m.member_id, m.name AS member, c.commitee_id, c.name AS comit
FROM members m
INNER JOIN commitees c
ON 

/*
Задание 2. LEFT JOIN 
1. Выведите участников, которые являются членами комитета.
Используйте LEFT JOIN (объединение 2х таблиц по имени).
2.* Выведите участников, которые не являются членами комитета. 
*/
-- 1
SELECT m.member_id, m.name, c.commitee_id, c.name 
FROM members m
LEFT JOIN commitees cc.name = m.name;
USING(name);
-- 2
SELECT m.member_id, m.name, c.commitee_id, c.name 
FROM members m
LEFT JOIN commitees c
USING(name)
WHERE c.commitee_id IS NULL;

/*
Задание 2. RIGHT JOIN 
1. Найти членов комитета, которых нет в members с помощью RIGHT JOIN.
2. Выполнить RIGHT JOIN между 2мя таблицами по полю "имя". 
*/
-- 1
SELECT m.member_id, m.name, c.commitee_id, c.name 
FROM members m
RIGHT JOIN commitees c
USING(name)
WHERE m.member_id IS NULL;
-- 2
SELECT m.member_id, m.name, c.commitee_id, c.name 
FROM members m
RIGHT JOIN commitees c
USING(name); 

/*
Задание 3. FULL JOIN
Соединить обе таблицы с помощью FULL JOIN.
*/

SELECT m.member_id, m.name, c.commitee_id, c.name 
FROM members m
LEFT JOIN commitees c ON c.name = m.name
UNION
SELECT m.member_id, m.name, c.commitee_id, c.name 
FROM members m
RIGHT JOIN commitees c ON c.name = m.name;

/*
Задание 4. CROSS JOIN
Выведите перекрестное произведение таблиц members - commitees.
*/

SELECT m.member_id, m.name, c.commitee_id, c.name 
FROM members m
CROSS JOIN commitees c;

/*
Задание 5. UNION и UNION ALL
1. Получить список пользователей и клиентов, удалив одинаковых клиентов и пользователей.
2. Получить список пользователей и клиентов. Дубликаты не удалять.
*/
-- 1
SELECT * FROM members
UNION
SELECT * FROM commitees;
-- 2
SELECT * FROM members
UNION ALL
SELECT * FROM commitees;

/*
Задание 6. Оператор IN
1. Проверьте, присутствует ли буква "А" в последовательности 'A', 'B', 'C', 'D'.
2. Проверьте, присутствует ли буква "Z" в последовательности 'A', 'B', 'C', 'D'.
3. Получить столбцы из таблицы 'members', в которых первое имя является набором значений.
4. Выберите все логины из таблицы 'users', кроме 'Mikle'.
*/
-- 1
SELECT 'A' IN ('A', 'B', 'C', 'D');
-- 2
SELECT 'Z' IN ('A', 'B', 'C', 'D');
-- 3
SELECT * FROM members
WHERE name IN ('John', 'Jane', 'Kim');
-- 4
SELECT name FROM members
WHERE 'Mikle' NOT IN (name);

/*
Задание 7. Оператор EXISTS
Оператор EXISTS проверяет, возвращает ли подзапрос какое-либо значение. 
Как правило, этот оператор используется для индикации того, что как минимум одна строка в таблице удовлетворяет некоторому условию.
Поскольку возвращения набора строк не происходит, то подзапросы с подобным оператором выполняются довольно быстро.
SELECT * FROM Products
WHERE EXISTS
(SELECT * FROM Orders WHERE Orders.ProductId = Products.Id)
*/
USE myfirstdb;
SELECT * FROM products
WHERE EXISTS
(SELECT * FROM orders WHERE orders.product_Id = products.Id);



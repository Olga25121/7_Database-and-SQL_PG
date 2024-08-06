-- comment
# comment
/*
comment
comment
*/

/*
1. Получить список с информацией обо всех студентах.
2. Получить список всех студентов с именем "Антон"(или любого другого).
3. Вывести имя и название курса из таблички "Студент".
4*. Выбрать студентов, имя которых начинаются на "А".
*/

USE lesson_1;

-- 1
SELECT * FROM student;
-- 2
SELECT * FROM student
WHERE name = 'Anton';
-- 3
SELECT name, course_name FROM student;
-- 4
# % - любая подстрока. Galaxy S10, Galaxy S7, Galaxy S8s, Galaxy A10
# 'Galaxy S%' -> Galaxy S10, Galaxy S7, Galaxy S8s

# _ - любой символ. Galaxy S10, Galaxy S7, Galaxy S8s, Galaxy A10
# 'Galaxy S_' -> Galaxy S7

SELECT * FROM student
WHERE name LIKE 'A%';   # начинается с буквы "А"

SELECT * FROM student
WHERE name LIKE '%A%';  # Буква "А" в любом месте имени

SELECT * FROM student
WHERE name LIKE '_A_';  # выводится Rad - по 1 символу с каждой стороны

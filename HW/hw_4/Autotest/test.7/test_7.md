![Alt text](task_7.png)

**Решение:**

SELECT post

FROM staff

GROUP BY post

HAVING AVG(age) < 30;

![Alt text](res_7.png)
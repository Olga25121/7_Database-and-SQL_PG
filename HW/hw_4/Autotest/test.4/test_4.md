![Alt text](task_4.png)

**Решение:**

SELECT post, SUM(salary) AS total_salary

FROM staff

GROUP BY post

ORDER BY post;

![Alt text](res_4.png)

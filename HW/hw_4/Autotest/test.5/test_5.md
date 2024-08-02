![Alt text](task_5.png)

**Решение:**

SELECT COUNT(*) AS worker_count

FROM staff

WHERE post = 'Рабочий'

  AND age >= 24
  
  AND age <= 49;

![Alt text](res_5.png)
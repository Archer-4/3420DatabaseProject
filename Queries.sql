--Select clients that grow nuts and have at least 3 employees working for them
SELECT client.name, client.clientID
FROM client
INNER JOIN field_info ON field_info.clientID = client.clientID
INNER JOIN crops ON field_info.cropID = crops.cropID
INNER JOIN employees ON employees.clientID = client.clientID
WHERE CropType = 'Nut'
GROUP BY client.clientID
HAVING Count(employeeID) > 2;
--Select employees who have a salary of over 15k
SELECT name
FROM employees
WHERE (Salary > 15000);

--Select Fields that grow vegetables
SELECT fieldID
FROM field_info f, crops c
WHERE f.cropID = c.cropID
AND CropType = 'Vegetable';

--Select employees who work for client 2
SELECT name
FROM employees
WHERE clientID = 2;

--Select equipment that is not in good status
SELECT *
FROM Equipment
WHERE NOT status = 'Good';

--Select clients with at least 2 outgoing deliveries
SELECT *
FROM (SELECT name, COUNT(client.clientID) deliveries
      FROM client
      JOIN outgoingdeliveries ON outgoingdeliveries.clientID = client.clientID
      GROUP BY name) t
WHERE deliveries > 1;

--Select clients with at least 2 incoming deliveries
SELECT *
FROM (SELECT name, COUNT(client.clientID) deliveries
      FROM client
      JOIN incomingdeliveries ON incomingdeliveries.clientID = client.clientID
      GROUP BY name) t
WHERE deliveries > 1;

--Select the average pay of each Client
SELECT name, avg(salary) AS avgsalary
FROM (SELECT client.name AS name, employees.salary AS salary
      FROM client, employees
      WHERE client.clientID = employees.clientID) t
GROUP BY name
ORDER BY avgsalary DESC;

--Select clients who own Chysler-made equipment
SELECT name, equipmenttype, brand
FROM client c, equipment e, field_info f
WHERE c.clientID = f.clientID 
AND f.fieldID = e.fieldID
AND e.brand = 'Chrysler';

--Select net change in funds from transactions for each client
SELECT c.name, count(t.id) AS numoftransactions, sum(t.amount) AS netchange
FROM client c, transactions t
WHERE c.clientID = t.clientID
GROUP BY name;

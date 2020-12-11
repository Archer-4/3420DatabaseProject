--Select clients that grow nuts and have at least 3 employees working for them
SELECT client.name, client.clientID
FROM client
INNER JOIN field_info ON field_info.clientID = client.clientID
INNER JOIN crops ON field_info.cropID = crops.cropID
INNER JOIN employees ON employees.clientID = client.clientID
WHERE CropType = 'Nut'
GROUP BY client.clientID
HAVING Count(employeeID) > 2;

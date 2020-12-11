CREATE VIEW Inventory_Log AS
SELECT client.name AS clientName, inventory.Name AS stockName, inventory.Amount
FROM inventory, client
WHERE client.clientID = inventory.clientID;

CREATE VIEW Employee_Roster AS
SELECT client.name AS ClientName, Employees.name AS EmployeeName, employees.employmentstatus AS job, employees.salary AS pay
FROM employees, client
WHERE client.clientID = employees.clientID
ORDER BY pay DESC;

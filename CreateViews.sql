CREATE VIEW Inventory_Log AS
SELECT client.name AS clientName, inventory.Name AS stockName, inventory.Amount
FROM inventory, client
WHERE client.clientID = inventory.clientID;

CREATE VIEW Employee_Roster AS
SELECT client.name AS ClientName, Employees.name AS EmployeeName, employees.employmentstatus AS job, employees.salary AS pay
FROM employees, client
WHERE client.clientID = employees.clientID
ORDER BY pay DESC;

CREATE VIEW Clients_Equipment AS
SELECT c.name AS Name, e.equipmenttype AS equipment, e.brand AS brand, e.status AS current_status
FROM client c, equipment e, field_info f
WHERE c.clientID = f.clientID
AND f.fieldID = e.fieldID;

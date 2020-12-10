CREATE VIEW Inventory_Log AS
SELECT client.name AS clientName, inventory.Name AS stockName, inventory.Amount
FROM inventory, client
WHERE client.clientID = inventory.clientID;

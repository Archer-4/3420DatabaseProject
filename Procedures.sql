-- PROCEDURES --

--To be used with trigger delClients
CREATE OR REPLACE FUNCTION delClient()
RETURNS TRIGGER AS $$
BEGIN
    DELETE
    FROM Employees
    WHERE Employees.clientID = old.clientID;

    DELETE 
    FROM field_info
    WHERE field_info.clientID = old.clientID;

    DELETE
    FROM incomingdeliveries i
    WHERE i.clientID = old.clientID;

    DELETE
    FROM outgoingdeliveries o
    WHERE o.clientID = old.clientID;

    DELETE 
    FROM livestock
    WHERE livestock.clientID = old.clientID;

    DELETE
    FROM inventory
    WHERE inventory.clientID = old.clientID;
    
    DELETE
    FROM transactions
    WHERE transactions.clientID = old.clientID;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

--To be used with the equipment log trigger
CREATE OR REPLACE FUNCTION equipMaintLog()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO equipmentlog(equipmentnumber, fieldid, status, entry_date)
    VALUES (new.equipmentnumber, new.fieldid, new.status, current_timestamp);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--To be used with outgoing/inventory update trigger
CREATE OR REPLACE FUNCTION upInvAmt()
RETURNS TRIGGER AS $$
DECLARE
price numeric(4,2);

BEGIN
    UPDATE inventory
    SET amount = amount - new.stockamount
    WHERE new.clientID = inventory.clientID
    AND new.stockID = inventory.stockID;

    SELECT priceperunit INTO price
    FROM inventory
    WHERE new.stockID = inventory.stockID;

    INSERT INTO transactions (clientid,transaction,transactionid,amount) VALUES
    (new.clientID, 'Outbound Delivery', new.out_deliveryid,new.stockamount*price);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--To be used with incoming/inventory update trigger
CREATE OR REPLACE FUNCTION upIncAmt()
RETURNS TRIGGER AS $$
DECLARE
price numeric(4,2);

BEGIN
    UPDATE inventory
    SET amount = amount + new.stock_levels
    WHERE new.stockID = inventory.stockID;

    SELECT priceperunit INTO price
    FROM inventory
    WHERE new.stockID = inventory.stockID;

    INSERT INTO transactions (clientid,transaction,transactionID,amount) VALUES
    (new.clientID, 'Inbound Delivery', new.in_deliveryid,  -1 * new.stock_levels * price);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--To be used with updateinstead trigger
CREATE OR REPLACE FUNCTION upDateInstead()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE client
    SET name = new.clientname
    WHERE name = old.clientname;

    UPDATE inventory
    SET name = new.inventoryname, amount = new.amount
    WHERE name = old.inventoryname
    AND amount = old.amount;
    RETURN NEW;
END;
$$LANGUAGE plpgsql;
-- TRIGGERS --

-- Trigger for deleting clients;
CREATE TRIGGER delClients BEFORE DELETE ON client
FOR EACH ROW EXECUTE PROCEDURE delClient();

-- Trigger for maintenaince log
CREATE TRIGGER equipLog AFTER UPDATE ON equipment
FOR EACH ROW EXECUTE PROCEDURE equipMaintLog();

-- Trigger for updating inventory amounts 
-- & logging transaction after
-- outgoing delivery is created.
CREATE TRIGGER upInvAmt AFTER INSERT ON outgoingdeliveries
FOR EACH ROW EXECUTE PROCEDURE upInvAmt();

-- Trigger for updating inventory amounts 
-- & logging transaction after
-- incoming delivery is created.
CREATE TRIGGER upIncAmt AFTER INSERT ON incomingdeliveries
FOR EACH ROW EXECUTE PROCEDURE upIncAmt();
-- Trigger for updateinstead function
CREATE TRIGGER updateInstead INSTEAD OF UPDATE ON Inventory_Log
FOR EACH ROW EXECUTE PROCEDURE upDateInstead();

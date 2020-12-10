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

    RETURN NEW;
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



-- TRIGGERS --

-- Trigger for deleting clients;
CREATE TRIGGER delClients BEFORE DELETE ON client
FOR EACH ROW EXECUTE PROCEDURE delClient();

-- Trigger for maintenaince log
CREATE TRIGGER equipLog AFTER UPDATE ON equipment
FOR EACH ROW EXECUTE PROCEDURE equipMaintLog();

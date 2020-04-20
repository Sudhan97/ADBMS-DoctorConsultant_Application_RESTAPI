
CREATE OR REPLACE TRIGGER new_consult_record
AFTER
    INSERT
    ON consultant_datetime 
    FOR EACH ROW
DECLARE
    operation varchar2(20);
BEGIN
    INSERT INTO doctor_consult_details(consult_id, doctor_id)
    VALUES(:NEW.consult_id, :NEW.doctor_id);
END;


CREATE OR REPLACE TRIGGER del_consult_record
AFTER
    DELETE
    ON consultant_datetime 
    FOR EACH ROW
DECLARE
    operation varchar2(20);
BEGIN
    DELETE FROM doctor_consult_details 
    WHERE consult_id = :OLD.consult_id;
END;
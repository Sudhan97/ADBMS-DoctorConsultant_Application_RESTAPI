
-- procedures for doctor schema
CREATE OR REPLACE PACKAGE doctor_pkg
AS  
    PROCEDURE read_doctor_id(doc_id doctor.doctor_id%TYPE);
    
    PROCEDURE read_doctor_specialization(spec doctor.specialization%TYPE);

END doctor_pkg;
/

CREATE OR REPLACE PACKAGE BODY doctor_pkg
AS

    PROCEDURE read_doctor_id(doc_id doctor.doctor_id%TYPE)
    AS doc_cur SYS_REFCURSOR;
    begin
        open doc_cur for
            SELECT * FROM doctor 
            WHERE doctor_id = doc_id;
        dbms_sql.return_result(doc_cur );
    END read_doctor_id;

    PROCEDURE read_doctor_specialization(spec doctor.specialization%TYPE)
    AS doc_cur SYS_REFCURSOR;
    begin
        open doc_cur for
            SELECT * FROM doctor 
            WHERE specialization = spec;
        dbms_sql.return_result(doc_cur );
    END read_doctor_specialization;
        
END doctor_pkg;

-- End of section

-- package for consult-datetime and doctor-consult-details



-- end of section

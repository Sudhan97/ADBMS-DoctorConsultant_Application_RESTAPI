
CREATE TABLE patient (
    patient_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(150) NOT NULL,
    last_name VARCHAR2(150) NOT NULL,
    age NUMBER(3) NOT NULL,
    mobile_number NUMBER(10) NOT NULL,
    email_address VARCHAR2(120) NOT NULL,
    guardian_name VARCHAR2(150),
    guardian_mobile NUMBER(10),
    PRIMARY KEY (patient_id)
);

CREATE TABLE user_account_details (
    username VARCHAR2(200),
    digest_password VARCHAR2(150) NOT NULL,
    account_created DATE NOT NULL,
    account_last_login TIMESTAMP NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE pharmacist (
    pharmacist_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(150) NOT NULL,
    last_name VARCHAR2(150) NOT NULL,
    mobile_number NUMBER(10) NOT NULL,
    email_address VARCHAR2(120) NOT NULL,
    PRIMARY KEY (pharmacist_id)
);

CREATE TABLE receptionist (
    receptionist_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(150) NOT NULL,
    last_name VARCHAR2(150) NOT NULL,
    mobile_number NUMBER(10) NOT NULL,
    email_address VARCHAR2(120) NOT NULL,
    PRIMARY KEY (receptionist_id)
);


CREATE TABLE medication_record (
    med_record_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    prescrition VARCHAR2(200) NOT NULL,
    date_prescribed DATE NOT NULL,
    medication_issued DATE,
    doctor_id NUMBER NOT NULL, 
    patient_id NUMBER NOT NULL,
    pharmacist_id NUMBER NOT NULL,
    PRIMARY KEY (med_record_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (pharmacist_id) REFERENCES pharmacist(pharmacist_id)
);


CREATE TABLE appointment (
    appointment_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    appointment_date DATE NOT NULL,
    appointment_time TIMESTAMP NOT NULL,
    status VARCHAR2(150) NOT NULL,
    patient_id NUMBER NOT NULL,
    doctor_id NUMBER NOT NULL, 
    receptionist_id NUMBER NOT NULL,
    PRIMARY KEY (appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (receptionist_id) REFERENCES receptionist(receptionist_id)
);

CREATE TABLE consultant_datetime (
    consult_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    consult_date DATE NOT NULL,
    consult_time TIMESTAMP NOT NULL,
    status VARCHAR2(150) NOT NULL,
    receptionist_id NUMBER NOT NULL,
    PRIMARY KEY (consult_id),
    FOREIGN KEY (receptionist_id) REFERENCES receptionist(receptionist_id)
);

CREATE TABLE doctor_consult_details (
    consult_id NUMBER,
    doctor_id NUMBER,
    PRIMARY KEY(consult_id, doctor_id),
    FOREIGN KEY (consult_id) REFERENCES consultant_datetime(consult_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);


CREATE TABLE payment_details (
    payment_record_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    amount NUMBER NOT NULL,
    status VARCHAR2(150) NOT NULL,
    payment_date DATE ,
    payment_time TIMESTAMP ,
    receptionist_id NUMBER ,
    patient_id NUMBER NOT NULL,
    PRIMARY KEY (payment_record_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (receptionist_id) REFERENCES receptionist(receptionist_id)
);

CREATE TABLE doctor_patient_consult_details (
    patient_id NUMBER,
    doctor_id NUMBER,
    PRIMARY KEY(patient_id, doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE medical_records(
    medical_record_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    disease VARCHAR2(100) NOT NULL,
    specialization VARCHAR2(120),
    PRIMARY KEY (medical_record_id)
);

CREATE TABLE patient_medical_records(
    patient_id NUMBER NOT NULL,
    medical_record_id NUMBER NOT NULL,
    PRIMARY KEY (patient_id, medical_record_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (medical_record_id) REFERENCES medical_records(medical_record_id)
);

CREATE TABLE symptoms_record(
    medical_record_id NUMBER NOT NULL,
    symptom VARCHAR2(150)NOT NULL,
    PRIMARY KEY (medical_record_id, symptom),
    FOREIGN KEY (medical_record_id) REFERENCES medical_records(medical_record_id)
);

ALTER TABLE doctor
ADD username VARCHAR2(200)
CONSTRAINT username_doctor REFERENCES user_account_details(username);

ALTER TABLE pharmacist
ADD username VARCHAR2(200)
CONSTRAINT username_pharmacist REFERENCES user_account_details(username);

ALTER TABLE receptionist
ADD username VARCHAR2(200)
CONSTRAINT username_receptionist REFERENCES user_account_details(username);

ALTER TABLE consultant_datetime
ADD doctor_id NUMBER
CONSTRAINT doctorID_consult_datetime REFERENCES doctor(doctor_id);

COMMIT WORK;
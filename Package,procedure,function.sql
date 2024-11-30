-- 1 Patient Management adding patient and check if patient exists

CREATE OR REPLACE PACKAGE patient_pkg IS

    -- Declaration of the add_patient procedure
    PROCEDURE add_patient (
        p_patient_id NUMBER,
        p_first_name VARCHAR2,
        p_last_name VARCHAR2,
        p_dob DATE,
        p_city VARCHAR2,
        p_zip_code VARCHAR2,
        p_contact_number VARCHAR2,
        p_email VARCHAR2
    );

    -- Declaration of the patient_exists function
    FUNCTION patient_exists (
        p_email IN VARCHAR2,
        p_contact_number IN VARCHAR2
    ) RETURN BOOLEAN;

END patient_pkg;
/


-- Package body
CREATE OR REPLACE PACKAGE BODY patient_pkg IS

    -- Implementation of add_patient procedure
    PROCEDURE add_patient (
        p_patient_id IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name IN VARCHAR2,
        p_dob IN DATE,
        p_city IN VARCHAR2,
        p_zip_code IN VARCHAR2,
        p_contact_number IN VARCHAR2,
        p_email IN VARCHAR2
    ) 
    IS
    BEGIN
        -- Insert the patient details into the PATIENT table
        INSERT INTO "PCM.PATIENT" 
        (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email)
        VALUES (p_patient_id, p_first_name, p_last_name, p_dob, p_city, p_zip_code, p_contact_number, p_email);
        
        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Patient Added Successfully');
    END add_patient;

    -- Implementation of patient_exists function
    FUNCTION patient_exists (
        p_email IN VARCHAR2,
        p_contact_number IN VARCHAR2
    ) RETURN BOOLEAN 
    IS
        v_count NUMBER;
    BEGIN
        -- Check if patient exists in the database
        SELECT COUNT(*) INTO v_count
        FROM "PCM.PATIENT"
        WHERE email = p_email OR contact_number = p_contact_number;

        IF v_count > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END patient_exists;

END patient_pkg;
/
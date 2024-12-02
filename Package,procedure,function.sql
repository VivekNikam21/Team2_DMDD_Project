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

-- 2 Appoint management schedule and check if app exists

CREATE OR REPLACE PACKAGE appointment_pkg IS
    -- Procedure to schedule an appointment
    PROCEDURE schedule_appointment (
        p_appointment_id NUMBER,
        p_patient_id NUMBER,
        p_doctor_id NUMBER,
        p_appointment_date DATE,
        p_status VARCHAR2
    );

    -- Function to check if a patient has any existing appointments for a given date
    FUNCTION has_appointment_on_date (
        p_patient_id NUMBER,
        p_appointment_date DATE
    ) RETURN BOOLEAN;
END appointment_pkg;
/

--PACKAGE BODY

CREATE OR REPLACE PACKAGE BODY appointment_pkg IS

    -- Implementation of schedule_appointment procedure
    PROCEDURE schedule_appointment (
        p_appointment_id NUMBER,
        p_patient_id NUMBER,
        p_doctor_id NUMBER,
        p_appointment_date DATE,
        p_status VARCHAR2
    )
    IS
    BEGIN
        -- First, check if the patient already has an appointment on the same date
        IF has_appointment_on_date(p_patient_id, p_appointment_date) THEN
            DBMS_OUTPUT.PUT_LINE('Error: Patient already has an appointment on this date.');
        ELSE
            -- Insert appointment details into the APPOINTMENT table
            INSERT INTO "PCM.APPOINTMENT"
            (appointment_id, patient_id, doctor_id, scheduled_date, status)
            VALUES (p_appointment_id, p_patient_id, p_doctor_id, p_appointment_date, p_status);
            
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Appointment Scheduled Successfully');
        END IF;
    END schedule_appointment;

    -- Implementation of has_appointment_on_date function
    FUNCTION has_appointment_on_date (
        p_patient_id IN NUMBER,
        p_appointment_date IN DATE
    ) RETURN BOOLEAN
    IS
        v_count NUMBER;
    BEGIN
        -- Check if the patient has any appointment for the given date
        SELECT COUNT(*) INTO v_count
        FROM "PCM.APPOINTMENT"
        WHERE patient_id = p_patient_id
        AND scheduled_date = p_appointment_date;

        IF v_count > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END has_appointment_on_date;

END appointment_pkg;
/


-- 3 Billing and Payment Management generate bill, check pay status 

CREATE OR REPLACE PACKAGE billing_pkg IS
    -- Procedure to generate a bill
    PROCEDURE generate_bill (
        p_bill_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_appointment_id IN NUMBER,
        p_total_amount IN NUMBER
    );

    -- Function to check payment status of a bill
    FUNCTION check_payment_status (
        p_bill_id IN NUMBER
    ) RETURN VARCHAR2;
END billing_pkg;
/

-- PACKAGE BODY

CREATE OR REPLACE PACKAGE BODY billing_pkg IS

    -- Implementation of generate_bill procedure
    PROCEDURE generate_bill (
        p_bill_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_appointment_id IN NUMBER,
        p_total_amount IN NUMBER
    )
    IS
    BEGIN
        -- Insert into BILLING table
        INSERT INTO "PCM.BILLING"
        (bill_id, appointment_id, total_amount, payment_status)
        VALUES (p_bill_id, p_appointment_id, p_total_amount, 'Pending');

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Bill Generated Successfully');
    END generate_bill;

    -- Implementation of check_payment_status function
    FUNCTION check_payment_status (
        p_bill_id IN NUMBER
    ) RETURN VARCHAR2
    IS
        v_payment_status VARCHAR2(50);
    BEGIN
        -- Retrieve payment status from BILLING table
        SELECT payment_status INTO v_payment_status
        FROM "PCM.BILLING"
        WHERE bill_id = p_bill_id;

        RETURN v_payment_status;
    END check_payment_status;

END billing_pkg;
/

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
        p_contact_number NUMBER,
        p_email VARCHAR2,
        p_primary_doctor_id NUMBER
    );

    -- Declaration of the patient_exists function
    FUNCTION patient_exists (
        p_email VARCHAR2,
        p_contact_number NUMBER
    ) RETURN NUMBER;

END patient_pkg;
/


-- Package body
CREATE OR REPLACE PACKAGE BODY patient_pkg IS

    -- Implementation of add_patient procedure
    PROCEDURE add_patient (
        p_patient_id NUMBER,
        p_first_name VARCHAR2,
        p_last_name VARCHAR2,
        p_dob DATE,
        p_city VARCHAR2,
        p_zip_code VARCHAR2,
        p_contact_number NUMBER,
        p_email VARCHAR2,
        p_primary_doctor_id NUMBER
    ) 
    IS
    BEGIN
        -- Insert the patient details into the PATIENT table
        INSERT INTO "PCM.PATIENT" 
        (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
        VALUES (p_patient_id, p_first_name, p_last_name, p_dob, p_city, p_zip_code, p_contact_number, p_email, p_primary_doctor_id);
        
        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Patient Added Successfully');
    END add_patient;

    -- Implementation of patient_exists function
    FUNCTION patient_exists (
        p_email VARCHAR2,
        p_contact_number NUMBER
    ) RETURN NUMBER
    IS
        v_count NUMBER;
    BEGIN
        -- Check if patient exists in the database
         SELECT COUNT(*) INTO v_count
    FROM "PCM.PATIENT"
    WHERE email = p_email OR contact_number = p_contact_number;

    IF v_count > 0 THEN
         dbms_output.put_line('Patient exists');
         RETURN 1;-- Patient exists
    ELSE
         dbms_output.put_line('Patient does not exist');
         RETURN 0;-- Patient does not exist
    END IF;
    END patient_exists;

END patient_pkg;
/








-- 2 Appoint management schedule and check if app exists
CREATE OR REPLACE PACKAGE appointment_pkg IS
    -- Procedure to schedule an appointment
    PROCEDURE schedule_appointment (
        p_appointment_id NUMBER,
        p_scheduled_date DATE,
        p_scheduled_time TIMESTAMP,
        p_patient_id NUMBER,
        p_doctor_id NUMBER,
        p_status VARCHAR2,
        p_treatment_plan varchar2,
        p_follow_up_appointment_id number
    );

    -- Function to check if a patient has any existing appointments for a given date
    FUNCTION has_appointment_on_date (
        p_patient_id NUMBER,
        p_scheduled_date DATE
    ) RETURN NUMBER;
END appointment_pkg;
/

--PACKAGE BODY

CREATE OR REPLACE PACKAGE BODY appointment_pkg IS

    -- Implementation of schedule_appointment procedure
    PROCEDURE schedule_appointment (
        p_appointment_id NUMBER,
        p_scheduled_date DATE,
        p_scheduled_time TIMESTAMP,
        p_patient_id NUMBER,
        p_doctor_id NUMBER,
        p_status VARCHAR2,
        p_treatment_plan varchar2,
        p_follow_up_appointment_id number
    )
    IS
    BEGIN
        -- First, check if the patient already has an appointment on the same date
        IF has_appointment_on_date(p_patient_id, p_scheduled_date) = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Patient already has an appointment on this date.');
        ELSE
            -- Insert appointment details into the APPOINTMENT table
            INSERT INTO "PCM.APPOINTMENT"
            (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
            VALUES (p_appointment_id, p_scheduled_date, p_scheduled_time, p_patient_id, p_doctor_id, p_status, p_treatment_plan, p_follow_up_appointment_id);
            
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Appointment Scheduled Successfully');
        END IF;
    END schedule_appointment;

    -- Implementation of has_appointment_on_date function
    FUNCTION has_appointment_on_date (
        p_patient_id NUMBER,
        p_scheduled_date DATE
    ) RETURN NUMBER
    IS
        v_count NUMBER;
    BEGIN
        -- Check if the patient has any appointment for the given date
        SELECT COUNT(*) INTO v_count
        FROM "PCM.APPOINTMENT"
        WHERE patient_id = p_patient_id
        AND scheduled_date = p_scheduled_date;

        IF v_count > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END has_appointment_on_date;

END appointment_pkg;
/


-- 3 Billing and Payment Management generate bill, check pay status 

CREATE OR REPLACE PACKAGE billing_pkg IS
    -- Procedure to generate a bill
    PROCEDURE generate_bill (
        p_bill_id NUMBER,
        p_total_amount NUMBER,
        p_payment_status VARCHAR2,
        p_date_issued date,
        p_appointment_id NUMBER
    );

    -- Function to check payment status of a bill
    FUNCTION check_payment_status (
        p_bill_id NUMBER
    ) RETURN VARCHAR2;
END billing_pkg;
/

-- PACKAGE BODY

CREATE OR REPLACE PACKAGE BODY billing_pkg IS

    -- Implementation of generate_bill procedure
    PROCEDURE generate_bill (
        p_bill_id NUMBER,
        p_total_amount NUMBER,
        p_payment_status VARCHAR2,
        p_date_issued date,
        p_appointment_id NUMBER
    )
    IS
    BEGIN
        -- Insert into BILLING table
        INSERT INTO "PCM.BILLING"
        (bill_id, total_amount, payment_status, date_issued, appointment_id)
        VALUES (p_bill_id, p_total_amount, p_payment_status, p_date_issued, p_appointment_id);

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Bill Generated Successfully');
    END generate_bill;

    -- Implementation of check_payment_status function
    FUNCTION check_payment_status (
        p_bill_id NUMBER
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


-- 4 Prescription Management

CREATE OR REPLACE PACKAGE prescription_mgmt_pkg IS
    -- Procedure to create a new prescription
    PROCEDURE create_prescription (
        p_prescription_order_id NUMBER,
        p_quantity NUMBER,
        p_cost NUMBER,
        p_prescription_id NUMBER,
        p_medication_id NUMBER        
    );

    -- Function to check if a medication is available in stock
    FUNCTION is_medication_available (
        p_medication_id NUMBER,
        p_quantity NUMBER
    ) RETURN NUMBER;
END prescription_mgmt_pkg;
/

-- PACKAGE BODY

CREATE OR REPLACE PACKAGE BODY prescription_mgmt_pkg IS

    -- Implementation of create_prescription procedure
    PROCEDURE create_prescription (
       p_prescription_order_id NUMBER,
        p_quantity NUMBER,
        p_cost NUMBER,
        p_prescription_id NUMBER,
        p_medication_id NUMBER   
    )
    IS
    BEGIN
        -- Check if medication is available in stock
        IF is_medication_available(p_medication_id, p_quantity)=1  THEN
            -- Insert prescription order into the PRESCRIPTION_ORDER table
            INSERT INTO "PCM.PRESCRIPTION_ORDER"
            (prescription_order_id, quantity, 
            COST
            , prescription_id, medication_id)
            VALUES (p_prescription_order_id, p_quantity, p_cost, p_prescription_id, p_medication_id);

            -- Update medication stock level
            UPDATE "PCM.MEDICATION"
            SET stock_level = stock_level - p_quantity
            WHERE medication_id = p_medication_id;

            COMMIT;

            DBMS_OUTPUT.PUT_LINE('Prescription Created Successfully');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: Medication is out of stock');
        END IF;
    END create_prescription;

    -- Implementation of is_medication_available function
    FUNCTION is_medication_available (
        p_medication_id NUMBER,
        p_quantity NUMBER
    ) RETURN NUMBER
    IS
        v_stock_level NUMBER;
    BEGIN
        -- Check the current stock level for the given medication
        SELECT stock_level
        INTO v_stock_level
        FROM "PCM.MEDICATION"
        WHERE medication_id = p_medication_id;

        -- Return TRUE if the stock level is sufficient, otherwise FALSE
        IF v_stock_level >= p_quantity THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END is_medication_available;

END prescription_mgmt_pkg;
/
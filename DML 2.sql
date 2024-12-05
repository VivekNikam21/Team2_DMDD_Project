begin
   -- appointment table
   begin execute immediate 'drop table "PCM.APPOINTMENT" cascade constraints';
   dbms_output.put_line('appointment table dropped');
   exception when others then if sqlcode != -942 then  -- does not care about table does not exist error
   raise; end if; 
   end;
   execute immediate '
      create table "PCM.APPOINTMENT" (
         appointment_id           number(10) not null,
         scheduled_date           date not null,
         scheduled_time           timestamp not null,
         patient_id               number(10) not null,
         doctor_id                number(10) not null,
         status                   varchar2(20 byte) not null,
         treatment_plan           clob not null,
         cancellation_reason      varchar2(20 byte),
         follow_up_appointment_id number(10)
      )'; dbms_output.put_line('appointment table created');
   execute immediate 'alter table "PCM.APPOINTMENT" add constraint "appointment_status_check" check ( status in ( ''canceled'', ''completed'', ''scheduled'' ) )';
   dbms_output.put_line('appointment status check constraint added');
   execute immediate 'alter table "PCM.APPOINTMENT" add constraint "appointment_pk" primary key ( appointment_id )';
   dbms_output.put_line('appointment primary key constraint added');

   -- billing table
   begin
      execute immediate 'drop table "PCM.BILLING" cascade constraints';
      dbms_output.put_line('billing table dropped');
   exception when others then
   if sqlcode != -942 then  -- does not care about table does not exist error
   raise; end if; 
   end;

   execute immediate '
      create table "PCM.BILLING" (
         bill_id        number(10) not null,
         total_amount   number(10, 2) not null,
         payment_status varchar2(20 byte) not null,
         date_issued    date not null,
         appointment_id number(10) not null
      )'; dbms_output.put_line('billing table created');
   execute immediate 'alter table "PCM.BILLING" add constraint "payment_status_check" check ( payment_status in ( ''paid'', ''pending'', ''partially paid'', ''unpaid'') )';
   dbms_output.put_line('billing payment status check constraint added');
   execute immediate 'alter table "PCM.BILLING" add constraint "billing_pk" primary key ( bill_id )';
   dbms_output.put_line('billing primary key constraint added');

   -- doctor table
   begin
      execute immediate 'drop table "PCM.DOCTOR" cascade constraints';
      dbms_output.put_line('doctor table dropped');
   exception when others then
   if sqlcode != -942 then  -- does not care about table does not exist error
   raise; end if; 
   end;

   execute immediate '
      create table "PCM.DOCTOR" (
         doctor_id      number(10) not null,
         first_name     varchar2(50 byte) not null,
         last_name      varchar2(50 byte) not null,
         specialization varchar2(50 byte) not null,
         contact_number number(10) not null,
         email          varchar2(50 byte) not null, 
         city           varchar(50 byte) not null
      )'; dbms_output.put_line('doctor table created');
   execute immediate 'alter table "PCM.DOCTOR" add constraint "doctor_pk" primary key ( doctor_id )';
   dbms_output.put_line('doctor primary key constraint added');
   execute immediate 'alter table "PCM.DOCTOR" add constraint "uq_doctor_contact_number" unique ( contact_number )';
   dbms_output.put_line('doctor contact number unique constraint added');
   execute immediate 'alter table "PCM.DOCTOR" add constraint "uq_doctor_email" unique ( email )';
   dbms_output.put_line('doctor email unique constraint added');

   -- medication table
   begin
      execute immediate 'drop table "PCM.MEDICATION" cascade constraints';
      dbms_output.put_line('medication table dropped');
   exception when others then
   if sqlcode != -942 then  -- does not care about table does not exist error
   raise; end if; 
   end;

   execute immediate '
      create table "PCM.MEDICATION" (
         medication_id   number(10) not null,
         name            varchar2(50 byte) not null,
         medication_type varchar2(50 byte) not null,
         stock_level     number(10) not null,
         price           number(8, 2) not null,
         expiration_date date not null,
         pharmacy_id     number(10) not null
      )'; dbms_output.put_line('medication table created');

   execute immediate 'alter table "PCM.MEDICATION" add constraint "medication_type_check" check ( medication_type in ( ''capsule'', ''drops'', ''injection'', ''ointment'', ''syrup'', ''tablet'', ''lozenges'', ''aspirins'', ''bandaid'', ''antiseptic'', ''oral rinse'' ) )';
   dbms_output.put_line('medication type check constraint added');

   execute immediate 'alter table "PCM.MEDICATION" add constraint "medication_pk" primary key ( medication_id )';
   dbms_output.put_line('medication primary key constraint added');

   -- patient table
   begin
      execute immediate 'drop table "PCM.PATIENT" cascade constraints';
      dbms_output.put_line('patient table dropped');
   exception when others then
   if sqlcode != -942 then  -- does not care about table does not exist error
   raise; end if; 
   end;

   execute immediate '
      create table "PCM.PATIENT" (
         patient_id        number(10) not null,
         first_name        varchar2(50 byte) not null,
         last_name         varchar2(50 byte) not null,
         date_of_birth     date not null,
         city              varchar2(50 byte) not null,
         zipcode           varchar2(50 byte) not null,
         contact_number    number(10) not null,
         email             varchar2(50 byte) not null,
         primary_doctor_id number(10) not null
      )'; dbms_output.put_line('patient table created');

   execute immediate 'alter table "PCM.PATIENT" add constraint "patient_pk" primary key ( patient_id )';
   dbms_output.put_line('patient primary key constraint added');

   execute immediate 'alter table "PCM.PATIENT" add constraint "patient_contact_number_un" unique ( contact_number )';
   dbms_output.put_line('patient contact number unique constraint added');

   execute immediate 'alter table "PCM.PATIENT" add constraint "patient_email_un" unique ( email )';
   dbms_output.put_line('patient email unique constraint added');

   -- pharmacy table
   begin
      execute immediate 'drop table "PCM.PHARMACY" cascade constraints';
      dbms_output.put_line('pharmacy table dropped');
   exception when others then
if sqlcode != -942 then  -- does not care about table does not exist error
raise; end if; 
end;

   execute immediate '
      create table "PCM.PHARMACY" (
         pharmacy_id    number(10) not null,
         pharmacy_name  varchar2(50 byte) not null,
         city           varchar2(50 byte) not null,
         zipcode        varchar2(50 byte) not null,
         contact_number number not null
      )'; dbms_output.put_line('pharmacy table created');

   execute immediate 'alter table "PCM.PHARMACY" add constraint "pharmacy_pk" primary key ( pharmacy_id )';
   dbms_output.put_line('pharmacy primary key constraint added');

   execute immediate 'alter table "PCM.PHARMACY" add constraint "pharmacy_contact_number_un" unique ( contact_number )';
   dbms_output.put_line('pharmacy contact number unique constraint added');

   -- prescription table
   begin
      execute immediate 'drop table "PCM.PRESCRIPTION" cascade constraints';
      dbms_output.put_line('prescription table dropped');
   exception when others then
   if sqlcode != -942 then  -- does not care about table does not exist error
raise; end if; 
end;

   execute immediate '
      create table "PCM.PRESCRIPTION" (
         prescription_id   number(10) not null,
         dosage            varchar2(50 byte) not null,
         frequency          varchar2(50 byte) not null,
         prescription_date date not null,
         duration_days number(3),
         status            varchar2(20 byte) not null,
         appointment_id       number(10) not null,
         patient_id        number(10) not null,
         medication_id     number(10) not null
      )';

   dbms_output.put_line('prescription table created');

   execute immediate 'alter table "PCM.PRESCRIPTION" add constraint "prescription_pk" primary key ( prescription_id )';
   dbms_output.put_line('prescription primary key constraint added');
   execute immediate 'alter table "PCM.PRESCRIPTION" add constraint "prescription_status_check" check ( status in ( ''Active'', ''Completed'', ''Voided'' ) )';
   dbms_output.put_line('prescription status check constraint added');
   
   
   -- prescription table
   begin
      execute immediate 'drop table "PCM.PRESCRIPTION_ORDER" cascade constraints';
      dbms_output.put_line('prescription table dropped');
   exception when others then
   if sqlcode != -942 then  -- does not care about table does not exist error
raise; end if; 
end;

   execute immediate '
      create table "PCM.PRESCRIPTION_ORDER" (
         prescription_order_id   number(10) not null,
         quantity            number(10) not null,
         cost         number(8,2) not null,
         prescription_id   number(10) not null,
         medication_id   number(10) not null
      )';

   dbms_output.put_line('prescription order table created');
   execute immediate 'alter table "PCM.PRESCRIPTION_ORDER" add constraint "prescription_order_pk" primary key ( prescription_order_id )';
   dbms_output.put_line('prescription primary key constraint added');


   -- foreign key constraints
   
   execute immediate 'alter table "PCM.APPOINTMENT" add constraint appointment_appointment_fk foreign key ( follow_up_appointment_id ) references "PCM.APPOINTMENT" ( appointment_id )';
   execute immediate 'alter table "PCM.APPOINTMENT" add constraint appointment_doctor_fk foreign key ( doctor_id ) references "PCM.DOCTOR" ( doctor_id )';
   execute immediate 'alter table "PCM.APPOINTMENT" add constraint appointment_patient_fk foreign key ( patient_id ) references "PCM.PATIENT" ( patient_id )';
   execute immediate 'alter table "PCM.BILLING" add constraint billing_appointment_fk foreign key ( appointment_id ) references "PCM.APPOINTMENT" ( appointment_id )';
   execute immediate 'alter table "PCM.MEDICATION" add constraint medication_pharmacy_fk foreign key ( pharmacy_id ) references "PCM.PHARMACY" ( pharmacy_id )';
   execute immediate 'alter table "PCM.PRESCRIPTION_ORDER" add constraint order_medication_fk foreign key ( medication_id ) references "PCM.MEDICATION" ( medication_id )';
   execute immediate 'alter table "PCM.PRESCRIPTION_ORDER" add constraint order_prescription_fk foreign key ( prescription_id ) references "PCM.PRESCRIPTION" ( prescription_id )';
   execute immediate 'alter table "PCM.PATIENT" add constraint patient_doctor_fk foreign key ( primary_doctor_id ) references "PCM.DOCTOR" ( doctor_id )';
   execute immediate 'alter table "PCM.PRESCRIPTION" add constraint prescription_appointment_fk foreign key ( appointment_id ) references "PCM.APPOINTMENT" ( appointment_id )';
   execute immediate 'alter table "PCM.PRESCRIPTION" add constraint prescription_patient_fk foreign key ( patient_id ) references "PCM.PATIENT" ( patient_id )';


   dbms_output.put_line('foreign key constraints added');

end; 
/

-- CLINIC_ADMIN USER
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.APPOINTMENT" TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.BILLING" TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.DOCTOR" TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.MEDICATION" TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.PATIENT" TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.PHARMACY" TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.PRESCRIPTION" TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.PRESCRIPTION_ORDER" TO CLINIC_ADMIN;
GRANT SELECT, UPDATE, INSERT, DELETE ON "PCM.MEDICATION" TO CLINIC_ADMIN;



-- DOCTOR

GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.PRESCRIPTION" TO DOCTOR;
GRANT SELECT ON "PCM.PATIENT" TO DOCTOR;
GRANT SELECT ON "PCM.BILLING" TO DOCTOR;
GRANT SELECT, UPDATE ON "PCM.APPOINTMENT" TO DOCTOR;



-- PATIENT
GRANT SELECT, UPDATE ON "PCM.PATIENT" TO PATIENT;
GRANT SELECT, UPDATE ON "PCM.APPOINTMENT" TO PATIENT;
GRANT SELECT, UPDATE ON "PCM.BILLING" TO PATIENT;
GRANT SELECT ON "PCM.PRESCRIPTION" TO PATIENT;


-- RECEPTIONIST
GRANT SELECT, INSERT, UPDATE ON "PCM.PATIENT" TO RECEPTIONIST;
GRANT SELECT, INSERT, UPDATE ON "PCM.APPOINTMENT" TO RECEPTIONIST;
GRANT SELECT ON "PCM.BILLING" TO RECEPTIONIST;


-- BILLING MANAGER 
GRANT SELECT, INSERT, UPDATE, DELETE ON "PCM.BILLING" TO BILLING_MANAGER;
GRANT SELECT ON "PCM.PATIENT" TO BILLING_MANAGER;
GRANT SELECT ON "PCM.PRESCRIPTION_ORDER" TO BILLING_MANAGER;



-- PHARMACY TECHNICIAN

GRANT SELECT ON "PCM.PRESCRIPTION" TO PHARMACY_TECHNICIAN;
GRANT SELECT, INSERT ON "PCM.PRESCRIPTION_ORDER" TO PHARMACY_TECHNICIAN;
GRANT SELECT ON "PCM.PATIENT" TO PHARMACY_TECHNICIAN;
GRANT SELECT, UPDATE, INSERT ON "PCM.MEDICATION" TO PHARMACY_TECHNICIAN;

----------DML-------

BEGIN
-- 1. Insert into DOCTOR -- 

INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (1101, 'Dr. John', 'Doe', 'Cardiology', '6175550101', 'john.doe@hospital.com', 'Boston');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (1202, 'Dr. Jane', 'Smith', 'Pediatrics', '6175550102', 'jane.smith@hospital.com', 'Boston');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (1303, 'Dr. Mark', 'Taylor', 'Dermatology', '6175550103', 'mark.taylor@hospital.com', 'Boston');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (1404, 'Dr. Emily', 'Davis', 'Neurology', '6175550104', 'emily.davis@hospital.com', 'Boston');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (1505, 'Dr. Anna', 'Williams', 'Oncology', '6175550105', 'anna.williams@hospital.com', 'Boston');

INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (2101, 'Dr. Michael', 'Degaro', 'Cardiology', '2125550201', 'michael.davis@hospital.com', 'New York');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (2202, 'Dr. Elizabeth', 'Lopez', 'Pediatrics', '2125550202', 'elizabeth.lopez@hospital.com', 'New York');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (2303, 'Dr. Chris', 'Gonzalez', 'Endocrinology', '2125550203', 'chris.gonzalez@hospital.com', 'New York');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (2404, 'Dr. Jennifer', 'Wilson', 'Gynecology', '2125550204', 'jennifer.wilson@hospital.com', 'New York');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (2505, 'Dr. Robert', 'Moore', 'General Surgery', '2125550205', 'robert.moore@hospital.com', 'New York');

INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (3101, 'Dr. Alice', 'Johnson', 'Cardiology', '3125550301', 'alice.johnson@hospital.com', 'Chicago');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (3202, 'Dr. James', 'Brown', 'Neurology', '3125550302', 'james.brown@hospital.com', 'Chicago');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (3303, 'Dr. Sophia', 'Martinez', 'Pediatrics', '3125550303', 'sophia.martinez@hospital.com', 'Chicago');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (3404, 'Dr. David', 'Clark', 'Orthopedics', '3125550304', 'david.clark@hospital.com', 'Chicago');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (3505, 'Dr. Olivia', 'Taylor', 'Oncology', '3125550305', 'olivia.taylor@hospital.com', 'Chicago');

INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (4101, 'Dr. Liam', 'Harris', 'Cardiology', '4085550401', 'liam.harris@hospital.com', 'San Jose');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (4202, 'Dr. Emma', 'White', 'Pediatrics', '4085550402', 'emma.white@hospital.com', 'San Jose');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (4303, 'Dr. Noah', 'Martinez', 'Dermatology', '4085550403', 'noah.martinez@hospital.com', 'San Jose');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (4404, 'Dr. Sophia', 'Walker', 'Neurology', '4085550404', 'sophia.walker@hospital.com', 'San Jose');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (4505, 'Dr. Mason', 'Hill', 'Oncology', '4085550405', 'mason.hill@hospital.com', 'San Jose');

INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (5101, 'Dr. William', 'Young', 'Cardiology', '3235550501', 'william.young@hospital.com', 'Los Angeles');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (5202, 'Dr. Ava', 'Allen', 'Pediatrics', '3235550502', 'ava.allen@hospital.com', 'Los Angeles');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (5303, 'Dr. Isabella', 'Scott', 'Dermatology', '3235550503', 'isabella.scott@hospital.com', 'Los Angeles');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (5404, 'Dr. Ethan', 'Harris', 'Neurology', '3235550504', 'ethan.harris@hospital.com', 'Los Angeles');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (5505, 'Dr. Mia', 'Adams', 'Oncology', '3235550505', 'mia.adams@hospital.com', 'Los Angeles');

INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (6101, 'Dr. Noah', 'Johnson', 'Cardiology', '5035550601', 'noah.johnson@hospital.com', 'Portland');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (6202, 'Dr. Lucas', 'Garcia', 'Neurology', '2065550701', 'lucas.garcia@hospital.com', 'Seattle');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (6303, 'Dr. Sophia', 'Anderson', 'Oncology', '7205550801', 'sophia.anderson@hospital.com', 'Denver');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (6404, 'Dr. Olivia', 'Brown', 'Pediatrics', '7205550802', 'olivia.brown@hospital.com', 'Denver');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (6405, 'Dr. Sen', 'Gupta', 'Endocrinology', '7205550803', 'sen.gupta@hospital.com', 'Denver');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email, city)
VALUES (9999, 'N/A', 'Doctor', 'N/A', '0000000000', 'no.doctor@hospital.com', 'N/A');


  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
-- 2. Insert into PCM.PATIENTS-- 
BEGIN
-- Boston (5 Doctors)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1001, 'Amelia', 'Miller', TO_DATE('1978-03-12', 'YYYY-MM-DD'), 'Boston', '02110', '5553103101', 'amelia.miller@gmail.com', 1101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1002, 'Ethan', 'Davis', TO_DATE('1988-06-25', 'YYYY-MM-DD'), 'Boston', '02111', '5553203202', 'ethan.davis@yahoo.com', 1202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1003, 'Charlotte', 'Garcia', TO_DATE('1992-09-01', 'YYYY-MM-DD'), 'Boston', '02112', '5553303303', 'charlotte.garcia@outlook.com', 1303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1004, 'Liam', 'Wilson', TO_DATE('1990-02-18', 'YYYY-MM-DD'), 'Boston', '02113', '5553403404', 'liam.wilson@gmail.com', 1404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1005, 'Emma', 'Anderson', TO_DATE('1985-08-11', 'YYYY-MM-DD'), 'Boston', '02114', '5553503505', 'emma.anderson@yahoo.com', 1505);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- New York (5 Doctors)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1021, 'Emily', 'Brown', TO_DATE('1989-06-15', 'YYYY-MM-DD'), 'New York', '10004', '5551101101', 'emily.brown@gmail.com', 2101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1022, 'Jack', 'Harris', TO_DATE('1984-02-25', 'YYYY-MM-DD'), 'New York', '10005', '5551201202', 'jack.harris@yahoo.com', 2202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1023, 'Sophia', 'Clark', TO_DATE('1996-12-05', 'YYYY-MM-DD'), 'New York', '10006', '5551301303', 'sophia.clark@outlook.com', 2303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1024, 'Liam', 'Martin', TO_DATE('1992-08-19', 'YYYY-MM-DD'), 'New York', '10007', '5551401404', 'liam.martin@gmail.com', 2404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1025, 'Olivia', 'Moore', TO_DATE('1985-11-11', 'YYYY-MM-DD'), 'New York', '10008', '5551501505', 'olivia.moore@yahoo.com', 2505);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- Chicago (5 Doctors)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1301, 'Emily', 'Johnson', TO_DATE('1985-02-15', 'YYYY-MM-DD'), 'Chicago', '60601', '5555100101', 'emily.johnson@gmail.com', 3101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1402, 'Michael', 'Brown', TO_DATE('1990-07-18', 'YYYY-MM-DD'), 'Chicago', '60602', '5555100202', 'michael.brown@yahoo.com', 3202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1503, 'Sophia', 'Martinez', TO_DATE('1975-05-25', 'YYYY-MM-DD'), 'Chicago', '60603', '5555100303', 'sophia.martinez@outlook.com', 3303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1604, 'David', 'Clark', TO_DATE('1982-11-12', 'YYYY-MM-DD'), 'Chicago', '60604', '5555100404', 'david.clark@gmail.com', 3404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1705, 'Olivia', 'Taylor', TO_DATE('1995-03-08', 'YYYY-MM-DD'), 'Chicago', '60605', '5555100505', 'olivia.taylor@yahoo.com', 3505);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- San Jose (5 Doctors)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (2001, 'Liam', 'Harris', TO_DATE('1983-06-15', 'YYYY-MM-DD'), 'San Jose', '95101', '5555200101', 'liam.harris@gmail.com', 4101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (2002, 'Emma', 'White', TO_DATE('1992-09-19', 'YYYY-MM-DD'), 'San Jose', '95102', '5555200202', 'emma.white@yahoo.com', 4202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (2003, 'Noah', 'Martinez', TO_DATE('1979-08-23', 'YYYY-MM-DD'), 'San Jose', '95103', '5555200303', 'noah.martinez@outlook.com', 4303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (2004, 'Sophia', 'Walker', TO_DATE('1987-03-14', 'YYYY-MM-DD'), 'San Jose', '95104', '5555200404', 'sophia.walker@gmail.com', 4404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (2005, 'Mason', 'Hill', TO_DATE('1996-12-10', 'YYYY-MM-DD'), 'San Jose', '95105', '5555200505', 'mason.hill@yahoo.com', 4505);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

-- Los Angeles (5 Doctors)
BEGIN
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1026, 'Sophia', 'Gomez', TO_DATE('1980-07-22', 'YYYY-MM-DD'), 'Los Angeles', '90004', '5552102101', 'sophia.gomez@gmail.com', 5101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1027, 'Oliver', 'Taylor', TO_DATE('1983-03-15', 'YYYY-MM-DD'), 'Los Angeles', '90005', '5552202202', 'oliver.taylor@yahoo.com', 5202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1028, 'Emma', 'Johnson', TO_DATE('1991-01-09', 'YYYY-MM-DD'), 'Los Angeles', '90006', '5552302303', 'emma.johnson@outlook.com', 5303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1029, 'Lucas', 'Lee', TO_DATE('1987-10-30', 'YYYY-MM-DD'), 'Los Angeles', '90007', '5552402404', 'lucas.lee@gmail.com', 5404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1030, 'Mia', 'Brown', TO_DATE('1993-05-14', 'YYYY-MM-DD'), 'Los Angeles', '90008', '5552502505', 'mia.brown@yahoo.com', 5505);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- Portland (1 Doctor)

INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3011, 'Emily', 'Clark', TO_DATE('1985-07-15', 'YYYY-MM-DD'), 'Portland', '97201', '5035551001', 'emily.clark@gmail.com', 6101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3022, 'Michael', 'Smith', TO_DATE('1990-08-19', 'YYYY-MM-DD'), 'Portland', '97202', '5035551002', 'michael.smith@yahoo.com', 6101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3033, 'Sophia', 'Johnson', TO_DATE('1978-09-25', 'YYYY-MM-DD'), 'Portland', '97203', '5035551003', 'sophia.johnson@outlook.com', 6101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3044, 'David', 'Brown', TO_DATE('1982-12-12', 'YYYY-MM-DD'), 'Portland', '97204', '5035551004', 'david.brown@gmail.com', 6101);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3055, 'Sanjana', 'Taylor', TO_DATE('1995-06-08', 'YYYY-MM-DD'), 'Portland', '97205', '5035551005', 'sanjana.taylor@yahoo.com', 6101);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN

-- Seattle (1 Doctor)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3111, 'Ananya', 'Rao', TO_DATE('1983-03-15', 'YYYY-MM-DD'), 'Seattle', '98101', '2065552001', 'ananya.rao@gmail.com', 6202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3112, 'Rohan', 'Joshi', TO_DATE('1992-05-19', 'YYYY-MM-DD'), 'Seattle', '98102', '2065552002', 'rohan.joshi@yahoo.com', 6202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3113, 'Sanya', 'Kapoor', TO_DATE('1979-11-23', 'YYYY-MM-DD'), 'Seattle', '98103', '2065552003', 'sanya.kapoor@outlook.com', 6202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3114, 'Dev', 'Malhotra', TO_DATE('1987-01-14', 'YYYY-MM-DD'), 'Seattle', '98104', '2065552004', 'dev.malhotra@gmail.com', 6202);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3115, 'Ira', 'Mehta', TO_DATE('1996-08-10', 'YYYY-MM-DD'), 'Seattle', '98105', '2065552005', 'ira.mehta@yahoo.com', 6202);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- Denver (2 Doctors)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3211, 'Li', 'Wei', TO_DATE('1984-04-15', 'YYYY-MM-DD'), 'Denver', '80201', '7205553001', 'li.wei@gmail.com', 6303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3222, 'Wang', 'Fang', TO_DATE('1991-07-18', 'YYYY-MM-DD'), 'Denver', '80202', '7205553002', 'wang.fang@yahoo.com', 6303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3233, 'Chen', 'Ming', TO_DATE('1976-02-25', 'YYYY-MM-DD'), 'Denver', '80203', '7205553003', 'chen.ming@outlook.com', 6303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3244, 'Zhao', 'Ying', TO_DATE('1985-09-12', 'YYYY-MM-DD'), 'Denver', '80204', '7205553004', 'zhao.ying@gmail.com', 6303);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3255, 'Lin', 'Hua', TO_DATE('1994-06-08', 'YYYY-MM-DD'), 'Denver', '80205', '7205553005', 'lin.hua@yahoo.com', 6303);


  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- Additional Denver Patients for Second Doctor
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3311, 'Arjun', 'Kapoor', TO_DATE('1983-05-15', 'YYYY-MM-DD'), 'Denver', '80206', '7205554001', 'arjun.kapoor@gmail.com', 6404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3322, 'Isha', 'Verma', TO_DATE('1991-03-18', 'YYYY-MM-DD'), 'Denver', '80207', '7205554002', 'isha.verma@yahoo.com', 6404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3333, 'Rohan', 'Sharma', TO_DATE('1978-08-23', 'YYYY-MM-DD'), 'Denver', '80208', '7205554003', 'rohan.sharma@outlook.com', 6404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3344, 'Priya', 'Gupta', TO_DATE('1988-12-14', 'YYYY-MM-DD'), 'Denver', '80209', '7205554004', 'priya.gupta@gmail.com', 6404);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (3355, 'Karan', 'Mehta', TO_DATE('1995-07-10', 'YYYY-MM-DD'), 'Denver', '80210', '7205554005', 'karan.mehta@yahoo.com', 6404);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- San Antonio (1 Doctor)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (8411, 'Kavya', 'Nair', TO_DATE('1985-10-12', 'YYYY-MM-DD'), 'San Antonio', '12345', '2105553001', 'kavya.nair@gmail.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (8422, 'Manish', 'Joshi', TO_DATE('1990-06-18', 'YYYY-MM-DD'), 'San Antonio', '56789', '2105553002', 'manish.joshi@yahoo.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (8433, 'Pooja', 'Rastogi', TO_DATE('1993-03-10', 'YYYY-MM-DD'), 'San Antonio', '98675', '2105553003', 'pooja.rastogi@outlook.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (8444, 'Nitin', 'Kumar', TO_DATE('1981-07-25', 'YYYY-MM-DD'), 'San Antonio', '89060', '2105553004', 'nitin.kumar@gmail.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (8455, 'Meera', 'Patel', TO_DATE('1996-12-15', 'YYYY-MM-DD'), 'San Antonio', '34567', '2105553005', 'meera.patel@yahoo.com', 9999);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- Dallas (1 Doctor)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (9611, 'Aryan', 'Khanna', TO_DATE('1986-11-12', 'YYYY-MM-DD'), 'Dallas', '75206', '2145554101', 'aryan.khanna@gmail.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (9622, 'Sanya', 'Roy', TO_DATE('1992-03-14', 'YYYY-MM-DD'), 'Dallas', '75207', '2145554102', 'sanya.roy@yahoo.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (9633, 'Rahul', 'Kapoor', TO_DATE('1988-07-20', 'YYYY-MM-DD'), 'Dallas', '75208', '2145554103', 'rahul.kapoor@outlook.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (9644, 'Anika', 'Sen', TO_DATE('1984-05-09', 'YYYY-MM-DD'), 'Dallas', '75209', '2145554104', 'anika.sen@gmail.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (9655, 'Kabir', 'Mehta', TO_DATE('1990-02-28', 'YYYY-MM-DD'), 'Dallas', '75210', '2145554105', 'kabir.mehta@yahoo.com', 9999);


EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

BEGIN
-- Phoenix (1 Doctor)
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (7711, 'Neha', 'Sharma', TO_DATE('1984-11-12', 'YYYY-MM-DD'), 'Phoenix', '85001', '6025554101', 'neha.sharma@gmail.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (7722, 'Amit', 'Desai', TO_DATE('1990-04-15', 'YYYY-MM-DD'), 'Phoenix', '85002', '6025554102', 'amit.desai@yahoo.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (7733, 'Isha', 'Malhotra', TO_DATE('1993-08-17', 'YYYY-MM-DD'), 'Phoenix', '85003', '6025554103', 'isha.malhotra@outlook.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (7744, 'Rajat', 'Kapoor', TO_DATE('1989-01-21', 'YYYY-MM-DD'), 'Phoenix', '85004', '6025554104', 'rajat.kapoor@gmail.com', 9999);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (7755, 'Sneha', 'Iyer', TO_DATE('1996-03-18', 'YYYY-MM-DD'), 'Phoenix', '85005', '6025554105', 'sneha.iyer@yahoo.com', 9999);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
-- --- 3.  Insert into PCM.PHARMACY ------
BEGIN
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5001, 'City Health Pharmacy', 'New York', '10001', 5551112233);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5002, 'CVS Pharmacy', 'Los Angeles', '90001', 5552223344);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5003, 'WellCare Pharmacy', 'Chicago', '60601', 5553334455);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5004, 'HealthPlus Pharmacy', 'Houston', '77001', 5554445566);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5005, 'Prime Pharmacy', 'Phoenix', '85001', 5555556677);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5006, 'MediQuick Pharmacy', 'Philadelphia', '19101', 5556667788);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5007, 'GoodLife Pharmacy', 'San Antonio', '78201', 5557778899);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5008, 'RxCity Pharmacy', 'San Diego', '92101', 5558889900);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5009, 'LifeMed Pharmacy', 'Dallas', '75201', 5559990011);
INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5010, 'HealthHub Pharmacy', 'San Jose', '95101', 5551011122);


----4. Insert into PCM.MEDICATION--


INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6011, 'Cetirizine', 'tablet', 40, 4.50, TO_DATE('2025-03-31', 'YYYY-MM-DD'), 5001);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6012, 'Paracetamol', 'tablet', 0, 3.00, TO_DATE('2025-11-30', 'YYYY-MM-DD'), 5002);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6013, 'Azithromycin', 'capsule', 20, 20.00, TO_DATE('2024-06-30', 'YYYY-MM-DD'), 5003);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6014, 'Montelukast', 'tablet', 100, 8.00, TO_DATE('2024-05-31', 'YYYY-MM-DD'), 5004);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6015, 'Crocin', 'tablet', 60, 6.50, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 5005);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6016, 'Doxycycline', 'capsule', 0, 18.00, TO_DATE('2025-04-30', 'YYYY-MM-DD'), 5006);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6017, 'Fluoxetine', 'tablet', 90, 15.50, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 5007);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6018, 'Amoxicillin-Clavulanate', 'syrup', 70, 12.50, TO_DATE('2025-09-30', 'YYYY-MM-DD'), 5008);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6019, 'Hydrocortisone Cream', 'ointment', 50, 10.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 5009);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6020, 'Glimepiride', 'tablet', 60, 9.50, TO_DATE('2025-10-31', 'YYYY-MM-DD'), 5010);


INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6021, 'Ibuprofen', 'tablet', 40, 6.00, TO_DATE('2025-12-15', 'YYYY-MM-DD'), 5001);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6022, 'Chlorhexidine', 'capsule', 30, 7.50, TO_DATE('2024-07-30', 'YYYY-MM-DD'), 5002);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6023, 'Cheston', 'syrup', 100, 3.00, TO_DATE('2024-11-30', 'YYYY-MM-DD'), 5003);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6024, 'Vitamin D', 'capsule', 80, 11.00, TO_DATE('2025-02-15', 'YYYY-MM-DD'), 5004);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6025, 'Calamine', 'capsule', 45, 5.00, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 5005);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6026, 'Propranolol', 'tablet', 35, 8.00, TO_DATE('2025-03-31', 'YYYY-MM-DD'), 5006);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6027, 'Loratadine', 'tablet', 0, 6.00, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 5007);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6028, 'Insulin Glargine', 'injection', 40, 30.00, TO_DATE('2025-08-31', 'YYYY-MM-DD'), 5008);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6029, 'Zinc Oxide Cream', 'ointment', 25, 12.00, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 5009);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6030, 'Becadexamin', 'capsule', 0, 10.50, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 5010);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6031, 'Paracetamol', 'tablet', 100, 5.50, TO_DATE('2025-03-31', 'YYYY-MM-DD'), 5001);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6032, 'Betadine', 'antiseptic', 0, 12.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 5002);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6033, 'Cetrizine', 'tablet', 90, 6.50, TO_DATE('2025-07-30', 'YYYY-MM-DD'), 5003);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6034, 'Tetanus Vaccine', 'injection', 20, 20.00, TO_DATE('2024-08-15', 'YYYY-MM-DD'), 5004);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6035, 'Cough Drops', 'lozenges', 200, 4.00, TO_DATE('2025-09-01', 'YYYY-MM-DD'), 5005);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6036, 'Saline Nasal Spray', 'drops', 0, 8.00, TO_DATE('2025-11-30', 'YYYY-MM-DD'), 5006);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6037, 'Amoxicillin', 'capsule', 0, 7.50, TO_DATE('2025-02-28', 'YYYY-MM-DD'), 5007);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6038, 'Hydrocodone', 'syrup', 80, 15.00, TO_DATE('2024-11-15', 'YYYY-MM-DD'), 5008);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6039, 'Lidocaine', 'ointment', 60, 9.00, TO_DATE('2025-01-31', 'YYYY-MM-DD'), 5009);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6040, 'Bandaid XL', 'bandaid', 250, 3.00, TO_DATE('2025-04-30', 'YYYY-MM-DD'), 5010);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6041, 'Tingine', 'aspirins', 10, 5.00, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 5001);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6042, 'Cetirizine Syrup', 'syrup', 0, 10.00, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 5002);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6043, 'Erythromycin', 'tablet', 0, 6.00, TO_DATE('2025-10-15', 'YYYY-MM-DD'), 5003);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6044, 'Vitamin C Chewable', 'tablet', 100, 4.50, TO_DATE('2025-12-01', 'YYYY-MM-DD'), 5004);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6045, 'Chlorhexidine', 'oral rinse', 60, 11.00, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 5005);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6046, 'Insulin Aspart', 'injection', 45, 25.00, TO_DATE('2025-01-31', 'YYYY-MM-DD'), 5006);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6047, 'Zinc Tablets', 'tablet', 200, 7.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 5007);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6048, 'Acyclovir', 'ointment', 40, 9.50, TO_DATE('2025-03-15', 'YYYY-MM-DD'), 5008);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6049, 'Riboflavin', 'capsule', 30, 5.00, TO_DATE('2025-05-01', 'YYYY-MM-DD'), 5009);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6050, 'Probiotic', 'capsule', 40, 10.00, TO_DATE('2024-08-31', 'YYYY-MM-DD'), 5010); 

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6051, 'Cherry Lozenges', 'lozenges', 120, 3.50, TO_DATE('2024-11-15', 'YYYY-MM-DD'), 5001);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6052, 'Eucalyptus Lozenges', 'lozenges', 0, 4.00, TO_DATE('2025-02-28', 'YYYY-MM-DD'), 5002);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6053, 'Sugar-Free Lozenges', 'lozenges', 75, 4.50, TO_DATE('2025-08-31', 'YYYY-MM-DD'), 5003); 

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6054, 'Buffered Aspirin', 'aspirins', 80, 6.00, TO_DATE('2025-04-30', 'YYYY-MM-DD'), 5004);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6055, 'Enteric Coated Aspirin', 'aspirins', 60, 7.00, TO_DATE('2025-10-31', 'YYYY-MM-DD'), 5005);


-- 5. Insert into PCM.APPOINTMENTS--

--Completed ---

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1001, TO_DATE('2024-11-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-11-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1001, 1101, 'completed', 'Routine Check-up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1002, TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-11-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1002, 1202, 'completed', 'Migraine Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1003, TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-11-20 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1003, 1303, 'completed', 'Asthma Treatment Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1004, TO_DATE('2024-11-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-11-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1004, 1404, 'completed', 'Post-Surgery Consultation', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1005, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1005, 1505, 'completed', 'Dental Check-up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1006, TO_DATE('2024-12-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-05 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1021, 2101, 'completed', 'Skin Allergy Treatment', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1007, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1022, 2202, 'completed', 'Orthopedic Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1008, TO_DATE('2024-12-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1023, 2303, 'completed', 'Annual Health Check-up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1009, TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-20 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1024, 2404, 'completed', 'Eye Examination', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(1010, TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1025, 2505, 'completed', 'Hearing Check-up', 'Not Applicable', NULL);

--Scheduled-- 

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2001, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2001, 3101, 'scheduled', 'Cardiology Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2002, TO_DATE('2024-12-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2002, 3202, 'scheduled', 'Pediatrics Check-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2003, TO_DATE('2024-12-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-03 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2003, 3303, 'scheduled', 'Endocrinology Consultation', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2004, TO_DATE('2024-12-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2004, 3404, 'scheduled', 'Gynecology Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2005, TO_DATE('2024-12-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-05 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2005, 3505, 'scheduled', 'General Surgery Pre-Check', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2006, TO_DATE('2024-12-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3011, 4101, 'scheduled', 'Routine Eye Check-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2007, TO_DATE('2024-12-07', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-07 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3022, 4202, 'scheduled', 'Orthopedic Consultation', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2008, TO_DATE('2024-12-08', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-08 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3033, 4303, 'scheduled', 'Post-Surgery Check-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2009, TO_DATE('2024-12-09', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-09 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3044, 4404, 'scheduled', 'Mental Health Counseling', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2010, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3055, 4505, 'scheduled', 'Annual Dental Cleaning', 'Not Applicable', NULL); 

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2011, TO_DATE('2024-12-11', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-11 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3111, 5202, 'scheduled', 'Diabetes Management Check', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2012, TO_DATE('2024-12-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3112, 5303, 'scheduled', 'Physical Therapy Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2013, TO_DATE('2024-12-13', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-13 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3113, 5404, 'scheduled', 'Dermatology Consultation', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2014, TO_DATE('2024-12-14', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-14 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3114, 5505, 'scheduled', 'Neurology Evaluation', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2015, TO_DATE('2024-12-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-15 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3115, 6202, 'scheduled', 'Sports Injury Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2016, TO_DATE('2024-12-16', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-16 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 3222, 6303, 'scheduled', 'Prenatal Consultation', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2017, TO_DATE('2024-12-17', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-17 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 3233, 6404, 'scheduled', 'Nutrition Counseling', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2018, TO_DATE('2024-12-18', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-18 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3244, 9999, 'scheduled', 'Orthodontic Consultation', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2019, TO_DATE('2024-12-19', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3255, 3101, 'scheduled', 'Psychiatry Follow-Up', 'Not Applicable', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(2020, TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-20 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), 3311, 5202, 'scheduled', 'Pediatrics Wellness Check', 'Not Applicable', NULL);

--canceled--
-- Original canceled appointments with follow-up references
INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(5011, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1001, 1101, 'canceled', 'Routine Cardiology Check-Up', 'Doctor Unavailable', null);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(5012, TO_DATE('2024-12-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-02 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1002, 1202, 'canceled', 'Neurology Follow-Up', 'Patient Rescheduled', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(5013, TO_DATE('2024-12-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-03 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1003, 1303, 'canceled', 'Derma Cons', 'Emerg Cancel', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(5014, TO_DATE('2024-12-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1004, 1404, 'canceled', 'Ortho Follow-Up', 'Doc Emerg', NULL);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(5015, TO_DATE('2024-12-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-05 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1005, 1505, 'canceled', 'Psych Follow-Up', 'Pat Canc', NULL);

-- Follow-up appointments for canceled appointments
INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(6001, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1001, 1101, 'scheduled', 'Follow-Up for Cardiology Check-Up', 'Not Applicable', 5011);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(6002, TO_DATE('2024-12-11', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-11 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1002, 1202, 'scheduled', 'Follow-Up for Neurology', 'Not Applicable', 5012);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(6003, TO_DATE('2024-12-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1003, 1303, 'scheduled', 'Follow-Up for Dermatology', 'Not Applicable', 5013);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(6004, TO_DATE('2024-12-13', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-13 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1004, 1404, 'scheduled', 'Follow-Up for Orthopedics', 'Not Applicable', 5014);

INSERT INTO "PCM.APPOINTMENT" 
(appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, cancellation_reason, follow_up_appointment_id)
VALUES 
(6005, TO_DATE('2024-12-14', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-12-14 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1005, 1505, 'scheduled', 'Follow-Up for Psychiatry', 'Not Applicable', 5015);


EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/ 


BEGIN
INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (8457, 150.00, 'paid', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 1001);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (9124, 200.00, 'pending', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 1002);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (7423, 120.00, 'paid', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 1003);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (1289, 175.00, 'paid', TO_DATE('2023-11-25', 'YYYY-MM-DD'), 1004);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (6571, 250.00, 'paid', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 1005);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4598, 90.00, 'pending', TO_DATE('2023-12-05', 'YYYY-MM-DD'), 1006);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (8932, 135.00, 'paid', TO_DATE('2023-12-10', 'YYYY-MM-DD'), 1007);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (5467, 220.00, 'pending', TO_DATE('2023-12-15', 'YYYY-MM-DD'), 1008);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (3349, 175.00, 'paid', TO_DATE('2023-12-20', 'YYYY-MM-DD'), 1009);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (7825, 300.00, 'pending', TO_DATE('2023-12-25', 'YYYY-MM-DD'), 1010);

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/ 


--7. Insert into PRESCRIPTION--
BEGIN 

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9123, '500 mg', 'Twice Daily', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 10, 'Active', 1001, 6011, 1001);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9124, '500 mg', 'Twice Daily', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 10, 'Active', 1001, 6012, 1001);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9125, '500 mg', 'Twice Daily', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 10, 'Active', 1001, 6013, 1001);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9127, '500 mg', 'Twice Daily', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 10, 'Active', 1001, 6014, 1001);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9128, '500 mg', 'Twice Daily', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 10, 'Active', 1001, 6015, 1001);


INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (8345, '250 mg', 'Once Daily', TO_DATE('2023-11-12', 'YYYY-MM-DD'), 7, 'Active', 1002, 6044, 1002);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (8346, '250 mg', 'Once Daily', TO_DATE('2023-11-12', 'YYYY-MM-DD'), 7, 'Active', 1002, 6045, 1002);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (8347, '250 mg', 'Once Daily', TO_DATE('2023-11-12', 'YYYY-MM-DD'), 7, 'Active', 1002, 6046, 1002);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7643, '100 mg', 'Every 8 Hours', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 5, 'Active', 1003, 6047, 1003);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7644, '100 mg', 'Every 8 Hours', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 5, 'Active', 1003, 6048, 1003);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9812, '200 mg', 'Twice Daily', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 14, 'Active', 1004, 6049, 1004);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9813, '200 mg', 'Twice Daily', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 14, 'Active', 1004, 6050, 1004);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9814, '200 mg', 'Twice Daily', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 14, 'Active', 1004, 6054, 1004); 

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9815, '200 mg', 'Twice Daily', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 14, 'Active', 1004, 6055, 1004);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (4571, '300 mg', 'Once Daily', TO_DATE('2023-12-03', 'YYYY-MM-DD'), 10, 'Active', 1005, 6015, 1005);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (3254, '50 mg', 'Once Daily', TO_DATE('2023-12-05', 'YYYY-MM-DD'), 5, 'Active', 1021, 6016, 2001);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (6482, '75 mg', 'Every Morning', TO_DATE('2023-12-07', 'YYYY-MM-DD'), 7, 'Active', 1022, 6017, 2002);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7391, '20 mg', 'Twice Daily', TO_DATE('2023-12-10', 'YYYY-MM-DD'), 15, 'Active', 1023, 6018, 2003);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (8625, '40 mg', 'Once Daily', TO_DATE('2023-12-12', 'YYYY-MM-DD'), 10, 'Active', 1024, 6019, 2004);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (4827, '150 mg', 'Once Daily', TO_DATE('2023-12-14', 'YYYY-MM-DD'), 10, 'Active', 1025, 6020, 2005);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (5932, '250 mg', 'Twice Daily', TO_DATE('2023-12-16', 'YYYY-MM-DD'), 14, 'Active', 1301, 6021, 2006);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7293, '75 mg', 'Once Daily', TO_DATE('2023-12-18', 'YYYY-MM-DD'), 5, 'Active', 1402, 6022, 2007);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7295, '75 mg', 'Once Daily', TO_DATE('2023-12-18', 'YYYY-MM-DD'), 5, 'Active', 1402, 6023, 2007);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7296, '75 mg', 'Once Daily', TO_DATE('2023-12-18', 'YYYY-MM-DD'), 5, 'Active', 1402, 6022, 2007);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7297, '75 mg', 'Once Daily', TO_DATE('2023-12-18', 'YYYY-MM-DD'), 5, 'Active', 1402, 6022, 2007);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7298, '75 mg', 'Once Daily', TO_DATE('2023-12-18', 'YYYY-MM-DD'), 5, 'Active', 1402, 6022, 2007);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7299, '75 mg', 'Once Daily', TO_DATE('2023-12-18', 'YYYY-MM-DD'), 5, 'Active', 1402, 6022, 2007);


INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (8514, '500 mg', 'Every 12 Hours', TO_DATE('2023-12-20', 'YYYY-MM-DD'), 7, 'Active', 1503, 6023, 2008);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (9648, '400 mg', 'Twice Daily', TO_DATE('2023-12-22', 'YYYY-MM-DD'), 14, 'Active', 1604, 6024, 2009);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (3417, '300 mg', 'Once Daily', TO_DATE('2023-12-25', 'YYYY-MM-DD'), 10, 'Active', 1705, 6025, 2010);

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

-- Insert into PCM.PRESCRIPTION_0RDERS--

BEGIN
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8745, 30, 150.00, 9123, 6011);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9183, 14, 98.00, 8345, 6012);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (7621, 21, 315.00, 7643, 6013);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8492, 1, 20.00, 9812, 6014);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9357, 10, 85.00, 4571, 6015);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (6834, 30, 180.00, 3254, 6016);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (7941, 60, 720.00, 6482, 6017);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8567, 28, 280.00, 7391, 6018);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9723, 30, 345.00, 8625, 6019);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8125, 15, 375.00, 4827, 6020);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (7398, 25, 400.00, 5932, 6021);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8921, 20, 150.00, 7293, 6022);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (6645, 12, 100.00, 8514, 6023);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9862, 18, 225.00, 9648, 6024);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (7019, 8, 150.00, 3417, 6025); 

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9101, 20, 80.00, 9123, 6011);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9102, 15, 60.00, 8345, 6011);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9103, 10, 40.00, 7643, 6011);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9104, 25, 100.00, 9812, 6011);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9105, 30, 120.00, 4571, 6011);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9201, 20, 70.00, 3254, 6012);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9202, 10, 35.00, 6482, 6012);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9203, 30, 105.00, 7391, 6012);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9301, 15, 90.00, 8625, 6013);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9302, 25, 125.00, 4827, 6013);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9303, 20, 100.00, 5932, 6013);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9304, 18, 72.00, 7293, 6013);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9401, 22, 88.00, 8514, 6014);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9402, 12, 48.00, 9648, 6014);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9501, 10, 60.00, 3417, 6015);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9502, 15, 90.00, 9123, 6015);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9503, 18, 108.00, 8345, 6015);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9504, 25, 150.00, 7643, 6015);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9505, 20, 120.00, 9812, 6015);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9601, 30, 180.00, 4571, 6016);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9602, 40, 240.00, 3254, 6016);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9603, 25, 150.00, 6482, 6016); 

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9701, 30, 120.00, 9123, 6027);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9702, 20, 80.00, 8345, 6027);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9703, 25, 100.00, 7643, 6027);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9704, 15, 60.00, 9812, 6027);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9801, 10, 300.00, 4571, 6028);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9802, 15, 450.00, 3254, 6028);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9901, 8, 96.00, 6482, 6029);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9902, 10, 120.00, 7391, 6029);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (9903, 12, 144.00, 8625, 6029);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10001, 20, 210.00, 4827, 6030);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10002, 25, 250.00, 5932, 6030);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10003, 30, 300.00, 7293, 6030);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10004, 10, 100.00, 8514, 6030);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10005, 15, 150.00, 9648, 6030);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10101, 30, 90.00, 3417, 6031);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10102, 20, 60.00, 9123, 6031);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10103, 10, 30.00, 8345, 6031);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10201, 5, 60.00, 7643, 6032);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10202, 8, 96.00, 9812, 6032);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10203, 12, 144.00, 4571, 6032);
INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (10204, 15, 180.00, 3254, 6032);


EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

SELECT * FROM "PCM.DOCTOR";
SELECT * FROM "PCM.PATIENT";
SELECT * FROM "PCM.PHARMACY";
SELECT * FROM "PCM.MEDICATION";
SELECT * FROM "PCM.APPOINTMENT";
SELECT * FROM "PCM.BILLING";
SELECT * FROM "PCM.PRESCRIPTION";
SELECT * FROM "PCM.PRESCRIPTION_ORDER"; 



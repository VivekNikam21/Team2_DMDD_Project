-- Check if the tables exist before inserting data to avoid errors
BEGIN
  -- Insert into DOCTOR
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2001, 'Sarah', 'Johnson', 'Cardiology', 5551231234, 'sarah.johnson@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2002, 'James', 'Brown', 'Neurology', 5552342345, 'james.brown@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2003, 'Emily', 'Williams', 'Pediatrics', 5553453456, 'emily.williams@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2004, 'David', 'Garcia', 'Orthopedics', 5554564567, 'david.garcia@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2005, 'Linda', 'Martinez', 'Oncology', 5555675678, 'linda.martinez@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2006, 'Michael', 'Davis', 'Dermatology', 5556786789, 'michael.davis@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2007, 'Elizabeth', 'Lopez', 'Psychiatry', 5557897890, 'elizabeth.lopez@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2008, 'Chris', 'Gonzalez', 'Endocrinology', 5558908901, 'chris.gonzalez@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2009, 'Jennifer', 'Wilson', 'Gynecology', 5559019012, 'jennifer.wilson@hospital.com');
INSERT INTO "PCM.DOCTOR" (doctor_id, first_name, last_name, specialization, contact_number, email)
VALUES (2010, 'Robert', 'Moore', 'General Surgery', 5550120123, 'robert.moore@hospital.com');

  
  -- Insert into PATIENT
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1001, 'John', 'Doe', TO_DATE('1985-07-13', 'YYYY-MM-DD'), 'New York', '10001', 5551234567, 'johndoe@example.com', 2001);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1002, 'Jane', 'Smith', TO_DATE('1992-09-15', 'YYYY-MM-DD'), 'Los Angeles', '90001', 5552345678, 'janesmith@example.com', 2002);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1003, 'Alice', 'Johnson', TO_DATE('1978-11-05', 'YYYY-MM-DD'), 'Chicago', '60601', 5553456789, 'alicejohnson@example.com', 2003);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1004, 'Bob', 'Williams', TO_DATE('1965-05-18', 'YYYY-MM-DD'), 'Houston', '77001', 5554567890, 'bobwilliams@example.com', 2004);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1005, 'Maria', 'Garcia', TO_DATE('1988-12-30', 'YYYY-MM-DD'), 'Phoenix', '85001', 5555678901, 'mariagarcia@example.com', 2005);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1006, 'Michael', 'Brown', TO_DATE('1975-04-22', 'YYYY-MM-DD'), 'Philadelphia', '19101', 5556789012, 'michaelbrown@example.com', 2006);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1007, 'Linda', 'Davis', TO_DATE('1995-03-11', 'YYYY-MM-DD'), 'San Antonio', '78201', 5557890123, 'lindadavis@example.com', 2007);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1008, 'James', 'Martinez', TO_DATE('1982-07-29', 'YYYY-MM-DD'), 'San Diego', '92101', 5558901234, 'jamesmartinez@example.com', 2008);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1009, 'Barbara', 'Lopez', TO_DATE('1999-01-10', 'YYYY-MM-DD'), 'Dallas', '75201', 5559012345, 'barbaralopez@example.com', 2009);
INSERT INTO "PCM.PATIENT" (patient_id, first_name, last_name, date_of_birth, city, zipcode, contact_number, email, primary_doctor_id)
VALUES (1010, 'Robert', 'Gonzalez', TO_DATE('1963-08-17', 'YYYY-MM-DD'), 'San Jose', '95101', 5550123456, 'robertgonzalez@example.com', 2010);

  
  -- Insert into PHARMACY
  INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5001, 'City Health Pharmacy', 'New York', '10001', 5551112233);

INSERT INTO "PCM.PHARMACY" (pharmacy_id, pharmacy_name, city, zipcode, contact_number)
VALUES (5002, 'Sunrise Pharmacy', 'Los Angeles', '90001', 5552223344);

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
  
  -- Insert into MEDICATION
  INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6001, 'Aspirin', 'tablet', 150, 5.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 5001);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6002, 'Ibuprofen', 'tablet', 200, 7.00, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 5002);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6003, 'Amoxicillin', 'capsule', 100, 15.00, TO_DATE('2024-03-31', 'YYYY-MM-DD'), 5003);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6004, 'Albuterol', 'injection', 50, 20.00, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 5004);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6005, 'Cough Syrup', 'syrup', 75, 8.50, TO_DATE('2025-01-31', 'YYYY-MM-DD'), 5005);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6006, 'Lisinopril', 'tablet', 120, 6.00, TO_DATE('2025-04-30', 'YYYY-MM-DD'), 5006);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6007, 'Metformin', 'tablet', 80, 12.00, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 5007);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6008, 'Prednisone', 'tablet', 90, 10.00, TO_DATE('2025-07-31', 'YYYY-MM-DD'), 5008);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6009, 'Omeprazole', 'capsule', 110, 11.50, TO_DATE('2025-02-28', 'YYYY-MM-DD'), 5009);

INSERT INTO "PCM.MEDICATION" (medication_id, name, medication_type, stock_level, price, expiration_date, pharmacy_id)
VALUES (6010, 'Insulin', 'injection', 60, 25.00, TO_DATE('2024-08-31', 'YYYY-MM-DD'), 5010);

  
  -- Insert into APPOINTMENT
INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3001, TO_DATE('2024-11-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1001, 2001, 'completed', 'Regular Check-up', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3002, TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1002, 2002, 'scheduled', 'Migraine Consultation', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3003, TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-20 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1003, 2003, 'completed', 'Asthma Follow-Up', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3004, TO_DATE('2024-11-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1001, 2001, 'scheduled', 'Follow-Up for Check-up', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3005, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1005, 2005, 'canceled', 'Cancer Screening Follow-Up', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3006, TO_DATE('2024-12-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-05 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1006, 2006, 'scheduled', 'Skin Rash Evaluation', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3007, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1007, 2007, 'completed', 'Mental Health Follow-Up', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3008, TO_DATE('2024-12-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1003, 2003, 'scheduled', 'Follow-Up for Asthma', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3009, TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-20 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1009, 2009, 'completed', 'Annual Gynecological Exam', NULL);

INSERT INTO "PCM.APPOINTMENT" (appointment_id, scheduled_date, scheduled_time, patient_id, doctor_id, status, treatment_plan, follow_up_appointment_id)
VALUES (3010, TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1006, 2006, 'scheduled', 'Follow-Up for Skin Rash', NULL);


  -- Insert into BILLING
INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4001, 150.00, 'paid', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 3001);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4002, 200.00, 'pending', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 3002);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4003, 120.00, 'paid', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 3003);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4004, 175.00, 'paid', TO_DATE('2023-11-25', 'YYYY-MM-DD'), 3004);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4005, 250.00, 'paid', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 3005);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4006, 90.00, 'pending', TO_DATE('2023-12-05', 'YYYY-MM-DD'), 3006);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4007, 135.00, 'paid', TO_DATE('2023-12-10', 'YYYY-MM-DD'), 3007);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4008, 220.00, 'pending', TO_DATE('2023-12-15', 'YYYY-MM-DD'), 3008);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4009, 175.00, 'paid', TO_DATE('2023-12-20', 'YYYY-MM-DD'), 3009);

INSERT INTO "PCM.BILLING" (bill_id, total_amount, payment_status, date_issued, appointment_id)
VALUES (4010, 300.00, 'pending', TO_DATE('2023-12-25', 'YYYY-MM-DD'), 3010);


  -- Insert into PRESCRIPTION
INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7001, '500 mg', 'Twice Daily', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 10, 'Active', 1001, 6001, 3001);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7002, '200 mg', 'Once Daily', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 7, 'Completed', 1002, 6002, 3002);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7003, '250 mg', 'Every 8 Hours', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 5, 'Active', 1003, 6003, 3003);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7004, '2 puffs', 'As Needed', TO_DATE('2023-11-25', 'YYYY-MM-DD'), 15, 'Active', 1004, 6004, 3004);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7005, '10 mL', 'Every 6 Hours', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 5, 'Voided', 1005, 6005, 3005);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7006, '20 mg', 'Once Daily', TO_DATE('2023-12-05', 'YYYY-MM-DD'), 30, 'Completed', 1006, 6006, 3006);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7007, '500 mg', 'Twice Daily', TO_DATE('2023-12-10', 'YYYY-MM-DD'), 10, 'Active', 1007, 6007, 3007);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7008, '20 mg', 'Every Morning', TO_DATE('2023-12-15', 'YYYY-MM-DD'), 14, 'Completed', 1008, 6008, 3008);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7009, '40 mg', 'Once Daily', TO_DATE('2023-12-20', 'YYYY-MM-DD'), 7, 'Active', 1009, 6009, 3009);

INSERT INTO "PCM.PRESCRIPTION" (prescription_id, dosage, frequency, prescription_date, duration_days, status, patient_id, medication_id, appointment_id)
VALUES (7010, '15 units', 'Before Meals', TO_DATE('2023-12-25', 'YYYY-MM-DD'), 30, 'Active', 1010, 6010, 3010);

  
  -- Insert into PRESCRIPTION_ORDER
  INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8001, 30, 150.00, 7001, 6001);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8002, 14, 98.00, 7002, 6002);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8003, 21, 315.00, 7003, 6003);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8004, 1, 20.00, 7004, 6004);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8005, 10, 85.00, 7005, 6005);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8006, 30, 180.00, 7006, 6006);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8007, 60, 720.00, 7007, 6007);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8008, 28, 280.00, 7008, 6008);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8009, 30, 345.00, 7009, 6009);

INSERT INTO "PCM.PRESCRIPTION_ORDER" (prescription_order_id, quantity, cost, prescription_id, medication_id)
VALUES (8010, 15, 375.00, 7010, 6010);

  
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Handle unique constraint violation (in case of duplicate data)
    NULL;  -- No action taken, as the record already exists
  WHEN OTHERS THEN
    -- Handle any other exceptions (log the error or raise a custom message)
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

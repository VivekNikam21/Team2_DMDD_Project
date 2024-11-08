CREATE OR REPLACE VIEW Medication_Stock_Status AS
SELECT 
    medication_id,
    name AS medication_name,
    medication_type,
    stock_level,
    price,
    expiration_date,
    CASE 
        WHEN stock_level < 10 THEN 'Below Threshold'
        ELSE 'Sufficient'
    END AS Stock_Status
FROM 
    "PCM.MEDICATION";


CREATE OR REPLACE VIEW Doctors_Patient_Load_View AS
SELECT 
    d.doctor_id,
    d.first_name || ' ' || d.last_name AS doctor_name,
    d.specialization,
    COUNT(p.patient_id) AS total_patients
FROM 
    "PCM.DOCTOR" d
LEFT JOIN 
    "PCM.PATIENT" p ON d.doctor_id = p.primary_doctor_id
GROUP BY 
    d.doctor_id, d.first_name, d.last_name, d.specialization
ORDER BY 
    total_patients DESC;


CREATE OR REPLACE VIEW Patient_History_View AS
SELECT
    p.Patient_ID,
    p.First_Name,
    p.Last_Name,
    p.Date_of_Birth,
    m.Medication_ID,
    a.Appointment_ID,
    a.Doctor_ID,
    a.Treatment_Plan AS Treatment,
    pr.Prescription_ID,
    pr.Prescription_Date
FROM
    "PCM.PATIENT" p
LEFT JOIN 
    "PCM.APPOINTMENT" a ON p.Patient_ID = a.Patient_ID
LEFT JOIN 
    "PCM.PRESCRIPTION" pr ON p.Patient_ID = pr.Patient_ID AND a.Appointment_ID = pr.Appointment_ID
LEFT JOIN 
    "PCM.MEDICATION" m ON pr.Medication_ID = m.Medication_ID;


CREATE OR REPLACE VIEW Prescription_Summary_View AS
SELECT
    pr.Prescription_ID,
    pr.Patient_ID,
    m.Name AS Medication_Name,
    pr.Dosage,
    pr.Frequency,
    pr.Prescription_Date AS Start_Date,
    pr.Prescription_Date + pr.Duration_Days AS End_Date,
    a.Doctor_ID AS Prescribing_Doctor_ID
FROM
    "PCM.PRESCRIPTION" pr
JOIN 
    "PCM.MEDICATION" m ON pr.Medication_ID = m.Medication_ID
JOIN 
    "PCM.APPOINTMENT" a ON pr.Appointment_ID = a.Appointment_ID;


CREATE OR REPLACE VIEW Medical_History_View AS
SELECT
    p.Patient_ID,
    p.First_Name,
    p.Last_Name,
    p.Date_of_Birth,
    m.Medication_ID,
    m.Name AS Medication_Name,
    a.Appointment_ID,
    a.Doctor_ID,
    d.First_Name AS Doctor_First_Name,
    d.Last_Name AS Doctor_Last_Name,
    a.Treatment_Plan,
    pr.Prescription_ID,
    pr.Prescription_Date,
    pr.Dosage,
    pr.Frequency,
    pr.Status AS Prescription_Status,
    pr.Duration_Days
FROM
    "PCM.PATIENT" p
LEFT JOIN 
    "PCM.APPOINTMENT" a ON p.Patient_ID = a.Patient_ID
LEFT JOIN 
    "PCM.DOCTOR" d ON a.Doctor_ID = d.Doctor_ID
LEFT JOIN 
    "PCM.PRESCRIPTION" pr ON p.Patient_ID = pr.Patient_ID AND a.Appointment_ID = pr.Appointment_ID
LEFT JOIN 
    "PCM.MEDICATION" m ON pr.Medication_ID = m.Medication_ID;
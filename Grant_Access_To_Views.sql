GRANT SELECT, INSERT, UPDATE, DELETE ON Medication_Stock_Status TO PHARMACY_TECHNICIAN;
GRANT SELECT ON Doctors_Patient_Load_View TO DOCTOR;
GRANT SELECT ON Doctors_Patient_Load_View TO RECEPTIONIST;
GRANT SELECT ON Patient_History_View TO DOCTOR;
GRANT SELECT ON Patient_History_View TO PATIENT;
GRANT SELECT ON Prescription_Summary_View TO DOCTOR;
GRANT SELECT ON Prescription_Summary_View TO PATIENT;
GRANT SELECT, INSERT, UPDATE ON Prescription_Summary_View TO PHARMACY_TECHNICIAN;
GRANT SELECT ON Medical_History_View TO DOCTOR;
GRANT SELECT ON Medical_History_View TO PATIENT;
GRANT SELECT, INSERT, UPDATE, DELETE ON Medication_Stock_Status TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Doctors_Patient_Load_View TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Patient_History_View TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Prescription_Summary_View TO CLINIC_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Medical_History_View TO CLINIC_ADMIN;
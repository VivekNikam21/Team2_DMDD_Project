
--Report 1 - Doctor Availability and Patient Coverage by City--
--this report automates the identification of cities with insufficient doctor availability, enabling healthcare administrators to quickly prioritize and allocate resources without manual analysis--
SELECT 
    p.city AS city_name,
    COUNT(DISTINCT p.patient_id) AS total_patients,
    COUNT(DISTINCT d.doctor_id) AS available_doctors,
    CASE 
        WHEN COUNT(DISTINCT d.doctor_id) = 0 THEN 'No Doctors in this Area - Immediate Action Required'
        WHEN COUNT(DISTINCT d.doctor_id) / NULLIF(COUNT(DISTINCT p.patient_id), 0) < 0.1 THEN 'Very Low Doctor-to-Patient Ratio - Urgent Attention Needed'
        WHEN COUNT(DISTINCT d.doctor_id) / NULLIF(COUNT(DISTINCT p.patient_id), 0) < 0.2 THEN 'Low Doctor-to-Patient Ratio - Action Needed'
        ELSE 'Sufficient Doctor-to-Patient Ratio in this Area'
    END AS alert
FROM 
    "PCM.PATIENT" p
LEFT JOIN 
    "PCM.DOCTOR" d ON p.city = d.city
GROUP BY 
    p.city
ORDER BY 
    total_patients DESC;
    
-------------------------------------------------------------------------------------------------------------------------------------------------- 

--Report 2 --- Medication Inventory and Prescription Report

--This report automates the monitoring of medication inventory and prescription activity, helping to streamline stock management and prescription tracking for efficient pharmacy operations-

SELECT 
    m.medication_id,
    m.name AS medication_name,
    m.stock_level,
    CASE 
        WHEN m.stock_level = 0 THEN 'Out of Stock'
        WHEN m.stock_level > 0 AND m.stock_level < 50 THEN 'Limited'
        WHEN m.stock_level >= 50 THEN 'In Stock'
    END AS stock_status,
    COUNT(po.prescription_order_id) AS total_orders,
    NVL(SUM(po.quantity), 0) AS total_dispensed_quantity, -- Total quantity dispensed
    NVL(COUNT(CASE WHEN p.status = 'Active' THEN 1 END), 0) AS active_prescriptions
FROM 
    "PCM.MEDICATION" m
LEFT JOIN 
    "PCM.PRESCRIPTION_ORDER" po ON m.medication_id = po.medication_id
LEFT JOIN 
    "PCM.PRESCRIPTION" p ON po.prescription_id = p.prescription_id
GROUP BY 
    m.medication_id, m.name, m.stock_level
HAVING 
    COUNT(po.prescription_order_id) > 0 -- Ensure at least one prescription order exists
ORDER BY 
    m.medication_id ASC;


-------------------------------------------------------------------------------------------------------------------------------------------------------- 

--Report - 3 --- Patient Profile Analysis  Report-- 

--The report automates the process of compiling detailed patient profiles, enabling quick insights into appointments, prescriptions, billing, and medication details for better healthcare management--
SELECT  
    p.patient_id,
    p.first_name || ' ' || p.last_name AS patient_name,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT pr.prescription_id) AS total_prescriptions,
    COUNT(DISTINCT b.bill_id) AS billing_records,
    COALESCE(TO_CHAR(MAX(a.scheduled_date), 'DD-MM-YY'), 'No appointment yet') AS last_appointment_date,
    COUNT(DISTINCT m.medication_id) AS total_medications_prescribed,
    COALESCE(LISTAGG(m.name, ', ') WITHIN GROUP (ORDER BY m.name), 'No Medications') AS medications_list
FROM 
    "PCM.PATIENT" p
LEFT JOIN 
    "PCM.APPOINTMENT" a ON p.patient_id = a.patient_id
LEFT JOIN 
    "PCM.PRESCRIPTION" pr ON a.appointment_id = pr.appointment_id
LEFT JOIN 
    "PCM.BILLING" b ON a.appointment_id = b.appointment_id
LEFT JOIN 
    "PCM.MEDICATION" m ON pr.medication_id = m.medication_id
GROUP BY 
    p.patient_id, p.first_name, p.last_name
ORDER BY 
    p.patient_id ASC; 
    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

--Report 4 - Appointment Overview and Follow-Up Tracking report-- 

--This report automates the tracking and summary analysis of patient appointments, including their statuses and follow-up scheduling, enabling streamlined appointment management and visibility into patient-doctor interactions.--



SELECT 
    a.appointment_id,
    a.patient_id,
    a.doctor_id,
    a.status,
    TO_CHAR(a.scheduled_date, 'DD-MM-YYYY') AS scheduled_date,
    NVL(a.cancellation_reason, 'Not applicable') AS cancellation_reason,
    NVL(a.follow_up_appointment_id, 0) AS follow_up_appointment_id,
    NVL(TO_CHAR(f.scheduled_date, 'DD-MM-YYYY'), 'No Follow-Up') AS follow_up_date
FROM 
    "PCM.APPOINTMENT" a
LEFT JOIN 
    "PCM.APPOINTMENT" f ON a.follow_up_appointment_id = f.appointment_id
ORDER BY 
    a.appointment_id;

SELECT  
    COUNT(appointment_id) AS total_appointments,
    COUNT(CASE WHEN status = 'scheduled' THEN 1 END) AS scheduled_appointments,
    COUNT(CASE WHEN status = 'completed' THEN 1 END) AS completed_appointments,
    COUNT(CASE WHEN status = 'canceled' THEN 1 END) AS canceled_appointments,
    COUNT(CASE WHEN follow_up_appointment_id IS NOT NULL THEN 1 END) AS follow_up_appointments
FROM 
    "PCM.APPOINTMENT" a; 
    
-------------------------------------------------------------------------------------------------------------------------------------------- 


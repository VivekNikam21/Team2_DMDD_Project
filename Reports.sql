
--Report 1 -Doctor Availability and Patient Coverage by City--
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




--------------------------------------------------------------------------------------------------------------------------------------------------------


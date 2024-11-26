//Trigger 1 Conflict in appointments
CREATE OR REPLACE TRIGGER prevent_appointment_conflict
BEFORE INSERT ON "PCM.APPOINTMENT"
FOR EACH ROW
DECLARE
    conflict_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO conflict_count
    FROM "PCM.APPOINTMENT"
    WHERE (doctor_id = :NEW.doctor_id OR patient_id = :NEW.patient_id)
      AND scheduled_date = :NEW.scheduled_date
      AND scheduled_time = :NEW.scheduled_time;

    IF conflict_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Appointment conflict detected!');
    END IF;
END;
/

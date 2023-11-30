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

//Trigger 2 checking medication stock CREATE OR REPLACE TRIGGER trg_update_medication_stock
AFTER INSERT ON "PCM.PRESCRIPTION_ORDER"
FOR EACH ROW
BEGIN
   -- Update the stock level in the MEDICATION table
   UPDATE "PCM.MEDICATION"
   SET stock_level = stock_level - :NEW.quantity
   WHERE medication_id = :NEW.medication_id;

   -- Declare a variable to store the current stock level
   DECLARE
      v_remaining_stock NUMBER;
   BEGIN
      -- Fetch the updated stock level
      SELECT stock_level INTO v_remaining_stock
      FROM "PCM.MEDICATION"
      WHERE medication_id = :NEW.medication_id;

      -- Check if stock is below the threshold
      IF v_remaining_stock < 10 THEN
         DBMS_OUTPUT.PUT_LINE('Low stock: Reorder medication ID ' || :NEW.medication_id);
      END IF;
   END;
END;
/

//Trigger 3  billing amount cant exceed more than individual prices CREATE OR REPLACE TRIGGER validate_billing_total
BEFORE INSERT OR UPDATE ON "PCM.BILLING"
FOR EACH ROW
DECLARE
    calculated_total NUMBER(10, 2);
BEGIN
    -- Calculate the total charges for the associated appointment
    SELECT SUM(cost)
    INTO calculated_total
    FROM "PCM.PRESCRIPTION_ORDER"
    WHERE prescription_id IN (
        SELECT prescription_id
        FROM "PCM.PRESCRIPTION"
        WHERE appointment_id = :NEW.appointment_id
    );

    -- Validate that the total_amount does not exceed the calculated total
    IF :NEW.total_amount > calculated_total THEN
        RAISE_APPLICATION_ERROR(-20003, 'Total billing amount exceeds the sum of individual charges!');
    END IF;
END;
/

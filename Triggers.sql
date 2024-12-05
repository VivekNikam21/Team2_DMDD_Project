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

//Trigger 3  billing amount cant exceed more than individual prices
CREATE OR REPLACE TRIGGER validate_billing_total
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

//Trigger 4  cant prescribe expired medication 
CREATE OR REPLACE TRIGGER enforce_medication_expiry
BEFORE INSERT ON "PCM.PRESCRIPTION"
FOR EACH ROW
DECLARE
    expiration_date DATE;
BEGIN
    -- Retrieve the expiration date of the prescribed medication
    SELECT expiration_date
    INTO expiration_date
    FROM "PCM.MEDICATION"
    WHERE medication_id = :NEW.medication_id;

    -- Check if the medication is expired
    IF expiration_date < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20004, 'Cannot prescribe expired medication!');
    END IF;
END;
/


//Trigger 5 valid primary doctor is assigned to patient
CREATE OR REPLACE TRIGGER validate_primary_doctor
BEFORE INSERT OR UPDATE ON "PCM.PATIENT"
FOR EACH ROW
DECLARE
    doctor_exists NUMBER;
BEGIN
    -- Check if the primary doctor exists in the DOCTOR table
    SELECT COUNT(*)
    INTO doctor_exists
    FROM "PCM.DOCTOR"
    WHERE doctor_id = :NEW.primary_doctor_id;

    -- Raise an error if the primary doctor does not exist
    IF doctor_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'Primary doctor does not exist!');
    END IF;
END;
/
//Trigger 6
CREATE OR REPLACE TRIGGER update_stock_on_order
AFTER INSERT ON Prescription_Order
FOR EACH ROW
BEGIN
    UPDATE Medication
    SET STOCK_LEVEL = STOCK_LEVEL - :NEW.QUANTITY
    WHERE MEDICATION_ID = :NEW.MEDICATION_ID
      AND STOCK_LEVEL >= :NEW.QUANTITY;
END;
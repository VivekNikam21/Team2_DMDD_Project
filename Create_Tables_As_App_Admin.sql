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
   execute immediate 'alter table "PCM.BILLING" add constraint "payment_status_check" check ( payment_status in ( ''paid'', ''pending'') )';
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
         email          varchar2(50 byte) not null
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

   execute immediate 'alter table "PCM.MEDICATION" add constraint "medication_type_check" check ( medication_type in ( ''capsule'', ''drops'', ''injection'', ''ointment'', ''syrup'', ''tablet'' ) )';
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
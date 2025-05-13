-----------Data Cleaning and Transformation
------------------------Table 1: patient's history 

SELECT * FROM public.patient_history

--1.changing the datatype from float to varchar of column color_ethnicity
ALTER TABLE Patient_history
ALTER COLUMN color_ethnicity
TYPE VARCHAR(100)
USING color_ethnicity::VARCHAR;

---changing the code of the ethincity to respective category
UPDATE patient_history
SET color_ethnicity = CASE 
    WHEN color_ethnicity = '0' THEN 'White'
    WHEN color_ethnicity = '1' THEN 'Black'
    WHEN color_ethnicity = '2' THEN 'Brown'
	WHEN color_ethnicity = '3' THEN 'Asian'
    ELSE 'Unknown'
END;

SELECT * FROM patient_history
ORDER BY case_id;
--------------------------------------------------------------------------------------------------------------
--2.changing the datatype from integer to varchar hypertension_past_reported 
ALTER TABLE Patient_history
ALTER COLUMN hypertension_past_reported 
TYPE VARCHAR(100)
USING hypertension_past_reported::VARCHAR;

--changing the value of hypertension_past_reported cateogry from 0 as No and 1 as yes	
update	Patient_history
set		hypertension_past_reported = 
		case
		when hypertension_past_reported = '0' Then 'No'
		when hypertension_past_reported = '1' Then 'Yes'
		else hypertension_past_reported
		end;

SELECT hypertension_past_reported, count(*)
FROM patient_history
GROUP BY hypertension_past_reported 

------------------------------------------------------------------------------------------------------
--3.changing the datatype from integer to varchar hypertension_past_treatment 
ALTER TABLE Patient_history
ALTER COLUMN hypertension_past_treatment 
TYPE VARCHAR(100)
USING hypertension_past_treatment::VARCHAR;

--changing the value of hypertension_past_reported cateogry from 0 as No and 1 as yes	
update	Patient_history
set		hypertension_past_treatment = 
		case
		when hypertension_past_treatment= '0' Then 'Medicine'
		when hypertension_past_treatment = '1' Then 'No Medicine'
		else hypertension_past_treatment
		end;

SELECT hypertension_past_treatment, count(*)
FROM patient_history
GROUP BY hypertension_past_treatment

-----------------------------------------------------------------------------------------------------------
---4.count the diabetes_mellitus_dm_reported
select  diabetes_mellitus_dm_reported,count(*) 
from public.patient_history
group by  diabetes_mellitus_dm_reported;

---changing the data type from int to varchar diabetes_mellitus_dm_reported
ALTER TABLE Patient_history
ALTER COLUMN diabetes_mellitus_dm_reported 
TYPE VARCHAR(50)
USING diabetes_mellitus_dm_reported::VARCHAR;

---updating the column value as yes and No
update	Patient_history
set		diabetes_mellitus_dm_reported = 
		case
		when diabetes_mellitus_dm_reported = '0' Then 'No'
		when diabetes_mellitus_dm_reported = '1' Then 'Yes'
		else diabetes_mellitus_dm_reported
		end;
-------------------------------------------------------------------------------------------------------------
--5.count the diabetes_mellitus_disease_gap
select diabetes_mellitus_disease_gap ,count(*) from Patient_history 
group by diabetes_mellitus_disease_gap

---checking the column values diabetes_mellitus_disease_gap
select diabetes_mellitus_disease_gap from Patient_history

---updating the column value as Chronic and Past Pregnancy
update	Patient_history
set		diabetes_mellitus_disease_gap = 
		case
		when diabetes_mellitus_disease_gap = '0' Then 'Chronic'
		when diabetes_mellitus_disease_gap = '1' Then 'Past Pregnancy'
		else diabetes_mellitus_disease_gap
		end;	
-----------------------------------------------------------------------------------------------------------
--6.count the diabetes_mellitus_treatment
select diabetes_mellitus_treatment ,count(*) from Patient_history 
group by diabetes_mellitus_treatment

--updating the column value as No, medicine and diet in diabetes_mellitus_treatment
update	patient_history
set		diabetes_mellitus_treatment= 
		case
		when diabetes_mellitus_treatment= '0' Then 'No'
		when diabetes_mellitus_treatment = '1' Then 'Medicines'
		when diabetes_mellitus_treatment = '2' Then 'Diet'
		else diabetes_mellitus_treatment
		end;
-------------------------------------------------------------------------------------------------------------
--7.count the tobacco_use values
select tobacco_use ,count(*) from Patient_history 
group by tobacco_use

--changing the tobacco_use datatype from INT to VARCHAR
ALTER TABLE Patient_history
ALTER COLUMN tobacco_use
TYPE VARCHAR(20)
USING tobacco_use::VARCHAR;

--updating the column value as No and Yes in tobacco_use 
update	patient_history
set		tobacco_use = 
		case
		when tobacco_use = '0' Then 'No'
		when tobacco_use = '1' Then 'Yes'
		else tobacco_use
		end;
----------------------------------------------------------------------------------------------------------
--8.convert the tobacco_use_in_months to tobacco_use_in_years 
select tobacco_use_in_months ,count(*) from Patient_history
group by tobacco_use_in_months

--Step 1:updating the column value as null where the column value is not_applicable 
update	Patient_history
set		tobacco_use_in_months = null
where	tobacco_use_in_months = 'not_applicable';

-- Step 2: Update empty strings to NULL
UPDATE Patient_history
SET tobacco_use_in_months = null
WHERE tobacco_use_in_months = '';

--Step 3: Alter the column type to numeric
ALTER TABLE Patient_history
ALTER COLUMN tobacco_use_in_months
TYPE numeric USING (tobacco_use_in_months::numeric);

--Step 4:converting  months into years
select round(tobacco_use_in_months/12,1) as tuasage
from	patient_history  where tobacco_use_in_months is not null;

--step 4: updating value to years 
update patient_history 
set		tobacco_use_in_months = round(tobacco_use_in_months/12,1)
where	tobacco_use_in_months is not null;

--Step 5: Rename the column name tobacco_use_in_months to tobacco_use_in_years
ALTER TABLE patient_history 
RENAME COLUMN tobacco_use_in_months TO tobacco_use_in_years;

select tobacco_use_in_years from patient_history; 
-----------------------------------------------------------------------------------------------------------
--9.convert the tobacco_quantity_by_day datatype from text to numeric 

--Step 1: Update 'not_applicable' to null 
update	Patient_history
set	tobacco_quantity_by_day = null
where tobacco_quantity_by_day = 'not_applicable';

-- Step 2: Update empty strings to NULL
UPDATE Patient_history
SET tobacco_quantity_by_day = null
WHERE tobacco_quantity_by_day= '';

-- step 3 :update the empty strings to null to Alter the column type to numeric

ALTER TABLE Patient_history
ALTER COLUMN tobacco_use_in_years
TYPE numeric USING (tobacco_use_in_years::numeric);

select tobacco_quantity_by_day from patient_history
------------------------------------------------------------------------------------------------------------
--10.convert the alcohol_use datatype int to varchar

select alcohol_use from patient_history
--Step 1:counting the number of alcohol_use
select alcohol_use,count(*) from Patient_history 
group by alcohol_use 

--Step 2:changing the data type from int to varchar
ALTER TABLE Patient_history
ALTER COLUMN alcohol_use
TYPE VARCHAR(20)
USING alcohol_use::VARCHAR;

update	patient_history
set		alcohol_use = 
		case
		when alcohol_use = '0' Then 'No'
		when alcohol_use = '1' Then 'Yes'
		else alcohol_use
		end;
-------------------------------------------------------------------------------------------------
--11. convert the alcohol_quantity_milliliters to numeric
--step 1. converting the 'not_applicable' as null
update	Patient_history
set	alcohol_quantity_milliliters = null
where alcohol_quantity_milliliters = 'not_applicable';

-- First, remove commas
UPDATE Patient_history
SET alcohol_quantity_milliliters = REPLACE(alcohol_quantity_milliliters, ',', '');

update	Patient_history
set	alcohol_quantity_milliliters = null
where alcohol_quantity_milliliters = 'no_answer'

-- Now alter the column type
ALTER TABLE Patient_history
ALTER COLUMN alcohol_quantity_milliliters
TYPE numeric USING (alcohol_quantity_milliliters::numeric);

--step 2 convert text data type in to mumeric
select alcohol_quantity_milliliters from patient_history

select distinct alcohol_quantity_milliliters from patient_history

--------------------------------------------------------------------------------------------------
---12) alcohol_preference ----
select alcohol_preference, count(*) from patient_history
group by alcohol_preference
--To check the count of alcohol prefernce in all the categories
SELECT
    CASE
        WHEN alcohol_preference = '0' THEN 'Fermented'
        WHEN alcohol_preference = '1' THEN 'Distilled'
        WHEN alcohol_preference IS NULL OR alcohol_preference = '' THEN 'Unknown'  -- Handling NULL and blank values
        ELSE alcohol_preference
    END AS updated_preference,
    COUNT(*) AS count
FROM
    patient_history
GROUP BY
    updated_preference
ORDER BY
    updated_preference;

--updating the alcohol_ preference as fermented, distilled and unknown
UPDATE patient_history
SET alcohol_preference = CASE
    WHEN alcohol_preference = '0' THEN 'Fermented'
    WHEN alcohol_preference = '1' THEN 'Distilled'
    WHEN alcohol_preference IS NULL OR alcohol_preference = '' THEN 'Unknown'  -- Handling NULL and blank values
    ELSE alcohol_preference
END;
-------------------------------------------------------------------------------------------------------------
--13.drugs_preference
select drugs_preference from patient_history

select drugs_preference ,count(*) from patient_history
group by drugs_preference
--0 260 , not applicable 1 , 1 -11

--updating the drugs_preference as No and Marijuna and unknown
UPDATE patient_history
SET drugs_preference = CASE
    WHEN drugs_preference = '0' THEN 'No'
    WHEN drugs_preference = '1' THEN 'Marijuana'
    WHEN drugs_preference IS NULL OR drugs_preference = '' THEN 'Unknown'  -- Handling NULL and blank values
    ELSE drugs_preference
END;
---------------------------------------------------------------------------------------------------------
--14) drugs_years_of_use
select drugs_years_of_use  ,count(*) from patient_history
group by drugs_years_of_use

update	patient_history
set		drugs_years_of_use = null
where	drugs_years_of_use = 'not_applicable';

-- Step 1: Update empty strings to NULL
UPDATE patient_history
SET drugs_years_of_use = null
WHERE drugs_years_of_use = '';

-- Step 2: update the empty strings to null to Alter the column type to numeric
ALTER TABLE patient_history
ALTER COLUMN drugs_years_of_use
TYPE numeric USING (drugs_years_of_use::numeric);
----------------------------------------------------------------------------------------------------------
-----15) drugs_during_pregnancy 
select drugs_during_pregnancy,count(*) from patient_history
group by drugs_during_pregnancy

/*ALTER TABLE Patient_history_Duplicate
ALTER COLUMN drugs_during_pregnancy TYPE VARCHAR(50);*/

-- update drugs_during_pregnancy as No and yes
update	patient_history
set		drugs_during_pregnancy =
		case
		when drugs_during_pregnancy = '0' Then 'No'
		when drugs_during_pregnancy = '1' Then 'Yes'
		else drugs_during_pregnancy
		end;
-----------------------------------------------------------------------------------------------------------
---16)Finding the count of follow up and Lost to follow up

--How to get the count of patients who followed up and lost to follow-up
select delivery_mode ,count(*)delivery_mode from maternal_health group by delivery_mode;
select apgar_1st_min ,count(*) from maternal_health group by apgar_1st_min;
select apgar_5th_min ,count(*) from maternal_health group by apgar_5th_min;

-- To list the patients who lost to follow up
SELECT case_id, delivery_mode, apgar_1st_min
FROM maternal_health
WHERE (delivery_mode IS NULL OR delivery_mode = '')
  AND (apgar_1st_min IS NULL OR apgar_1st_min = '');
  
-- To list the patients who followed up
SELECT case_id, delivery_mode, apgar_1st_min
FROM maternal_health
WHERE NOT (
    (delivery_mode IS NULL OR delivery_mode = '')
    AND (apgar_1st_min IS NULL OR apgar_1st_min = '')
);
-- To list the patients who followed up
SELECT case_id, delivery_mode, apgar_1st_min
FROM maternal_health
WHERE NOT (
    (delivery_mode IS NULL OR delivery_mode = '')
    AND (apgar_1st_min IS NULL OR apgar_1st_min = '')
);
---- To get the count of Patients who followed up
SELECT COUNT(case_id) AS count_of_cases
FROM maternal_health
WHERE NOT (
    (delivery_mode IS NULL OR delivery_mode = '')
    AND (apgar_1st_min IS NULL OR apgar_1st_min = '')
);
--To get the count of Patients who lost to follow up
SELECT COUNT(case_id) AS count_of_cases
FROM maternal_health
WHERE (delivery_mode IS NULL OR delivery_mode = '')
  AND (apgar_1st_min IS NULL OR apgar_1st_min = '');
--ADD column  
alter table patient_history
add column Followup varchar(50);

alter table maternal_health
add column Followup varchar(50);

UPDATE maternal_health
SET Followup = 'Yes'
WHERE case_id NOT IN (
    SELECT case_id
    FROM maternal_health
    WHERE (delivery_mode IS NULL OR delivery_mode = '')
      AND (apgar_1st_min IS NULL OR apgar_1st_min = '')
);

UPDATE maternal_health
SET Followup = 'No'
WHERE case_id IN (
    SELECT case_id
    FROM maternal_health
    WHERE (delivery_mode IS NULL OR delivery_mode = '')
      AND (apgar_1st_min IS NULL OR apgar_1st_min = '')
);		
  
select count(case_id) from maternal_health
where case_id IS NOT NULL;

INSERT INTO patient_history(Followup)
SELECT m.Followup
FROM maternal_health m
JOIN patient_history p ON m.case_id = p.case_id;

UPDATE Patient_history
SET Followup = mh.Followup
FROM maternal_health mh
WHERE Patient_history.case_id = mh.case_id;

ALTER TABLE maternal_health
DROP COLUMN Followup;

select Followup,count(*) from patient_history
group by Followup

select followup from patient_history
--------------------------------------------------------------------------------------------------------------------
----------Table 2: maternal_lab
select * from public.maternal_lab

-----Step 1: changing the datatype from Varchar to numeric
ALTER TABLE maternal_lab
ALTER COLUMN first_trimester_hematocrit
TYPE numeric USING (first_trimester_hematocrit::numeric),
ALTER COLUMN first_trimester_hemoglobin
TYPE numeric USING (first_trimester_hemoglobin::numeric),
ALTER COLUMN first_tri_fasting_blood_glucose
TYPE numeric USING (first_tri_fasting_blood_glucose::numeric);

...................................................................................
-----Step 2: Update 'not_applicable' to null
	
UPDATE maternal_lab
SET
    second_trimester_hematocrit = CASE WHEN second_trimester_hematocrit = 'not_applicable' THEN NULL ELSE second_trimester_hematocrit END,
    third_trimester_hematocrit = CASE WHEN third_trimester_hematocrit = 'not_applicable' THEN NULL ELSE third_trimester_hematocrit END,
    second_trimester_hemoglobin = CASE WHEN second_trimester_hemoglobin = 'not_applicable' THEN NULL ELSE second_trimester_hemoglobin END,
    third_trimester_hemoglobin = CASE WHEN third_trimester_hemoglobin = 'not_applicable' THEN NULL ELSE third_trimester_hemoglobin END,
    second_tri_fasting_blood_glucose = CASE WHEN second_tri_fasting_blood_glucose = 'not_applicable' THEN NULL ELSE second_tri_fasting_blood_glucose END,
    third_tri_fasting_blood_glucose = CASE WHEN third_tri_fasting_blood_glucose = 'not_applicable' THEN NULL ELSE third_tri_fasting_blood_glucose END,
	first_hour_ogtt75_1st_trimester = case when first_hour_ogtt75_1st_trimester = 'not_applicable' THEN NULL ELSE first_hour_ogtt75_1st_trimester end,
	first_hour_ogtt75_2nd_trimester = case when first_hour_ogtt75_2nd_trimester = 'not_applicable' THEN NULL ELSE first_hour_ogtt75_2nd_trimester end,
	first_hour_ogtt75_3rd_trimester = case when first_hour_ogtt75_3rd_trimester = 'not_applicable' THEN NULL ELSE first_hour_ogtt75_3rd_trimester end,
	second_hour_ogtt75_1st_trimester = case when second_hour_ogtt75_1st_trimester  = 'not_applicable' THEN NULL ELSE second_hour_ogtt75_1st_trimester end,
    second_hour_ogtt75_2nd_trimester = case when second_hour_ogtt75_2nd_trimester  = 'not_applicable' THEN NULL ELSE second_hour_ogtt75_2nd_trimester end,
    second_hour_ogtt_3rd_trimester  = case when second_hour_ogtt_3rd_trimester  = 'not_applicable' THEN NULL ELSE second_hour_ogtt_3rd_trimester end,
	hiv_1st_trimester = case when hiv_1st_trimester  = 'not_applicable' THEN NULL ELSE hiv_1st_trimester end,
    syphilis_1st_trimester = case when syphilis_1st_trimester  = 'not_applicable' THEN NULL ELSE syphilis_1st_trimester end,
    c_hepatitis_1st_trimester = case when c_hepatitis_1st_trimester  = 'not_applicable' THEN NULL ELSE c_hepatitis_1st_trimester end;

--- step:3 Changing the datatype from Varchar to numeric

ALTER TABLE maternal_lab
ALTER COLUMN second_trimester_hematocrit TYPE numeric USING (second_trimester_hematocrit::numeric),
ALTER COLUMN third_trimester_hematocrit TYPE numeric USING (third_trimester_hematocrit::numeric),
ALTER COLUMN second_trimester_hemoglobin TYPE numeric USING (second_trimester_hemoglobin::numeric),
ALTER COLUMN third_trimester_hemoglobin TYPE numeric USING (third_trimester_hemoglobin::numeric),
ALTER COLUMN second_tri_fasting_blood_glucose TYPE numeric USING (second_tri_fasting_blood_glucose::numeric),
ALTER COLUMN third_tri_fasting_blood_glucose TYPE numeric USING (third_tri_fasting_blood_glucose::numeric),
ALTER COLUMN first_hour_ogtt75_1st_trimester TYPE numeric USING (first_hour_ogtt75_1st_trimester::numeric),
ALTER COLUMN first_hour_ogtt75_2nd_trimester TYPE numeric USING (first_hour_ogtt75_2nd_trimester::numeric),
ALTER COLUMN first_hour_ogtt75_3rd_trimester TYPE numeric USING (first_hour_ogtt75_3rd_trimester::numeric),
ALTER COLUMN second_hour_ogtt75_1st_trimester TYPE numeric USING (second_hour_ogtt75_1st_trimester::numeric),
ALTER COLUMN second_hour_ogtt75_2nd_trimester TYPE numeric USING (second_hour_ogtt75_2nd_trimester::numeric),
ALTER COLUMN second_hour_ogtt_3rd_trimester TYPE numeric USING (second_hour_ogtt_3rd_trimester::numeric),
ALTER COLUMN hiv_1st_trimester TYPE numeric USING(hiv_1st_trimester::numeric),
ALTER COLUMN syphilis_1st_trimester TYPE numeric USING (syphilis_1st_trimester::numeric),
ALTER COLUMN c_hepatitis_1st_trimester TYPE numeric USING (c_hepatitis_1st_trimester::numeric);
--------------------------------------------------------------------------------------------------------
----Step-4 :changing the value of hiv_1st_trimester from 0 as No and 1 as yes

ALTER TABLE maternal_lab
ALTER COLUMN hiv_1st_trimester TYPE TEXT;

update maternal_lab
set		hiv_1st_trimester = 
		case
		when hiv_1st_trimester = '0' Then 'No'
		when  hiv_1st_trimester = '1' Then 'Yes'
		else hiv_1st_trimester
		end;
----------------------------------------------------------------------------------------------
---Step-5: changing the value of syphilis_1st_trimester from 0 as No and 1 as yes

ALTER TABLE maternal_lab
ALTER COLUMN syphilis_1st_trimester TYPE TEXT;
update maternal_lab
set	  syphilis_1st_trimester	 = 
		case
		when syphilis_1st_trimester = '0' Then 'No'
		when syphilis_1st_trimester = '1' Then 'Yes'
		else syphilis_1st_trimester
		end;

.....................................................................
---Step:6 changing the value of c_hepatitis_1st_trimester from 0 as No and 1 as yes

ALTER TABLE maternal_lab
ALTER COLUMN  c_hepatitis_1st_trimester TYPE TEXT;
update maternal_lab
set	 c_hepatitis_1st_trimester 	 = 
		case
		when  c_hepatitis_1st_trimester = '0' Then 'No'
		when  c_hepatitis_1st_trimester = '1' Then 'Yes'
		else  c_hepatitis_1st_trimester
		end;
-----------------------------------------------------------------
----step-7:changing the outlier value(121)as null
UPDATE maternal_lab
SET third_trimester_hemoglobin = 12.1
WHERE case_id = 177;
-----------------------------------------------
select case_id,third_trimester_hemoglobin from public.maternal_lab
where third_trimester_hemoglobin = 12.1;
select case_id,third_trimester_hemoglobin from public.maternal_health_main
where third_trimester_hemoglobin = '121';
---------------------------------------------------------------------------------------------------------------------------------------------------
-----------Table 3: maternal_inclusion

---- Convert Not applicable and blank in null for fetal_weight_at_ultrasound column.

UPDATE maternal_inclusion_records
SET fetal_weight_at_ultrasound = NULL
WHERE fetal_weight_at_ultrasound  = '' OR fetal_weight_at_ultrasound  = 'not_applicable';


---- Removing special chars from text type column
UPDATE maternal_inclusion_records
SET fetal_weight_at_ultrasound = REPLACE(fetal_weight_at_ultrasound, ',', '')
WHERE fetal_weight_at_ultrasound IS NOT NULL;


----Change data  type text to numeric column fetal_weight_at_ultrasound

ALTER TABLE maternal_inclusion_records
alter column fetal_weight_at_ultrasound type numeric USING fetal_weight_at_ultrasound::numeric;

---- Convert Not applicable and blank to null for column weight_fetal_percentile .

UPDATE maternal_inclusion_records
SET weight_fetal_percentile = NULL
WHERE weight_fetal_percentile  = '' OR weight_fetal_percentile  = 'not_applicable';

----Change data type text to int for column weight_fetal_percentile

ALTER TABLE maternal_inclusion_records
ALTER COLUMN weight_fetal_percentile TYPE int USING weight_fetal_percentile::int;

----Covert blank value to null for column past_pregnancies_number
	
UPDATE maternal_inclusion_records
SET past_pregnancies_number = NULL
WHERE past_pregnancies_number::text = '' OR past_pregnancies_number IS NULL;

----Covert blank value to null for column miscarriage

UPDATE maternal_inclusion_records
SET miscarriage = NULL
WHERE miscarriage::text = '' OR miscarriage IS NULL;

----Covert blank value to null value for column maternal_weight_at_inclusion

UPDATE maternal_inclusion_records
SET maternal_weight_at_inclusion = NULL
WHERE maternal_weight_at_inclusion  = '' OR maternal_weight_at_inclusion = 'not_applicable';

select * from maternal_inclusion_records

---Change data type text to float for column maternal_weight_at_inclusion


ALTER TABLE maternal_inclusion_records
ALTER COLUMN maternal_weight_at_inclusion TYPE float USING maternal_weight_at_inclusion::float;

---Rename the column name as hight to height.
	
alter table maternal_inclusion_records
rename column hight_at_inclusion to height_at_inclusion;

select * from maternal_inclusion_records

----Covert blank value to null value for column height_at_inclusion

UPDATE maternal_inclusion_records
SET height_at_inclusion = NULL
WHERE height_at_inclusion  = '' OR height_at_inclusion = 'not_applicable';

---Change data type text to float for column height_at_inclusion 


ALTER TABLE maternal_inclusion_records
ALTER COLUMN height_at_inclusion  TYPE float USING height_at_inclusion::float;

-----------------------------------------------------------------------------------------------------------------
----------------Table 4: past_newborn_records

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'past_newborn_records'
	
----Replacing not_applicable and no_answer record as NULL for all 8 columns
	
UPDATE past_newborn_records
SET 
	past_newborn_1_weight = CASE 
	WHEN past_newborn_1_weight IN ('not_applicable','no_answer') THEN NULL
	ELSE past_newborn_1_weight
	END,
	
	past_newborn_2_weight = CASE 
	WHEN past_newborn_2_weight IN ('not_applicable','no_answer') THEN NULL
	ELSE past_newborn_2_weight
	END,
	
	past_newborn_3_weight = CASE 
	WHEN past_newborn_3_weight IN ('not_applicable','no_answer')THEN NULL
	ELSE past_newborn_3_weight
	END,
	
	past_newborn_4_weight = CASE 
	WHEN past_newborn_4_weight IN ('not_applicable','no_answer')THEN NULL
	ELSE past_newborn_4_weight
	END,
	
	gestational_age_past_newborn_1 = CASE 
	WHEN gestational_age_past_newborn_1 IN ('not_applicable','no_answer')THEN NULL
	ELSE gestational_age_past_newborn_1
	END,
	
	gestational_age_past_newborn_2 = CASE 
	WHEN gestational_age_past_newborn_2 IN ('not_applicable','no_answer')THEN NULL
	ELSE gestational_age_past_newborn_2
	END,
	
	gestational_age_past_newborn_3 = CASE 
	WHEN gestational_age_past_newborn_3 IN ('not_applicable','no_answer')THEN NULL
	ELSE gestational_age_past_newborn_3
	END,
	
	gestational_age_past_4_newborn = CASE 
	WHEN gestational_age_past_4_newborn IN ('not_applicable','no_answer')THEN NULL
	ELSE gestational_age_past_4_newborn
	END;

--- Changing the data type past_newborn_weight column to NUMERIC AND gestational_age columns to varchar

ALTER TABLE past_newborn_records
ALTER COLUMN past_newborn_1_weight TYPE NUMERIC USING REPLACE(past_newborn_1_weight, ',','')::numeric,
ALTER COLUMN past_newborn_2_weight TYPE NUMERIC USING REPLACE (past_newborn_2_weight, ',','')::numeric,
ALTER COLUMN past_newborn_3_weight TYPE NUMERIC USING REPLACE (past_newborn_3_weight, ',','')::numeric,
ALTER COLUMN past_newborn_4_weight TYPE NUMERIC USING REPLACE (past_newborn_4_weight, ',','')::numeric,
ALTER COLUMN gestational_age_past_newborn_1 TYPE VARCHAR USING gestational_age_past_newborn_1::varchar,
ALTER COLUMN gestational_age_past_newborn_2 TYPE VARCHAR USING gestational_age_past_newborn_2::varchar,
ALTER COLUMN gestational_age_past_newborn_3 TYPE VARCHAR USING gestational_age_past_newborn_3::varchar,
ALTER COLUMN gestational_age_past_4_newborn TYPE VARCHAR USING gestational_age_past_4_newborn::varchar

/*---Changing the values of newborn weight from gram to pound

UPDATE past_newborn_records
SET past_newborn_1_weight = ROUND (past_newborn_1_weight * 0.00220462, 2),
    past_newborn_2_weight = ROUND (past_newborn_1_weight * 0.00220462, 2),
    past_newborn_3_weight = ROUND (past_newborn_1_weight * 0.00220462, 2),
    past_newborn_4_weight = ROUND (past_newborn_1_weight * 0.00220462, 2) */

--SELECT past_newborn_1_weight, past_newborn_2_weight, past_newborn_3_weight,past_newborn_4_weight
--FROM past_newborn_records

---Changing the values of gestational_age columns from 0 and 1 to Full term and Pre term

UPDATE past_newborn_records
SET 
gestational_age_past_newborn_1 = CASE 
WHEN gestational_age_past_newborn_1 = '1' THEN 'Full_Term_Baby'
ELSE 'Pre_Term_Baby'
END,
gestational_age_past_newborn_2 = CASE 
WHEN gestational_age_past_newborn_2 = '1' THEN 'Full_Term_Baby'
ELSE 'Pre_Term_Baby'
END,
gestational_age_past_newborn_3 = CASE 
WHEN gestational_age_past_newborn_3 = '1' THEN 'Full_Term_Baby'
ELSE 'Pre_Term_Baby'
END,
gestational_age_past_4_newborn = CASE 
WHEN gestational_age_past_4_newborn = '1' THEN 'Full_Term_Baby'
ELSE 'Pre_Term_Baby'
END;

SELECT * FROM past_newborn_records

------------------------------------------------------------------------------------------------------
---------------Table5:maternal_bp_fat_metrics...
--step:1
--Updating Not_applicable to null
update maternal_bp_fat_metrics
set right_systolic_blood_pressure  = CASE WHEN right_systolic_blood_pressure='not_applicable' THEN NULL ELSE right_systolic_blood_pressure END,
right_diastolic_blood_pressure = CASE WHEN right_diastolic_blood_pressure ='not_applicable' THEN NULL ELSE right_diastolic_blood_pressure end,
"left_systolic_blood_pressure " = CASE WHEN left_diastolic_blood_pressure ='not_applicable' THEN NULL ELSE "left_systolic_blood_pressure " end,
"left_diastolic_blood_pressure" = CASE WHEN "left_diastolic_blood_pressure" = 'not_applicable' THEN NULL ELSE "left_systolic_blood_pressure " end;
-----------------------------------------------------------------------------------------------------
--Step-2
---changing the datatype from Varchar to numeric
ALTER TABLE maternal_bp_fat_metrics
ALTER COLUMN right_systolic_blood_pressure  TYPE numeric USING (right_systolic_blood_pressure::numeric),
ALTER COLUMN right_diastolic_blood_pressure TYPE numeric USING (right_diastolic_blood_pressure::numeric),
ALTER COLUMN "left_systolic_blood_pressure " TYPE numeric USING ("left_systolic_blood_pressure "::numeric),
ALTER COLUMN left_diastolic_blood_pressure TYPE numeric USING (left_diastolic_blood_pressure::numeric);

--Step -3 Updating Not_applicable to null and converting datatype to numeric for periumbilical_subcutaneous_fat and periumbilical_visceral_fat
update maternal_bp_fat_metrics
set  periumbilical_subcutaneous_fat = CASE WHEN periumbilical_subcutaneous_fat='not_applicable' THEN NULL ELSE periumbilical_subcutaneous_fat end,
periumbilical_visceral_fat = CASE WHEN periumbilical_visceral_fat ='not_applicable' THEN NULL ELSE periumbilical_visceral_fat end;

select * FRom maternal_bp_fat_metrics
--Converting text columns to numeric

ALTER TABLE maternal_bp_fat_metrics
ALTER COLUMN periumbilical_subcutaneous_fat TYPE numeric USING (periumbilical_subcutaneous_fat::numeric),
ALTER COLUMN periumbilical_visceral_fat TYPE numeric USING (periumbilical_visceral_fat::numeric);

---we didnt change for periumbilical_total_fat column since its already in numeric format
--Step -4 Filling up the Missing Values into periumbilical_total_fat
-----identify and handle empty strings: 

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'maternal_bp_fat_metrics' 

-----------------------------------------------------------------------------------------------------------
----Updating for specific case_ids where periumbilical_total_fat is null:

SELECT case_id, periumbilical_visceral_fat, periumbilical_subcutaneous_fat, periumbilical_total_fat
FROM public.maternal_bp_fat_metrics
where case_id in (266,269,275,278,283,285,273,280,282,286,287)
order by case_id
-------------------------------------------------------------------------------------------------------------------
-----adding both the columns:
UPDATE public.maternal_bp_fat_metrics
SET periumbilical_total_fat = COALESCE(periumbilical_visceral_fat, 0) + COALESCE(periumbilical_subcutaneous_fat, 0)
WHERE periumbilical_total_fat IS NULL
AND case_id IN (266, 269, 275, 278, 283, 285, 273, 280, 282, 286, 287);
.................................................................................................
 -----Updating for specific case_id where periumbilical_subcutaneous_fat is null
 
 SELECT case_id, periumbilical_visceral_fat, periumbilical_subcutaneous_fat, periumbilical_total_fat
FROM public.maternal_bp_fat_metrics
where case_id = 9

UPDATE public.maternal_bp_fat_metrics
SET periumbilical_subcutaneous_fat = 55 - 39.6
WHERE case_id = 9;
......................................................................

---cleaning suggestion :(columns are already in numeric)
preperitoneal_subcutaneous_fat - No
preperitoneal_visceral_fat -No

------------------------------------------------------------------------------------------------------------
------------------Table 6:maternal_delivery_newborn

----------------Cleaning Steps for maternal_delivery_newborn---------------
	
select * from  maternal_delivery_newborn
-- No change in case_id

------1)gestational_age_at_birth--------------------------------------------------------------------------

-- Convert datatype Text to Numeric
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN gestational_age_at_birth
TYPE numeric USING (NULLIF(gestational_age_at_birth, '')::numeric);

-------2)prepartum_maternal_weight----------------------------------------------------------------------------

-- Replace non numeric values with NULL and change the datatype TEXT to NUMERIC

ALTER TABLE maternal_delivery_newborn
ALTER COLUMN prepartum_maternal_weight
TYPE numeric USING (
    CASE 
        WHEN prepartum_maternal_weight ~ '^[0-9.]+$' 
        THEN prepartum_maternal_weight::numeric
        ELSE NULL
    END
);

--------3)prepartum_maternal_height----------------------------------------------------------------------

-- Dropping the column as it is duplicate of height_at_inclusion column
ALTER TABLE maternal_delivery_newborn
DROP COLUMN prepartum_maternal_height;

--------4) Delivery Mode---------------------------------------------------------------------------------

select distinct(delivery_mode),count(*)
from maternal_delivery_newborn group by delivery_mode order by delivery_mode

-- Changed datatype from Text to Varchar
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN delivery_mode
SET DATA TYPE VARCHAR(100);

-- Updated the delivery mode with description and replaced 12 with 5 description as cesarean Section
UPDATE maternal_delivery_newborn
SET delivery_mode = 
    CASE 
        WHEN delivery_mode IS NULL OR delivery_mode = '' THEN delivery_mode
        WHEN delivery_mode = '1' THEN 'Vaginal'
        WHEN delivery_mode = '2' THEN 'Vaginal Forcipe'
        WHEN delivery_mode = '3' THEN 'Miscarriage with Curettage'
        WHEN delivery_mode = '4' THEN 'Miscarriage without Curettage'
        WHEN delivery_mode = '5' THEN 'Cesarean Section'
        WHEN delivery_mode = '6' THEN 'Cesarean by Jeopardy'
        WHEN delivery_mode = '7' THEN 'Vaginal with Episiotomy'
        WHEN delivery_mode = '8' THEN 'Vaginal without Episiotomy'
        WHEN delivery_mode = '9' THEN 'Vaginal with Episiotomy plus Forcipe'
        WHEN delivery_mode = '12' THEN 'Cesarean Section'
        ELSE 'Unknown'
    END;

----------5) cesarean_section_reason------------------------------------------------------------------

--Change the datatype from Text to Varchar
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN cesarean_section_reason
SET DATA TYPE VARCHAR(100);

select * from maternal_delivery_newborn order by case_id;


----------6)hospital_systolic_blood_pressure------------------------------------------------------------

-- Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN hospital_systolic_blood_pressure
TYPE integer USING (
    CASE 
        WHEN hospital_systolic_blood_pressure ~ '^[0-9]+$'  -- Only integers (no decimals)
        THEN hospital_systolic_blood_pressure::integer
        ELSE NULL  -- Convert non-numeric values to NULL
    END
);


---------7) hospital_diastolic_blood_pressure---------------------------------------------------------

-- Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN hospital_diastolic_blood_pressure
TYPE integer USING (
    CASE 
        WHEN hospital_diastolic_blood_pressure ~ '^[0-9]+$'  -- Only integers (no decimals)
        THEN hospital_diastolic_blood_pressure::integer
        ELSE NULL  -- Convert non-numeric values to NULL
    END
);

-------8) hospital_hypertension--------------------------------------------------------------------------------

-- Change the datatype text to integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN hospital_hypertension
TYPE integer USING (
    CASE 
        WHEN hospital_hypertension ~ '^[0-9]+$'  -- Only integers (no decimals)
        THEN hospital_hypertension::integer
        ELSE NULL  -- Convert non-numeric values to NULL
    END
);


---------9) preeclampsia_record_pregnancy-----------------------------------------------------------------

select preeclampsia_record_pregnancy ,count(*) from
maternal_delivery_newborn group by preeclampsia_record_pregnancy;

----Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN preeclampsia_record_pregnancy
SET DATA TYPE VARCHAR(20); 

--Updated preeclampsia_record_pregnancy column from 0 to 'No' and 1 to 'Yes'
UPDATE maternal_delivery_newborn
SET preeclampsia_record_pregnancy = 
    CASE 
        WHEN preeclampsia_record_pregnancy = '0' THEN 'No'  
        WHEN preeclampsia_record_pregnancy = '1' THEN 'Yes' 
        ELSE preeclampsia_record_pregnancy 
    END;

-------10)gestational_diabetes_mellitus_pregnancy-----------------------------------------------------------

select gestational_diabetes_mellitus_pregnancy,count(*) from maternal_delivery_newborn
group by gestational_diabetes_mellitus_pregnancy

----Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN gestational_diabetes_mellitus_pregnancy
SET DATA TYPE VARCHAR(20); 

--Updated gestational_diabetes_mellitus_pregnancy column from 0 to 'No' and 1 to 'Yes'
UPDATE maternal_delivery_newborn
SET gestational_diabetes_mellitus_pregnancy = 
    CASE 
        WHEN gestational_diabetes_mellitus_pregnancy = '0' THEN 'No'  
        WHEN gestational_diabetes_mellitus_pregnancy = '1' THEN 'Yes' 
        ELSE gestational_diabetes_mellitus_pregnancy 
    END;
	


------11)chronic_diabetes----------------------------------------------------------------------------------

ALTER TABLE maternal_delivery_newborn
ALTER COLUMN chronic_diabetes
SET DATA TYPE VARCHAR(50);


--Updated chronic_diabetes column from blank and outliers to NULL and, from 0 to 'No' and 1 to 'Yes'
UPDATE maternal_delivery_newborn
SET chronic_diabetes = 
    CASE 
        WHEN chronic_diabetes = '' THEN NULL  -- Replace blank spaces with NULL
        WHEN chronic_diabetes = '88,888.00' THEN NULL  -- Replace with NULL for the outlier value 88,888.00
        WHEN chronic_diabetes = '888' THEN NULL  -- Replace with NULL for the outlier value 888
        WHEN chronic_diabetes = '0' THEN 'No'  -- Convert '0' to 'No'
        WHEN chronic_diabetes = '1' THEN 'Yes'  -- Convert '1' to 'Yes'
        ELSE chronic_diabetes  -- Retain existing value for other cases
    END;


--Add column chronic_diabetes to table patient_history as it has the history of chronic diabetes

ALTER TABLE patient_history
ADD COLUMN chronic_diabetes VARCHAR(50);  

--Check the column is added to patient_history
select chronic_diabetes from patient_history

--Copy the column chronic_diabetes from maternal_delivery_newborn to patient_history

UPDATE patient_history
SET chronic_diabetes = m.chronic_diabetes
FROM maternal_delivery_newborn AS m
WHERE patient_history.case_id = m.case_id 

--Check the count is matching on both the tables
select chronic_diabetes,count(*) from maternal_delivery_newborn group by chronic_diabetes
select chronic_diabetes,count(*) from patient_history group by chronic_diabetes

--Drop the column chronic_diabetes from maternal_delivery_newborn
ALTER TABLE maternal_delivery_newborn
DROP COLUMN chronic_diabetes;

----------12) chronic_diseases -------------------------------------------------------------------------------

select * from maternal_delivery_newborn order by case_id;
select chronic_diseases,count(*) from maternal_delivery_newborn group by chronic_diseases

ALTER TABLE maternal_delivery_newborn
ALTER COLUMN chronic_diseases
SET DATA TYPE VARCHAR(50); 

UPDATE maternal_delivery_newborn
SET chronic_diseases = 
    CASE 
        WHEN chronic_diseases = '0' THEN 'No'  -- Convert '0' to 'No'
        WHEN chronic_diseases = '1' THEN 'Yes'  -- Convert '1' to 'Yes'
        ELSE chronic_diseases  -- Retain existing value for other cases
    END;

-----------13) disease_diagnose_during_pregnancy------------------------------------------------------------

/*select disease_diagnose_during_pregnancy,count(*) from maternal_delivery_newborn
group by disease_diagnose_during_pregnancy order by disease_diagnose_during_pregnancy asc

select  distinct(disease_diagnose_during_pregnancy) from maternal_delivery_newborn group by 
disease_diagnose_during_pregnancy order by disease_diagnose_during_pregnancy asc*/

--Replace + with comma ','
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = REPLACE(disease_diagnose_during_pregnancy, ' +', ', ');

--Replace and with comma ','
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = REPLACE(disease_diagnose_during_pregnancy, ' and ', ', ');

--Used ILIKE function to remove the duplicated description and combined similar names
--1)
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = 
    CASE 
        -- Change 'Asthma' to lowercase 'asthma'
        WHEN disease_diagnose_during_pregnancy = 'Asthma' THEN 'asthma'
        -- Leave  asthma and other conditions unchanged
        WHEN disease_diagnose_during_pregnancy ILIKE '%asthma%' THEN disease_diagnose_during_pregnancy
        ELSE disease_diagnose_during_pregnancy
    END;

--2)
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = 
    CASE 
        -- Change 'itu' to uppercase 'ITU'
        WHEN disease_diagnose_during_pregnancy = ',itu' THEN 'ITU'
		WHEN disease_diagnose_during_pregnancy ='bronchitis, itu' THEN 'ITU'
        -- Leave other conditions unchanged
        WHEN disease_diagnose_during_pregnancy ILIKE '%ITU%' THEN disease_diagnose_during_pregnancy
        ELSE disease_diagnose_during_pregnancy
    END;

--3)
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = 
    CASE 
         WHEN disease_diagnose_during_pregnancy ILIKE 'colestase' THEN 'Cholestasis'
        ELSE disease_diagnose_during_pregnancy
    END;

--4)
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = 
    CASE 
         WHEN disease_diagnose_during_pregnancy ILIKE 'Depression' THEN 'depression'
        ELSE disease_diagnose_during_pregnancy
    END;

--5)
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = 
    CASE 
         WHEN disease_diagnose_during_pregnancy ILIKE 'has' or disease_diagnose_during_pregnancy ILIKE 'Has' THEN 'HAS'
        ELSE disease_diagnose_during_pregnancy
    END;

--6)
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = 
    CASE 
         WHEN disease_diagnose_during_pregnancy ILIKE 'HAS,DMG' THEN 'HAS, DMG'
        ELSE disease_diagnose_during_pregnancy
    END;

--7)
UPDATE maternal_delivery_newborn
SET disease_diagnose_during_pregnancy = 
    CASE 
         WHEN disease_diagnose_during_pregnancy ILIKE 'VDRL,' THEN 'VDRL'
        ELSE disease_diagnose_during_pregnancy
    END;

SELECT disease_diagnose_during_pregnancy FROM maternal_delivery_newborn


-----14) treatment_disease_pregnancy----------------------------------------------------------------

-- Change the datatype text to varchar
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN treatment_disease_pregnancy
SET DATA TYPE VARCHAR(100); 

/* Update the treatment_disease_pregnancy column by replacing Spanish terms with clearer, English descriptions.
This ensures that the column values provide a more understandable context, particularly 
for medications, treatments, or conditions reported during pregnancy. to english*/

UPDATE maternal_delivery_newborn
SET treatment_disease_pregnancy = 
    CASE 
        WHEN treatment_disease_pregnancy = '0' THEN 'Value 0 needs Context'
        WHEN treatment_disease_pregnancy = '45' THEN 'Value 45 needs Context'
        WHEN treatment_disease_pregnancy = 'ac valproico,' THEN 'Ac valproic (medication)'
        WHEN treatment_disease_pregnancy = 'aspirina' THEN 'Aspirin (medication)'
        WHEN treatment_disease_pregnancy = 'diet' THEN 'Diet'
        WHEN treatment_disease_pregnancy = 'fluoxetina' OR treatment_disease_pregnancy = 'Fluxetina' THEN 'Fluoxetine (Antidepressant)'
        WHEN treatment_disease_pregnancy = 'insulina' THEN 'Insulin (Diabetes Medication)'
        WHEN treatment_disease_pregnancy = 'medicamento' OR treatment_disease_pregnancy = 'Medicamento' THEN 'Medication'
        WHEN treatment_disease_pregnancy = 'medication' THEN 'Medication'
        WHEN treatment_disease_pregnancy = 'metformina' THEN 'Metformin (Diabetes Medication)'
        WHEN treatment_disease_pregnancy = 'Metildopa' THEN 'Methyldopa (Antihypertensive)'
        WHEN treatment_disease_pregnancy = 'predinisolona' THEN 'Prednisolone (Corticosteroid)'
        WHEN treatment_disease_pregnancy = 'Sem tto' OR treatment_disease_pregnancy = 'Sem TTo' THEN 'No Treatment'
        WHEN treatment_disease_pregnancy = 'sim' THEN 'Yes'
        WHEN treatment_disease_pregnancy = 'tapazol' THEN 'Tapazole (Antithyroid)'
        ELSE treatment_disease_pregnancy
    END;

-----15) number_prenatal_appointments---------------------------------------------------

--Change the datatype Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN number_prenatal_appointments
TYPE integer USING (
    CASE 
        WHEN number_prenatal_appointments ~ '^[0-9]+$'  -- Only integers (no decimals)
        THEN number_prenatal_appointments::integer
        ELSE NULL  -- Convert non-numeric values to NULL
    END
);


------16)expected_weight_for_the_newborn-------------------------------------


--step 1 :Remove the comma ',' from the newborn_weight column
UPDATE maternal_delivery_newborn
SET expected_weight_for_the_newborn = 
CASE
   WHEN TRIM(expected_weight_for_the_newborn) = '' THEN NULL  
   ELSE REPLACE(expected_weight_for_the_newborn, ',', '')::numeric  
   END
WHERE 
    expected_weight_for_the_newborn ~ '^[0-9,.]*$'  
    AND (TRIM(expected_weight_for_the_newborn) <> '' OR newborn_weight IS NOT NULL); 


-- step 2 :Change the datatype of newborn_weight column from Text to Numeric
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN expected_weight_for_the_newborn
TYPE numeric USING (
    CASE 
        WHEN expected_weight_for_the_newborn ~ '^[0-9]+(\.[0-9]+)?$' 
        THEN expected_weight_for_the_newborn::numeric
        ELSE NULL  
    END
);

--------17) newborn_weight ----------------------------------------------------------------------------------

--step 1 :Remove the comma ',' from the newborn_weight column
UPDATE maternal_delivery_newborn
SET newborn_weight = 
CASE
   WHEN TRIM(newborn_weight) = '' THEN NULL  
   ELSE REPLACE(newborn_weight, ',', '')::numeric  
   END
WHERE 
    newborn_weight ~ '^[0-9,.]*$'  
    AND (TRIM(newborn_weight) <> '' OR newborn_weight IS NOT NULL); 


-- step 2 :Change the datatype of newborn_weight column from Text to Numeric
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN newborn_weight
TYPE numeric USING (
    CASE 
        WHEN newborn_weight ~ '^[0-9]+(\.[0-9]+)?$' 
        THEN newborn_weight::numeric
        ELSE NULL  
    END
);

---------18)newborn_height ---------------------------------------------------------------

--Change the datatype of newborn_height column from Text to Numeric
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN newborn_height
TYPE numeric USING (
    CASE 
        WHEN newborn_height ~ '^[0-9]+(\.[0-9]+)?$' 
        THEN newborn_height::numeric
        ELSE NULL  
    END
);

--------19) newborn_head_circumference -----------------------------------------------------------------

--Change the datatype from Text to Numeric
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN newborn_head_circumference
TYPE numeric USING (
    CASE 
        WHEN newborn_head_circumference ~ '^[0-9]+(\.[0-9]+)?$' 
        THEN newborn_head_circumference::numeric
        ELSE NULL  
    END
);

----------- 20)thoracic_perimeter_of_newborn-----------------------------------------------------

--Change the datatype from Text to Numeric
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN thoracic_perimeter_of_newborn
TYPE numeric USING (
    CASE 
        WHEN thoracic_perimeter_of_newborn ~ '^[0-9]+(\.[0-9]+)?$' 
        THEN thoracic_perimeter_of_newborn::numeric
        ELSE NULL  
    END
);

------------21)meconium_in_labor----------------------------------------------------

--Change the datatype from Text to varchar
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN meconium_in_labor
SET DATA TYPE VARCHAR(50); 

--Updated meconium_in_labor column from 0 to 'No' and 1 to 'Yes'
UPDATE maternal_delivery_newborn
SET meconium_in_labor = 
    CASE 
        WHEN meconium_in_labor = '0' THEN 'No'  
        WHEN meconium_in_labor = '1' THEN 'Yes' 
        ELSE meconium_in_labor 
    END;

----------22) apgar_1st_min ------------------------------------------------

/* Step 1: Corrected the outlier for column apgar_1st_min =9 for case_id =176 as
apgar_5th_min score looks normal for that case_id */

UPDATE maternal_delivery_newborn SET apgar_1st_min='9' WHERE  case_id='176';

---- Step 2 :Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN apgar_1st_min
TYPE integer USING (
    CASE
        WHEN apgar_1st_min ~ '^[0-9]+$' THEN apgar_1st_min::integer  -- Cast valid numeric values to integer
        ELSE null
    END
);

----------23) apgar_5th_min-------------------------------------------------------------------

----Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN apgar_5th_min
TYPE integer USING (
    CASE
        WHEN apgar_5th_min ~ '^[0-9]+$' THEN apgar_5th_min::integer  -- Cast valid numeric values to integer
        ELSE null
    END
);


--------24) pediatric_resuscitation_maneuvers -------------------------------------------

----Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN pediatric_resuscitation_maneuvers
SET DATA TYPE VARCHAR(20); 

--Updated pediatric_resuscitation_maneuvers column from 0 to 'No' and 1 to 'Yes'
UPDATE maternal_delivery_newborn
SET pediatric_resuscitation_maneuvers = 
    CASE 
        WHEN pediatric_resuscitation_maneuvers = '0' THEN 'No'  
        WHEN pediatric_resuscitation_maneuvers = '1' THEN 'Yes' 
        ELSE pediatric_resuscitation_maneuvers 
    END;

--------25) intubation---------------------------------------------------------------------------

select newborn_intubation ,count(*) from
maternal_delivery_newborn group by newborn_intubation;


----Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN newborn_intubation
SET DATA TYPE VARCHAR(20); 

--Updated newborn_intubation column from 0 to 'No' and 1 to 'Yes'
UPDATE maternal_delivery_newborn
SET newborn_intubation = 
    CASE 
        WHEN newborn_intubation = '0' THEN 'No'  
        WHEN newborn_intubation = '1' THEN 'Yes' 
        ELSE newborn_intubation
    END;

-----------26) newborn_airway_aspiration------------------------------------------

----Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN newborn_airway_aspiration
SET DATA TYPE VARCHAR(20); 

--Updated newborn_airway_aspiration column from 0 to 'No' and 1 to 'Yes'
UPDATE maternal_delivery_newborn
SET newborn_airway_aspiration = 
    CASE 
        WHEN newborn_airway_aspiration = '0' THEN 'No'  
        WHEN newborn_airway_aspiration = '1' THEN 'Yes' 
        ELSE newborn_airway_aspiration 
    END;

-----------27) mothers_hospital_stay--------------------------------------------------------------------------

----Change the datatype from Text to Integer
ALTER TABLE maternal_delivery_newborn
ALTER COLUMN mothers_hospital_stay
TYPE integer USING (
    CASE
        WHEN mothers_hospital_stay ~ '^[0-9]+$' THEN mothers_hospital_stay::integer
        ELSE null
    END
);

---------------------------------------------------------------------------------------------------------------
----------Table 7: maternal_anthropometric
---Data Transformation for the maternal_anthropometric sub table-----

--1)changing the data type from text to numeric of prepregnant_weight
Select  prepregnant_weight, count(*) From public.maternal_anthropometric
Group by prepregnant_weight

--Step 1: Update 'not_applicable' to null 
update maternal_anthropometric
set  prepregnant_weight = null
where prepregnant_weight = 'no_answer';

-- step 2 : Alter the column type to numeric
ALTER TABLE public.maternal_anthropometric 
ALTER COLUMN prepregnant_weight
TYPE numeric USING (prepregnant_weight::numeric);

----------------------------------------------------------------------------------------------------
--2)changing the data type from text to numeric of prepregnant_bmi

select prepregnant_bmi from public.maternal_anthropometric
Select prepregnant_bmi , count(*) From public.maternal_anthropometric
Group by prepregnant_bmi

--Step 1: Update 'not_applicable' to null 
update maternal_anthropometric
set	 prepregnant_bmi = null
where prepregnant_bmi = 'not_applicable';

-- step 2 : Alter the column type to numeric
ALTER TABLE public.maternal_anthropometric 
ALTER COLUMN prepregnant_bmi
TYPE numeric USING (prepregnant_bmi::numeric);

-----------------------------------------------------------------------------------------------------
---3)changing the data type from text to numeric of bmi_according_who

--Step 1: Update 'not_applicable' to null 
update	maternal_anthropometric
set	bmi_according_who = null
where bmi_according_who = 'not_applicable';

-- step 2 :Alter the column type to numeric

ALTER TABLE maternal_anthropometric
ALTER COLUMN bmi_according_who
TYPE numeric USING (bmi_according_who::numeric);

--step 3: As the column bmi_according_who inconsistence with prepregnant_bmi

---Delete the column bmi_according_who 

ALTER TABLE public.maternal_anthropometric
DROP COLUMN bmi_according_who;

--step 4:create a new prepregnant_bmi_category 

ALTER TABLE public.maternal_anthropometric 
ADD COLUMN prepregnant_bmi_category text;

---categorizing the prepregenant BMI
select prepregnant_bmi_category from maternal_anthropometric 

UPDATE maternal_anthropometric
SET prepregnant_bmi_category = CASE
    WHEN prepregnant_bmi < '18.5' THEN 'Underweight'
    WHEN prepregnant_bmi BETWEEN '18.5' AND '24.9' THEN 'Normal weight'
    WHEN prepregnant_bmi BETWEEN '25' AND '29.9' THEN 'Overweight'
    ELSE 'Obese'
END;

----------------------------------------------------------------------------------------------------
---4)changing the data type from text to numeric of current_maternal_weight_1st_trimester

select current_maternal_weight_1st_trimester,count(*)from maternal_anthropometric
group by current_maternal_weight_1st_trimester

--Step 1: Update 'not_applicable' to null
update	maternal_anthropometric
set	current_maternal_weight_1st_trimester = null
where current_maternal_weight_1st_trimester = 'not_applicable';

-- step 2 :Alter the column type to numeric
ALTER TABLE maternal_anthropometric
ALTER COLUMN current_maternal_weight_1st_trimester
TYPE numeric USING (current_maternal_weight_1st_trimester::numeric);

-----------------------------------------------------------------------------------------------------
--5)changing the datatype from Varchar to numeric current_maternal_weight_2nd_trimester

select current_maternal_weight_2nd_trimester,count(*)from maternal_anthropometric
group by current_maternal_weight_2nd_trimester

--Step 1: Update 'not_applicable' to null
update	maternal_anthropometric
set	current_maternal_weight_2nd_trimester = null
where current_maternal_weight_2nd_trimester = 'not_applicable';

-- step 2 :Alter the column type to numeric
ALTER TABLE maternal_anthropometric
ALTER COLUMN current_maternal_weight_2nd_trimester
TYPE numeric USING (current_maternal_weight_2nd_trimester::numeric);
----------------------------------------------------------------------------------------------------
--6)changing the datatype from Varchar to numeric current_maternal_weight_3rd_trimester

select current_maternal_weight_3rd_trimester,count(*)from maternal_anthropometric
group by current_maternal_weight_3rd_trimester

--Step 1: Update 'not_applicable' to null
update	maternal_anthropometric
set	current_maternal_weight_3rd_trimester = null
where current_maternal_weight_3rd_trimester = 'not_applicable';

-- step 2 :Alter the column type to numeric
ALTER TABLE maternal_anthropometric
ALTER COLUMN current_maternal_weight_3rd_trimester
TYPE numeric USING (current_maternal_weight_3rd_trimester::numeric);

--step 3 :Changing the weight 999 to 99 as it seems like a type error
update	maternal_anthropometric
set	current_maternal_weight_3rd_trimester = 99
where current_maternal_weight_3rd_trimester = 999;
------------------------------------------------------------------------------------------------------
---7)changing the data type from text to numeric of current_bmi_according_who

---- step 1 :Alter the column type to numeric

ALTER TABLE maternal_anthropometric
ALTER COLUMN current_bmi_according_who
TYPE numeric USING (current_bmi_according_who::numeric);

---step 2:changing the data type from text to numeric of current_bmi

ALTER TABLE maternal_anthropometric
ALTER COLUMN current_bmi
TYPE numeric USING (current_bmi::numeric);

-step 3: As the column current_bmi_according_who inconsistence with current_bmi

---Delete the column current_bmi_according_who 

ALTER TABLE public.maternal_anthropometric
DROP COLUMN current_bmi_according_who;

--step 4:create a new current_bmi_category 

ALTER TABLE public.maternal_anthropometric 
ADD COLUMN current_bmi_category text;

UPDATE public.maternal_anthropometric
SET current_bmi_category = CASE
    WHEN current_bmi < '18.5' THEN 'Underweight'
    WHEN current_bmi BETWEEN '18.5' AND '24.9' THEN 'Normal weight'
    WHEN current_bmi BETWEEN '25' AND '29.9' THEN 'Overweight'
    ELSE 'Obese'
END;

--------------------------------------------------------------------------------------------------
---8)changing the data type from text to numeric of ultrasound_gestational_age
		   
--  Alter the column type to numeric
ALTER TABLE public.maternal_anthropometric 
ALTER COLUMN ultrasound_gestational_age
TYPE numeric USING (ultrasound_gestational_age::numeric);	

----------------------------------------------------------------------------------------------------
--9)changing the datatype from Varchar to numeric for the remaining column

ALTER TABLE maternal_anthropometric
ALTER COLUMN maternal_brachial_circumference  TYPE numeric USING (maternal_brachial_circumference::numeric),
ALTER COLUMN circumference_of_the_maternal_calf TYPE numeric USING (circumference_of_the_maternal_calf::numeric),
ALTER COLUMN maternal_neck_circumference TYPE numeric USING (maternal_neck_circumference::numeric),
ALTER COLUMN maternal_hip_circumference TYPE numeric USING (maternal_hip_circumference::numeric),
ALTER COLUMN maternal_waist_circumference TYPE numeric USING (maternal_waist_circumference::numeric),
ALTER COLUMN mean_triccipital_skinfold TYPE numeric USING (mean_triccipital_skinfold::numeric),
ALTER COLUMN mean_subscapular_skinfold TYPE numeric USING (mean_subscapular_skinfold::numeric),
ALTER COLUMN mean_supra_iliac_skin_fold TYPE numeric USING (mean_supra_iliac_skin_fold::numeric);

--------------------------------------------------------------------------------------------
---------Table 9:prenatal_nutrition

SELECT * FROM prenatal_nutrition

	ALTER TABLE  prenatal_nutrition
	ALTER COLUMN breakfast_meal TYPE TEXT USING breakfast_meal::text,
	ALTER COLUMN morning_snack TYPE TEXT USING morning_snack::text,
	ALTER COLUMN lunch_meal  TYPE TEXT USING lunch_meal::text,
	ALTER COLUMN afternoon_snack TYPE TEXT USING afternoon_snack::text,
	ALTER COLUMN meal_dinner TYPE TEXT USING meal_dinner::text,
	ALTER COLUMN supper_meal TYPE TEXT USING supper_meal::text,
	ALTER COLUMN bean TYPE TEXT USING bean::text,
	ALTER COLUMN fruits TYPE TEXT USING fruits::text,
	ALTER COLUMN vegetables TYPE TEXT USING vegetables::text,
	ALTER COLUMN embedded_food TYPE TEXT USING embedded_food::text,
 	ALTER COLUMN pasta TYPE TEXT USING pasta::text,
	ALTER COLUMN cookies TYPE TEXT USING cookies::text;

---1)  case id 195 has blank values on bean,fruits,vegetables,embedded_food_pasta and cookies . So Removed the blank space from the record.                     
----  The blank spaces in a TEXT column prevent conversion to INTEGER, as the database treats these blanks as non-numeric values
	
UPDATE prenatal_nutrition
SET breakfast_meal = NULLIF(breakfast_meal, ''),
    morning_snack = NULLIF(morning_snack, ''),
    lunch_meal = NULLIF(lunch_meal, ''),
    afternoon_snack = NULLIF(afternoon_snack, ''),
    meal_dinner = NULLIF(meal_dinner, ''),
    supper_meal = NULLIF(supper_meal, ''),
    bean = NULLIF(bean, ''),
    fruits = NULLIF(fruits, ''),
    vegetables = NULLIF(vegetables, ''),
    embedded_food = NULLIF(embedded_food, ''),
    pasta = NULLIF(pasta, ''),
    cookies = NULLIF(cookies, '');                                                  

---This query will set the record to NULL if a blank space is found

------2) Converted TEXT to INTEGER datatype

	ALTER TABLE  prenatal_nutrition
	ALTER COLUMN breakfast_meal TYPE INTEGER USING breakfast_meal::INTEGER,
	ALTER COLUMN morning_snack TYPE INTEGER USING morning_snack::INTEGER,
	ALTER COLUMN lunch_meal  TYPE INTEGER USING lunch_meal::INTEGER,
	ALTER COLUMN afternoon_snack TYPE INTEGER USING afternoon_snack::INTEGER,
	ALTER COLUMN meal_dinner TYPE INTEGER USING meal_dinner::INTEGER,
	ALTER COLUMN supper_meal TYPE INTEGER USING supper_meal::INTEGER,
	ALTER COLUMN bean TYPE INTEGER USING bean::INTEGER,
	ALTER COLUMN fruits TYPE INTEGER USING fruits::INTEGER,
	ALTER COLUMN vegetables TYPE INTEGER USING vegetables::INTEGER,
	ALTER COLUMN embedded_food TYPE INTEGER USING embedded_food::INTEGER,
 	ALTER COLUMN pasta TYPE INTEGER USING pasta::INTEGER,
	ALTER COLUMN cookies TYPE INTEGER USING cookies::INTEGER;

---------------------------------------------------------------------------------------------------------------
select * from public.maternal_anthropometric
select * from public.maternal_bp_fat_metrics
select * from public.maternal_delivery_newborn
select * from public.maternal_health_main
select * from public.maternal_inclusion_records
select * from public.maternal_lab
select * from public.past_newborn_records
select * from public.patient_history
select * from public.prenatal_nutrition
-----------------------------------------------------------------------------------------------------------------

--create a main table as maternal_health and import the data from observation csv file
CREATE TABLE maternal_health_main (
case_id int primary key,
age_years int,
color_ethnicity int,
hypertension_past_reported int,
hypertension_past_treatment TEXT,
diabetes_mellitus_dm_reported int,
diabetes_mellitus_disease_gap TEXT,
diabetes_mellitus_treatment TEXT,
tobacco_use int,
tobacco_use_in_months TEXT,
tobacco_quantity_by_day TEXT,
alcohol_use int,
alcohol_quantity_milliliters TEXT,
alcohol_preference TEXT,
drugs_preference TEXT,
drugs_years_of_use TEXT,
drugs_during_pregnancy TEXT,
past_newborn_1_weight TEXT,
gestational_age_past_newborn_1 TEXT,
past_newborn_2_weight TEXT,
gestational_age_past_newborn_2 TEXT,
past_newborn_3_weight TEXT,
gestational_age_past_newborn_3 TEXT,
past_newborn_4_weight TEXT,
gestational_age_past_4_newborn TEXT,
breakfast_meal int,
morning_snack int,
lunch_meal int,
afternoon_snack int,
meal_dinner int ,
supper_meal int,
bean int,
fruits int,
vegetables int,
embedded_food int,
pasta int,
cookies int,
right_systolic_blood_pressure TEXT,
right_diastolic_blood_pressure TEXT,
left_systolic_blood_pressure TEXT,
left_diastolic_blood_pressure TEXT,
periumbilical_subcutaneous_fat TEXT,
periumbilical_visceral_fat TEXT,
periumbilical_total_fat decimal,
preperitoneal_subcutaneous_fat decimal,
preperitoneal_visceral_fat decimal,
gestational_age_at_inclusion decimal,
fetal_weight_at_ultrasound TEXT,
weight_fetal_percentile TEXT,
past_pregnancies_number int,
miscarriage int,
first_trimester_hematocrit TEXT,
second_trimester_hematocrit TEXT,
third_trimester_hematocrit TEXT,
first_trimester_hemoglobin TEXT,
second_trimester_hemoglobin TEXT,
third_trimester_hemoglobin TEXT,
first_tri_fasting_blood_glucose TEXT,
second_tri_fasting_blood_glucose TEXT,
third_tri_fasting_blood_glucose TEXT,
first_hour_ogtt75_1st_trimester TEXT,
first_hour_ogtt75_2nd_trimester TEXT,
first_hour_ogtt75_3rd_trimester TEXT,
second_hour_ogtt75_1st_trimester TEXT,
second_hour_ogtt75_2nd_trimester TEXT,
second_hour_ogtt_3rd_trimester TEXT,
hiv_1st_trimester TEXT,
syphilis_1st_trimester TEXT,
c_hepatitis_1st_trimester TEXT,
prepregnant_weight TEXT,
prepregnant_bmi TEXT,
bmi_according_who TEXT,
current_maternal_weight_1st_trimester TEXT,
current_maternal_weight_2nd_trimester TEXT,
current_maternal_weight_3rd_trimester TEXT,
maternal_weight_at_inclusion TEXT,
height_at_inclusion TEXT,
current_bmi TEXT,
current_bmi_according_who TEXT,
ultrasound_gestational_age TEXT,
maternal_brachial_circumference TEXT,
circumference_of_the_maternal_calf TEXT,
maternal_neck_circumference TEXT,
maternal_hip_circumference TEXT,
maternal_waist_circumference TEXT,
mean_triccipital_skinfold TEXT,
mean_subscapular_skinfold TEXT,
mean_supra_iliac_skin_fold TEXT,
gestational_age_at_birth TEXT,
prepartum_maternal_weight TEXT,
prepartum_maternal_height TEXT,
delivery_mode TEXT,
cesarean_section_reason TEXT,
hospital_systolic_blood_pressure TEXT,
hospital_diastolic_blood_pressure TEXT,
hospital_hypertension TEXT,
preeclampsia_record_pregnancy TEXT,
gestational_diabetes_mellitus_pregnancy TEXT,
chronic_diabetes TEXT,
chronic_diseases TEXT,
disease_diagnose_during_pregnancy TEXT,
treatment_disease_pregnancy TEXT,
number_prenatal_appointments TEXT,
expected_weight_for_the_newborn TEXT,
newborn_weight TEXT,
newborn_height TEXT,
newborn_head_circumference TEXT,
thoracic_perimeter_of_newborn TEXT,
meconium_in_labor TEXT,
apgar_1st_min TEXT,
apgar_5th_min TEXT,
pediatric_resuscitation_maneuvers TEXT,
newborn_intubation TEXT,
newborn_airway_aspiration TEXT,
mothers_hospital_stay TEXT
);

--check the table No of rows
select * from maternal_health_main;

--check the count of the column imported form CSV file
SELECT COUNT(column_name)
FROM information_schema.columns
WHERE table_name = 'maternal_health_main'

-- create patient_history sub table from main table 
CREATE TABLE patient_history  AS
SELECT case_id,age_years,color_ethnicity,hypertension_past_reported,hypertension_past_treatment,
       diabetes_mellitus_dm_reported,diabetes_mellitus_disease_gap,diabetes_mellitus_treatment,
	   tobacco_use,tobacco_use_in_months,tobacco_quantity_by_day,alcohol_use,alcohol_quantity_milliliters,
	   alcohol_preference,drugs_preference,drugs_years_of_use,drugs_during_pregnancy
	   FROM maternal_health_main;

ALTER TABLE patient_history 
ADD CONSTRAINT ph_pk_case_id PRIMARY KEY(case_id)

---Create maternal_Fat sub table from Main table 
CREATE TABLE maternal_labor AS
SELECT case_id,gestational_age_at_inclusion,fetal_weight_at_ultrasound,weight_fetal_percentile
        miscarriage,gestational_age_at_birth,prepartum_maternal_weight,prepartum_maternal_height,
		delivery_mode,cesarean_section_reason,hospital_systolic_blood_pressure,
		hospital_diastolic_blood_pressure,hospital_hypertension,preeclampsia_record_pregnancy	
        chronic_diabetes,chronic_diseases,disease_diagnose_during_pregnancy
		treatment_disease_pregnancy,number_prenatal_appointments,expected_weight_for_the_newborn
		newborn_weight,newborn_height,newborn_head_circumference,thoracic_perimeter_of_newborn,
        meconium_in_labor,apgar_1st_min,apgar_5th_min,pediatric_resuscitation_maneuvers,
        intubation,newborn_airway_aspiration,mothers_hospital_stay FROM maternal_health;
		
ALTER TABLE maternal_labor 
ADD CONSTRAINT ph_pk_case_id PRIMARY KEY(case_id);



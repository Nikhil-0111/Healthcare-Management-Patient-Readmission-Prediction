#Create a schema named healthcare

create schema Healthcare;

#set healthcare as the default schema

use healthcare;

CREATE TABLE diabetic_data (
    encounter_id BIGINT,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(20),
    age VARCHAR(20),
    weight VARCHAR(20),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    payer_code VARCHAR(20),
    medical_specialty VARCHAR(100),
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    diag_1 VARCHAR(20),
    diag_2 VARCHAR(20),
    diag_3 VARCHAR(20),
    number_diagnoses INT,
    max_glu_serum VARCHAR(20),
    A1Cresult VARCHAR(20),
    metformin VARCHAR(20),
    repaglinide VARCHAR(20),
    nateglinide VARCHAR(20),
    chlorpropamide VARCHAR(20),
    glimepiride VARCHAR(20),
    acetohexamide VARCHAR(20),
    glipizide VARCHAR(20),
    glyburide VARCHAR(20),
    tolbutamide VARCHAR(20),
    pioglitazone VARCHAR(20),
    rosiglitazone VARCHAR(20),
    acarbose VARCHAR(20),
    miglitol VARCHAR(20),
    troglitazone VARCHAR(20),
    tolazamide VARCHAR(20),
    examide VARCHAR(20),
    citoglipton VARCHAR(20),
    insulin VARCHAR(20),
    glyburide_metformin VARCHAR(20),
    glipizide_metformin VARCHAR(20),
    glimepiride_pioglitazone VARCHAR(20),
    metformin_rosiglitazone VARCHAR(20),
    metformin_pioglitazone VARCHAR(20),
    Change_ VARCHAR(10),
    diabetesMed VARCHAR(10),
    readmitted VARCHAR(20)
);


SELECT 
    COUNT(DISTINCT encounter_id) AS total_patient_encounters
FROM
    diabetic_data;


SELECT 
    diagnosis, COUNT(*) AS frequency
FROM
    (SELECT 
        diag_1 AS diagnosis
    FROM
        diabetic_data UNION ALL SELECT 
        diag_2
    FROM
        diabetic_data UNION ALL SELECT 
        diag_3
    FROM
        diabetic_data data) AS All_Diag
WHERE
    diagnosis IS NOT NULL
        AND diagnosis <> '?'
GROUP BY diagnosis
ORDER BY frequency DESC
LIMIT 10;

/*•	the average length of hospital stay
 for each admission type */
 


SELECT 
    admission_type_id,
    AVG(time_in_hospital) AS avg_stay_in_hospital
FROM
    diabetic_data
GROUP BY admission_type_id
ORDER BY avg_stay_in_hospital DESC

/*•	Determine the number of readmitted patients
 and the percentage of total encounters that they represent */
 
SELECT 
    readmitted,
    COUNT(*) AS num_encounters,
    ROUND(COUNT(*) * 100 / (SELECT 
                    COUNT(*)
                FROM
                    diabetic_data),
            2) AS percent_readmitted_encounters
FROM
    diabetic_data
GROUP BY readmitted
ORDER BY num_encounters
 
 #•	Identify the age distribution of patients 
 
 select age,count(*) as age_distribution
 from diabetic_data 
 Group by   age;
 
 /*•	Identify the most common procedures performed during patient encounters */
 
 select num_procedures,count(*) as patient_encounters from diabetic_data
 group by num_procedures
 order by patient_encounters desc;
 
 /* Calculate the average number of medications prescribed for patients in each age
group*/

select age,count(*) as no_patient_by_age,
avg(num_medications) as avg_num_medications from diabetic_data
group by age 
order by age ;

#• Identify the distribution of readmission rates across different payer codes

select payer_code,readmitted,count(*) as encounters,
round(count(*)*100.0/( sum(count(*)) over (partition by payer_code)),2 )
as percentage 
from diabetic_data
 where  payer_code is not null <> '?'
group by payer_code,readmitted
order by payer_code,readmitted ;

 

 
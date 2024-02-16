create or replace view DW_PROD.REPORT.CLIENT_METRICS_FOR_SLT_FJN(
	SERVICE_YEAR,
	STATE_CODE,
	CLIENT_KEY,
	CLIENT_ETHNICITY,
	CLIENT_GENDER,
	NUMBER_WITH_SERVICE,
	REFERRAL_DATE,
	FIRST_SERVICE_MONTH,
	FIRST_SERVICE,
	LAST_SERVICE,
	TENURE,
	NUMBER_WO_SERVICE,
	AGE_AT_END_OF_SERVICE,
	AGE_GROUP,
	TENURE_CATEGORY,
	PCT_MONTHS_SERVED
) as
WITH candidate_clients_2018 AS (
SELECT DISTINCT cdmv.Client_Key, DATE_TRUNC( 'YEAR', cdmv.Service_Month) AS Service_Year
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
WHERE cdmv.Service_Month BETWEEN CAST( '2018-12-01' AS DATE) AND CAST( '2018-12-01' AS DATE)
AND  cdmv.Number_of_Visits IS NOT NULL
),
candidate_clients_2019 AS (
SELECT DISTINCT cdmv.Client_Key, DATE_TRUNC( 'YEAR', cdmv.Service_Month) AS Service_Year
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
WHERE cdmv.Service_Month BETWEEN CAST( '2019-12-01' AS DATE) AND CAST( '2019-12-01' AS DATE)
AND  cdmv.Number_of_Visits IS NOT NULL
),
candidate_clients_2020 AS (
SELECT DISTINCT cdmv.Client_Key, DATE_TRUNC( 'YEAR', cdmv.Service_Month) AS Service_Year
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
WHERE cdmv.Service_Month BETWEEN CAST( '2020-12-01' AS DATE) AND CAST( '2020-12-01' AS DATE)
--AND  cdmv.State_Code = 'IL'
AND  cdmv.Number_of_Visits IS NOT NULL
),
candidate_clients AS (
SELECT DISTINCT cdmv.Client_Key, DATE_TRUNC( 'YEAR', cdmv.Service_Month) AS Service_Year
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
--WHERE cdmv.Service_Month IN ( CAST( '2018-12-01' AS DATE), CAST( '2019-12-01' AS DATE), CAST( '2020-12-01' AS DATE))
WHERE cdmv.Service_Month BETWEEN CAST( '2018-01-01' AS DATE) AND CAST( '2020-12-01' AS DATE)
AND  cdmv.Number_of_Visits IS NOT NULL
),
IL_oldest_clients AS (
SELECT DISTINCT Source_System_ID, State_Code, cdmv.Client_Key, referral_Date, Lifetime_First_Service_Month, DATEDIFF( 'MONTH', NVL( Referral_Date, Lifetime_First_Service_Month), Lifetime_First_Service_Month) AS Time_To_Service
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
INNER JOIN candidate_clients AS cc ON cc.Client_Key = cdmv.Client_Key
WHERE Referral_Date < Lifetime_First_Service_Month
AND LifeTime_First_Service_Month <= '2013-01-01'
AND State_Code = 'IL'
AND State_Code IS NOT NULL
AND DATEDIFF( 'MONTH', Referral_Date, Lifetime_First_Service_Month) <> 0
)
SELECT cc.Service_Year, 
       cl.Client_State_Code AS State_Code,
       cdmv.Client_Key,
       cl.Client_Ethnicity, cl.Client_Gender,
       COUNT( cdmv.Service_Month) AS Number_with_Service,
       iloc.Referral_Date AS Referral_Date,
       MIN( cdmv.Service_Month) AS First_Service_Month,
       LEAST( MIN( cdmv.Service_Month), NVL( iloc.Referral_Date, MIN( cdmv.Service_Month))) AS First_Service,
       MAX( cdmv.Service_Month) AS Last_Service,
       DATEDIFF( 'MONTH', First_Service, Last_Service) + 1 AS Tenure,
       Tenure - Number_with_Service AS Number_wo_Service,
       CASE WHEN cl.Client_DOB IS NULL OR Client_DOB = CAST( '1900-01-01' AS DATE) THEN NULL
            ELSE DATEDIFF( 'YEAR', cl.Client_DOB, Last_Service) 
       END AS Age_At_End_of_Service,
       CASE WHEN Age_At_End_Of_Service <= 65 THEN '65 and under'
            ELSE 'Over 65'
       END AS Age_Group,
       CASE WHEN Tenure <= 4 THEN '1: <= 4 Months'
            WHEN Tenure BETWEEN 5 AND 6 THEN '2: 5 - 6 Months'
            WHEN Tenure BETWEEN 7 AND 12 THEN '3: 7 - 12 Months'
            WHEN Tenure BETWEEN 13 AND 24 THEN '4: 13 - 24 Months'
            WHEN Tenure BETWEEN 25 AND 36 THEN '5: 25 - 36 Months'
            WHEN Tenure BETWEEN 37 AND 60 THEN '6: 37 - 60 Months'
            WHEN Tenure BETWEEN 61 AND 120 THEN '7: 61 - 120 Months'
            WHEN Tenure > 120 THEN '8: > 120 Months'
            ELSE 'UnKnown'
       END AS Tenure_Category,
       CASE WHEN ROUND( (Number_With_Service / Tenure), 2) = 1 THEN '1: 100% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) > .95 THEN '2: > 95% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) <= .95 AND ROUND( (Number_With_Service / Tenure), 2) >= .75 THEN '3: 75% - 95% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .75 AND ROUND( (Number_With_Service / Tenure), 2) >= .50 THEN '4: 50% - 74% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .50 AND ROUND( (Number_With_Service / Tenure), 2) >= .25 THEN '5: 25% - 49% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .25 THEN '5: < 25% months with service'
            ELSE 'UnKnown'
       END AS Pct_Months_Served
/*      
       Number_of_Gaps_in_Service, Smallest_Gap_in_Service, Largest_Gap_in_Service,
       CASE WHEN Largest_Gap_in_Service IS NULL THEN '1: No Gaps'
            WHEN Largest_Gap_in_Service < 4 THEN '2: < 4 Months'
            WHEN Largest_Gap_in_Service BETWEEN 4 AND 6 THEN '3: 4 - 6 Months'
            WHEN Largest_Gap_in_Service BETWEEN 7 AND 12 THEN '4: 7 - 12 Months'
            WHEN Largest_Gap_in_Service BETWEEN 13 AND 24 THEN '5: 13 - 24 Months'
            WHEN Largest_Gap_in_Service BETWEEN 25 AND 36 THEN '6: 25 - 36 Months'
            WHEN Largest_Gap_in_Service BETWEEN 37 AND 60 THEN '7: 37 - 60 Months'
            WHEN Largest_Gap_in_Service BETWEEN 61 AND 120 THEN '8: 61 - 120 Months'
            WHEN Largest_Gap_in_Service > 120 THEN '9: > 120 Months'
            ELSE 'UnKnown'
       END AS Largest_Gap_Category
*/
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
INNER JOIN DW_PROD.HAH.DIM_Client AS cl ON cdmv.Client_Key = cl.Client_Key
INNER JOIN candidate_clients_2020 AS cc ON cc.Client_Key = cdmv.Client_Key
LEFT OUTER JOIN IL_oldest_clients AS iloc ON iloc.Client_Key = cdmv.Client_Key
--WHERE cdmv.First_Service_Month <= CAST( '2020-12-31' AS DATE)
--WHERE cdmv.Last_Service_Month BETWEEN CAST( '2020-01-01' AS DATE) AND CAST( '2020-12-01' AS DATE)
WHERE cdmv.Service_Month <= CAST( '2020-12-31' AS DATE)
AND  cdmv.Number_of_Visits IS NOT NULL
GROUP BY cc.Service_Year, cl.Client_State_Code, cdmv.Client_Key, cl.Client_Ethnicity, cl.Client_Gender, cl.Client_DOB, iloc.Referral_Date
UNION
SELECT cc.Service_Year, 
       cl.Client_State_Code AS State_Code,
       cdmv.Client_Key,
       cl.Client_Ethnicity, cl.Client_Gender,
       COUNT( cdmv.Service_Month) AS Number_with_Service,
       iloc.Referral_Date AS Referral_Date,
       MIN( cdmv.Service_Month) AS First_Service_Month,
       LEAST( MIN( cdmv.Service_Month), NVL( iloc.Referral_Date, MIN( cdmv.Service_Month))) AS First_Service,
       MAX( cdmv.Service_Month) AS Last_Service,
       DATEDIFF( 'MONTH', First_Service, Last_Service) + 1 AS Tenure,
       Tenure - Number_with_Service AS Number_wo_Service,
       CASE WHEN cl.Client_DOB IS NULL OR Client_DOB = CAST( '1900-01-01' AS DATE) THEN NULL
            ELSE DATEDIFF( 'YEAR', cl.Client_DOB, Last_Service) 
       END AS Age_At_End_of_Service,
       CASE WHEN Age_At_End_Of_Service <= 65 THEN '65 and under'
            ELSE 'Over 65'
       END AS Age_Group,
       CASE WHEN Tenure <= 4 THEN '1: <= 4 Months'
            WHEN Tenure BETWEEN 5 AND 6 THEN '2: 5 - 6 Months'
            WHEN Tenure BETWEEN 7 AND 12 THEN '3: 7 - 12 Months'
            WHEN Tenure BETWEEN 13 AND 24 THEN '4: 13 - 24 Months'
            WHEN Tenure BETWEEN 25 AND 36 THEN '5: 25 - 36 Months'
            WHEN Tenure BETWEEN 37 AND 60 THEN '6: 37 - 60 Months'
            WHEN Tenure BETWEEN 61 AND 120 THEN '7: 61 - 120 Months'
            WHEN Tenure > 120 THEN '8: > 120 Months'
            ELSE 'UnKnown'
       END AS Tenure_Category,
       CASE WHEN ROUND( (Number_With_Service / Tenure), 2) = 1 THEN '1: 100% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) > .95 THEN '2: > 95% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) <= .95 AND ROUND( (Number_With_Service / Tenure), 2) >= .75 THEN '3: 75% - 95% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .75 AND ROUND( (Number_With_Service / Tenure), 2) >= .50 THEN '4: 50% - 74% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .50 AND ROUND( (Number_With_Service / Tenure), 2) >= .25 THEN '5: 25% - 49% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .25 THEN '5: < 25% months with service'
            ELSE 'UnKnown'
       END AS Pct_Months_Served
/*      
       Number_of_Gaps_in_Service, Smallest_Gap_in_Service, Largest_Gap_in_Service,
       CASE WHEN Largest_Gap_in_Service IS NULL THEN '1: No Gaps'
            WHEN Largest_Gap_in_Service < 4 THEN '2: < 4 Months'
            WHEN Largest_Gap_in_Service BETWEEN 4 AND 6 THEN '3: 4 - 6 Months'
            WHEN Largest_Gap_in_Service BETWEEN 7 AND 12 THEN '4: 7 - 12 Months'
            WHEN Largest_Gap_in_Service BETWEEN 13 AND 24 THEN '5: 13 - 24 Months'
            WHEN Largest_Gap_in_Service BETWEEN 25 AND 36 THEN '6: 25 - 36 Months'
            WHEN Largest_Gap_in_Service BETWEEN 37 AND 60 THEN '7: 37 - 60 Months'
            WHEN Largest_Gap_in_Service BETWEEN 61 AND 120 THEN '8: 61 - 120 Months'
            WHEN Largest_Gap_in_Service > 120 THEN '9: > 120 Months'
            ELSE 'UnKnown'
       END AS Largest_Gap_Category
*/
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
INNER JOIN DW_PROD.HAH.DIM_Client AS cl ON cdmv.Client_Key = cl.Client_Key
INNER JOIN candidate_clients_2019 AS cc ON cc.Client_Key = cdmv.Client_Key
LEFT OUTER JOIN IL_oldest_clients AS iloc ON iloc.Client_Key = cdmv.Client_Key
--WHERE cdmv.First_Service_Month <= CAST( '2020-12-31' AS DATE)
--WHERE cdmv.Last_Service_Month BETWEEN CAST( '2020-01-01' AS DATE) AND CAST( '2020-12-01' AS DATE)
WHERE cdmv.Service_Month <= CAST( '2019-12-31' AS DATE)
AND  cdmv.Number_of_Visits IS NOT NULL
GROUP BY cc.Service_Year, cl.Client_State_Code, cdmv.Client_Key, cl.Client_Ethnicity, cl.Client_Gender, cl.Client_DOB, iloc.Referral_Date
UNION
SELECT cc.Service_Year, 
       cl.Client_State_Code AS State_Code,
       cdmv.Client_Key,
       cl.Client_Ethnicity, cl.Client_Gender,
       COUNT( cdmv.Service_Month) AS Number_with_Service,
       iloc.Referral_Date AS Referral_Date,
       MIN( cdmv.Service_Month) AS First_Service_Month,
       LEAST( MIN( cdmv.Service_Month), NVL( iloc.Referral_Date, MIN( cdmv.Service_Month))) AS First_Service,
       MAX( cdmv.Service_Month) AS Last_Service,
       DATEDIFF( 'MONTH', First_Service, Last_Service) + 1 AS Tenure,
       Tenure - Number_with_Service AS Number_wo_Service,
       CASE WHEN cl.Client_DOB IS NULL OR Client_DOB = CAST( '1900-01-01' AS DATE) THEN NULL
            ELSE DATEDIFF( 'YEAR', cl.Client_DOB, Last_Service) 
       END AS Age_At_End_of_Service,
       CASE WHEN Age_At_End_Of_Service <= 65 THEN '65 and under'
            ELSE 'Over 65'
       END AS Age_Group,
       CASE WHEN Tenure <= 4 THEN '1: <= 4 Months'
            WHEN Tenure BETWEEN 5 AND 6 THEN '2: 5 - 6 Months'
            WHEN Tenure BETWEEN 7 AND 12 THEN '3: 7 - 12 Months'
            WHEN Tenure BETWEEN 13 AND 24 THEN '4: 13 - 24 Months'
            WHEN Tenure BETWEEN 25 AND 36 THEN '5: 25 - 36 Months'
            WHEN Tenure BETWEEN 37 AND 60 THEN '6: 37 - 60 Months'
            WHEN Tenure BETWEEN 61 AND 120 THEN '7: 61 - 120 Months'
            WHEN Tenure > 120 THEN '8: > 120 Months'
            ELSE 'UnKnown'
       END AS Tenure_Category,
       CASE WHEN ROUND( (Number_With_Service / Tenure), 2) = 1 THEN '1: 100% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) > .95 THEN '2: > 95% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) <= .95 AND ROUND( (Number_With_Service / Tenure), 2) >= .75 THEN '3: 75% - 95% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .75 AND ROUND( (Number_With_Service / Tenure), 2) >= .50 THEN '4: 50% - 74% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .50 AND ROUND( (Number_With_Service / Tenure), 2) >= .25 THEN '5: 25% - 49% months with service'
            WHEN ROUND( (Number_With_Service / Tenure), 2) < .25 THEN '5: < 25% months with service'
            ELSE 'UnKnown'
       END AS Pct_Months_Served
/*      
       Number_of_Gaps_in_Service, Smallest_Gap_in_Service, Largest_Gap_in_Service,
       CASE WHEN Largest_Gap_in_Service IS NULL THEN '1: No Gaps'
            WHEN Largest_Gap_in_Service < 4 THEN '2: < 4 Months'
            WHEN Largest_Gap_in_Service BETWEEN 4 AND 6 THEN '3: 4 - 6 Months'
            WHEN Largest_Gap_in_Service BETWEEN 7 AND 12 THEN '4: 7 - 12 Months'
            WHEN Largest_Gap_in_Service BETWEEN 13 AND 24 THEN '5: 13 - 24 Months'
            WHEN Largest_Gap_in_Service BETWEEN 25 AND 36 THEN '6: 25 - 36 Months'
            WHEN Largest_Gap_in_Service BETWEEN 37 AND 60 THEN '7: 37 - 60 Months'
            WHEN Largest_Gap_in_Service BETWEEN 61 AND 120 THEN '8: 61 - 120 Months'
            WHEN Largest_Gap_in_Service > 120 THEN '9: > 120 Months'
            ELSE 'UnKnown'
       END AS Largest_Gap_Category
*/
FROM DW_DEV.Report.Client_Derived_Monthly_Visit_Metrics_FJN AS cdmv
INNER JOIN DW_PROD.HAH.DIM_Client AS cl ON cdmv.Client_Key = cl.Client_Key
INNER JOIN candidate_clients_2018 AS cc ON cc.Client_Key = cdmv.Client_Key
LEFT OUTER JOIN IL_oldest_clients AS iloc ON iloc.Client_Key = cdmv.Client_Key
--WHERE cdmv.First_Service_Month <= CAST( '2020-12-31' AS DATE)
--WHERE cdmv.Last_Service_Month BETWEEN CAST( '2020-01-01' AS DATE) AND CAST( '2020-12-01' AS DATE)
WHERE cdmv.Service_Month <= CAST( '2018-12-31' AS DATE)
AND  cdmv.Number_of_Visits IS NOT NULL
GROUP BY cc.Service_Year, cl.Client_State_Code, cdmv.Client_Key, cl.Client_Ethnicity, cl.Client_Gender, cl.Client_DOB, iloc.Referral_Date;
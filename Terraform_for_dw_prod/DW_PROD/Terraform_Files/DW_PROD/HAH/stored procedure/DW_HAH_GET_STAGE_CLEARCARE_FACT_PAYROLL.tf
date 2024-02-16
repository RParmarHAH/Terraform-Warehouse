resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_FACT_PAYROLL" {
	name ="GET_STAGE_CLEARCARE_FACT_PAYROLL"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
INSERT OVERWRITE INTO STAGE.CLEARCARE_FACT_PAYROLL
WITH EMPLOYEE AS 
(
	SELECT
		*
	FROM
		(
		SELECT
			CAREGIVER_ID,
			MASTER_ID,
			AGENCY_ID
		FROM
			DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT
		*
	FROM
		(
		SELECT
			DISTINCT CAREGIVER_ID,
			MASTER_ID,
			AGENCY_ID
		FROM
			DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.EMPLOYEE_MATCH_LIST
		WHERE
			CAREGIVER_ID NOT IN (
			SELECT
				CAREGIVER_ID
			FROM
				DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.EMPLOYEE_MASTER_LIST ) 
	) 
),
EXPENSES AS (
    SELECT DISTINCT CA.ID, SUM(BI.PAY_AMOUNT) AS NON_SERVICE_PAY_AMOUNT, ROUND((SUM(BI.PAY_AMOUNT) / AVG(BI.PAY_RATE)),1) AS NON_SERVICE_UNITS
    FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.CARELOGS_CARELOG CA
    INNER JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.BILLING_ITEM BI ON BI.CARELOG_ID = CA.ID
    WHERE BI.PAY = TRUE
    GROUP BY 1
)
SELECT MD5 (
    ''CLEARCARE'' || CA.ID || NVL(CA.PAY_RATE_OBJ_ID,-1) || ''CLEARCARE''
) AS PAYROLL_KEY
,CA.SHIFT_DATE AS REPORT_DATE
,MD5(
        ''CLEARCARE'' || ''-'' || EM.MASTER_ID::INT  || ''-'' || ''CLEARCARE''
    ) AS EMPLOYEE_KEY
,MD5(
        AG.AGENCY_ID || ''-'' || AG.NAME || ''-'' || ''CLEARCARE''
    ) AS BRANCH_KEY
,16 AS SOURCE_SYSTEM_ID
,CASE WHEN DAYNAME(CA.SHIFT_DATE) = ''Fri'' THEN DATEADD(day, 7, CA.SHIFT_DATE) 
           WHEN DAYNAME(CA.SHIFT_DATE) = ''Sat'' THEN DATEADD(day, 6, CA.SHIFT_DATE) 
           ELSE NEXT_DAY(DATEADD(day, 7, CA.SHIFT_DATE), ''Fri'') 
           END AS PAYROLL_DATE
,EM.MASTER_ID::INT AS EMPLOYEE_ID
,UPPER(AG.NAME) AS BRANCH_NAME
,''CLEARCARE'' AS SYSTEM_CODE
,DATEADD(DAY, -12, PAYROLL_DATE) AS PAY_PERIOD_START_DATE
,DATEADD(DAY, -6, PAYROLL_DATE) AS PAY_PERIOD_END_DATE
,CA.PAY_RATE_OBJ_ID AS CHECK_NUMBER
,NVL(CA.TOTAL_HOURS,0) + NVL(CA.PAY_AUTO_OT,0) AS PAY_HOURS
,NVL(CA.TOTAL_HOURS,0) AS SERVICE_HOURS
,NVL(CA.PAY_AUTO_OT,0) AS OVERTIME_HOURS
,NULL AS NON_SERVICE_UNITS
,NULL AS SICK_HOURS
,NULL AS VACATION_HOURS
,CA.PAY_RATE_AMOUNT AS PAY_RATE
,CASE WHEN CA.PAY_AUTO_OT IS NOT NULL AND CA.PAY_AUTO_OT != 0 THEN (NVL(CA.PAY_AMOUNT,0) - (PAY_RATE * SERVICE_HOURS)) / OVERTIME_HOURS
ELSE 0
END AS OVERTIME_RATE
,(PAY_RATE * SERVICE_HOURS) + (OVERTIME_RATE * OVERTIME_HOURS) AS GROSS_PAY_AMOUNT
,PAY_RATE * SERVICE_HOURS AS SERVICE_PAY_AMOUNT
,OVERTIME_RATE * OVERTIME_HOURS AS OVERTIME_PAY_AMOUNT
,NULL AS NON_SERVICE_PAY_AMOUNT
,NULL AS TAX_AMOUNT
,GROSS_PAY_AMOUNT AS NET_PAY_AMOUNT
,NULL AS OTHER_DEDUCTIONS_AMOUNT
,NULL AS UNION_DUES_AMOUNT
,NVL(EX.NON_SERVICE_PAY_AMOUNT,0) AS REIMBURSEMENT_AMOUNT,
	-- ETL Fields
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
CURRENT_USER as ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
CURRENT_USER as ETL_LAST_UPDATED_BY,
0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.CARELOGS_CARELOG CA
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PATIENT_PATIENT PA ON PA.ID = CA.PATIENT_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.AGENCY_AGENCYLOCATION AG ON AG.ID = PA.LOCATION_ID
LEFT JOIN EMPLOYEE EM ON EM.CAREGIVER_ID = CA.CAREGIVER_ID AND EM.AGENCY_ID = CA.AGENCY_ID
LEFT JOIN EXPENSES EX ON EX.ID = CA.ID
where AG.AGENCY_ID IN (2459);
 
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}


resource "snowflake_procedure" "DW_HAH_MDM_DIM_EMPLOYEE_TP" {
	name ="MDM_DIM_EMPLOYEE_TP"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"

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

        var sql = `
    INSERT INTO DW_${var.SF_ENVIRONMENT}.HAH.MDM_DIM_EMPLOYEE
with employee_TP as 
(SELECT *
													 , RANK() OVER (PARTITION BY emp.EMPLOYEE_SSN
													   ORDER BY IFF(emp.EMPLOYEE_LAST_WORKED_DATE ::date = ''1900-01-01'', ''9999-12-31'', 
													   emp.EMPLOYEE_LAST_WORKED_DATE ::date) DESC,emp.PAYROLL_DATE desc, 
													   emp.EMPLOYEE_HIRE_DATE DESC, ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC) as rnk_SSN
													 , RANK() OVER (PARTITION BY emp.EMPLOYEE_NUMBER
													   ORDER BY IFF(emp.EMPLOYEE_LAST_WORKED_DATE::date = ''1900-01-01'', ''9999-12-31'', 
													   emp.EMPLOYEE_LAST_WORKED_DATE::date) DESC,emp.PAYROLL_DATE desc, 
													   emp.EMPLOYEE_HIRE_DATE DESC, ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC) as rnk_pay

FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.VW_SAT_EMPLOYEE_TRUSTPOINT emp),

Sandata_already_in_TP AS
(
    SELECT SNEMP.*,
    ROW_NUMBER() OVER (PARTITION BY SNEMP.HASH_EMPLOYEE_KEY
						ORDER BY IFF(SNEMP.UPDATEDAT::date=''1900-01-01'', ''9999-12-31'',SNEMP.UPDATEDAT::date) DESC,NVL(SNEMP.REHIREDATE,''1900-01-01'') desc, 
						NVL(SNEMP.EOE,''1900-01-01'') DESC,NVL(SNEMP.STATE,''A'') DESC,SNEMP.STAFFID desc,SNEMP.ETL_LAST_UPDATED_DATE DESC, SNEMP.ETL_INSERTED_DATE DESC) AS rnk_ssn
    FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.VW_SAT_EMPLOYEE_SANDATA SNEMP
    INNER JOIN DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.LINK_EMPLOYEE LNKEMP
    ON SNEMP.HASH_EMPLOYEE_KEY = LNKEMP.HASH_EMPLOYEE_KEY
    AND LNKEMP.source_system_id=6
),

Sandata AS
(
 
    SELECT SNEMP.*,
    ROW_NUMBER() OVER (PARTITION BY SNEMP.HASH_EMPLOYEE_KEY
						ORDER BY IFF(SNEMP.UPDATEDAT::date=''1900-01-01'', ''9999-12-31'',SNEMP.UPDATEDAT::date) DESC,NVL(SNEMP.REHIREDATE,''1900-01-01'') desc, 
						NVL(SNEMP.EOE,''1900-01-01'') DESC,NVL(SNEMP.STATE,''A'') DESC,SNEMP.STAFFID desc,SNEMP.ETL_LAST_UPDATED_DATE DESC, SNEMP.ETL_INSERTED_DATE DESC) AS rnk_ssn
    FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.VW_SAT_EMPLOYEE_SANDATA SNEMP
    WHERE HASH_EMPLOYEE_KEY NOT IN (
      SELECT HASH_EMPLOYEE_KEY FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.LINK_EMPLOYEE LNKEMP
       WHERE LNKEMP.source_system_id = 6)
)

--/*****************************************************





SELECT 
    EMP_HUB.HASH_EMPLOYEE_KEY AS EMPLOYEE_KEY,
    EMP_HUB.EMPLOYEE_SID as EMPLOYEE_PID,
	EMP_HUB.RECORD_SOURCE_SYSTEM_ID,
    CASE WHEN tp.Employee_DOB >= CAST( ''1901-01-01'' AS DATE) AND tp.Employee_DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN tp.Employee_DOB
         WHEN stf.DOB >= CAST( ''1901-01-01'' AS DATE) AND stf.DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN stf.DOB	
         ELSE NULL
    END AS EMPLOYEE_DOB

--==========================================================
      ,CASE WHEN tp.Employee_Hire_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Hire_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Hire_Date >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN tp.Employee_Hire_Date
          WHEN stf.SOE >= CAST( ''1960-01-01'' AS DATE) AND stf.SOE <= DATEADD( YEAR, +1, CURRENT_DATE) AND stf.SOE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.SOE
          ELSE NULL
       END AS EMPLOYEE_HIRE_DATE

--==========================================================

   ,CASE WHEN tp.Employee_Rehire_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Rehire_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Rehire_Date >= DATEADD( YEAR, 12, NVL( Employee_Hire_Date, CAST(''1948-01-01'' AS DATE))) THEN tp.Employee_Rehire_Date
    WHEN stf.RehireDate >= CAST( ''1960-01-01'' AS DATE) AND stf.RehireDate <= DATEADD( YEAR, +1, CURRENT_DATE) AND stf.RehireDate >= DATEADD( YEAR, 12, NVL( Employee_Hire_Date, CAST(''1948-01-01'' AS DATE))) THEN stf.RehireDate
    ELSE NULL
    END AS EMPLOYEE_REHIRE_DATE
	
--==========================================================	
     , NULL AS Employee_Benefit_Start_Date
     , NULL AS Employee_First_Check_Date
     , NULL AS Employee_Last_Check_Date

    ,CASE WHEN (stf.Title <> ''-1'' AND stf.Title IS NOT NULL) THEN UPPER( stf.Title)
          ELSE NULL
       END AS EMPLOYEE_PREFIX
--==========================================================


	
     ,CASE WHEN UPPER( TRIM( tp.Employee_First_Name)) <> '''' THEN UPPER( TRIM( tp.Employee_First_Name))
          WHEN UPPER( TRIM( stf.FirstName)) <> '''' AND UPPER( TRIM( stf.FirstName)) IS NOT NULL THEN UPPER( TRIM( stf.FirstName))
          ELSE NULL
     END AS EMPLOYEE_FIRST_NAME

--==========================================================

	,CASE WHEN UPPER( TRIM( tp.Employee_Last_Name)) <> '''' THEN UPPER( TRIM( tp.Employee_Last_Name))
         WHEN UPPER( TRIM( stf.LastName)) <> '''' AND UPPER( TRIM( stf.LastName)) IS NOT NULL THEN UPPER( TRIM( stf.LastName))
         ELSE NULL
       END AS EMPLOYEE_LAST_NAME

--==========================================================
	
	,CASE WHEN UPPER(TRIM(tp.Employee_MIDDLE_NAME))<>'''' THEN TRIM(UPPER(replace(tp.Employee_Middle_Name,'''')))
         WHEN UPPER(TRIM(stf.MIDDLEInitial))<>'''' AND UPPER(TRIM(stf.MIDDLEInitial)) IS NOT NULL THEN TRIM(UPPER(replace(stf.MiddleInitial,'''')))
         ELSE NULL
       END AS EMPLOYEE_MIDDLE_NAME

--==========================================================

    ,CASE WHEN UPPER( TRIM( tp.Employee_Suffix)) <> '''' THEN UPPER( TRIM( tp.Employee_Suffix))
         WHEN UPPER( TRIM( stf.Suffix)) <> '''' AND UPPER( TRIM( stf.Suffix)) IS NOT NULL THEN UPPER( TRIM( stf.Suffix))
         ELSE NULL
       END AS EMPLOYEE_SUFFIX
	
--==========================================================	
       ,NULL AS Employee_Department

--==========================================================	
     ,case when (UPPER(tp.Employee_State_Code)=UPPER(st.State_ISO_Code)) then UPPER(st.State_ISO_Code)
	      when (UPPER(stf.State)=UPPER(st.State_ISO_Code)) then UPPER(st.State_ISO_Code)
		  else null
		  END AS EMPLOYEE_STATE_CODE
--==========================================================

     ,case when (UPPER(tp.Employee_ZIP)=UPPER(zip.Zip_Code)) then UPPER(zip.Zip_Code)
	      when (UPPER(stf.ZIP)=UPPER(zip.Zip_Code)) then UPPER(zip.Zip_Code)
		  else null
       END AS EMPLOYEE_ZIP
	
--==========================================================	
    ,COALESCE(tp.SUTA_STATE,stf.STATE) AS SUTA_STATE

--==========================================================	
    ,COALESCE(tp.WORK_STATE,stf.STATE) AS WORK_STATE
	
--==========================================================	
    ,CASE WHEN UPPER( TRIM( tp.Employee_Gender)) = ''M'' THEN ''MALE''
         WHEN UPPER( TRIM( tp.Employee_Gender)) = ''F'' THEN ''FEMALE''
		 WHEN TRIM( stf.Sex) = ''1'' THEN ''MALE''
         WHEN TRIM( stf.Sex) = ''2'' THEN ''FEMALE''
    ELSE NULL
    END AS EMPLOYEE_GENDER

--==========================================================	
     , CASE WHEN UPPER( TRIM( tp.Employee_Ethnicity)) = ''UNIDENTIFIED/OPT OUT'' OR TRIM( tp.Employee_Ethnicity) = '''' OR tp.Employee_Ethnicity IS NULL THEN NULL
            WHEN TRIM( tp.Employee_Ethnicity) = ''Native Hawaiian or Other Pacific Islander (not Hispanic or Latino)'' THEN ''Native Hawaiian or Pacific Islander''
            WHEN TRIM( tp.Employee_Ethnicity) = ''Two or More Races (NHL)'' THEN ''Two or more races''
            WHEN TRIM( tp.Employee_Ethnicity) IS NOT NULL THEN TRIM( REPLACE( tp.Employee_Ethnicity, ''(not Hispanic or Latino)'', ''''))
            WHEN UPPER( stf.Ethnicity) = ''NONE'' OR TRIM( stf.Ethnicity) = '''' OR stf.Ethnicity IS NULL THEN NULL
            WHEN stf.Ethnicity = ''Native Hawaiian or Other Pacific Islander (NHL)'' THEN ''Native Hawaiian or Pacific Islander''
            WHEN stf.Ethnicity = ''Two or More Races (NHL)'' THEN ''Two or more races''
            WHEN stf.Ethnicity IS NOT NULL THEN TRIM( REPLACE( REPLACE( stf.Ethnicity, ''(NHL)'', ''''), ''(not Hispanic or Latino; NHL)'', ''''))
            ELSE NULL
		 END AS EMPLOYEE_ETHNICITY

--==========================================================		 
	,COALESCE(TRIM(tp.Employee_Type),TRIM(stf.Class)) AS EMPLOYEMENT_TYPE
			
--==========================================================
			
    ,TRIM( stf.Marital) AS EMPLOYEE_MARITAL_STATUS

--==========================================================

    ,COALESCE(tp.Active_Employee_Flag,IFF( stf.EOE IS NULL AND Status IN (''02''), ''TRUE'', ''FALSE'')) AS ACTIVE_EMPLOYEE_FLAG

--==========================================================	
	,CASE WHEN tp.Employee_Last_Worked_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Last_Worked_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Last_Worked_Date > Employee_Hire_Date THEN tp.Employee_Last_Worked_Date
         WHEN stf.EOE >= CAST( ''1960-01-01'' AS DATE) AND stf.EOE > Employee_Hire_Date AND stf.EOE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.EOE
         ELSE NULL
	END AS EMPLOYEE_LAST_WORKED_DATE

--==========================================================	
    ,CASE WHEN tp.Employee_Terminate_Date >= CAST( ''1960-01-01'' AS DATE) AND 
	tp.Employee_Terminate_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND 
	tp.Employee_Terminate_Date > Employee_Hire_Date THEN tp.Employee_Terminate_Date
	     WHEN stf.EOE < CAST( ''1960-01-01'' AS DATE) OR stf.EOE < stf.SOE OR stf.EOE < DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.EOE
         ELSE NULL
    END AS EMPLOYEE_TERMINATE_DATE

--==========================================================	
    ,tp.Reason_To_Terminate AS REASON_TO_TERMINATE

--==========================================================	
    ,CASE WHEN tp.Job_Title IS NOT NULL THEN TRIM( tp.Job_Title)
         WHEN stf.Position IS NOT NULL THEN TRIM( stf.Position) 
        ELSE NULL
    END AS JOB_TITLE,

--==========================================================	
    NULL AS JOB_DESCRIPTION,
	
--==========================================================	
    NULL AS CLASS_ID,

--==========================================================	
    NULL AS WORKERS_COMP,
	
--==========================================================	
    COALESCE(tp.Field_Worker_Flag,stf.FieldStaff) AS FIELD_WORKER_FLAG,
    CASE WHEN UPPER( tp.Field_Worker_Flag) = ''TRUE'' THEN ''Field''
         WHEN UPPER( tp.Field_Worker_Flag) = ''FALSE'' THEN ''Admin''
         WHEN UPPER( stf.FieldStaff) = ''TRUE'' THEN ''Field''
         WHEN UPPER( stf.FieldStaff) = ''FALSE'' THEN ''Admin''
            ELSE ''Field''
       END AS EMPLOYEE_CATEGORY,
    
	COALESCE(brnch.Branch_Key,COALESCE(BRANCH.BRANCH_KEY, MD5(stf.AGENCYID || ''-'' || NVL(stf.HOMELOCATION,'''') || ''-'' || ''SANDATAIMPORT''))) AS PRIMARY_BRANCH_KEY,
	
--==========================================================
	
    NULL AS ABLE_TO_REHIRE_FLAG,
	
--==========================================================	
    NULL AS PREVIOUS_WORKER_EMPLOYEE_KEY,
    NULL AS PREVIOUS_WORKER_EMPLOYEE_ID,
    NULL AS PREVIOUS_WORKER_TYPE,
    NULL AS PREVIOUS_WORKER_EFFECTIVE_FROM,
    NULL AS PREVIOUS_WORKER_EFFECTIVE_TO,
    `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
         
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
        
         convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
         CURRENT_USER as ETL_INSERTED_BY ,
         convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
         CURRENT_USER as ETL_LAST_UPDATED_BY,
         0 as ETL_DELETED_FLAG,
         0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.HUB_EMPLOYEE EMP_HUB
LEFT JOIN employee_TP TP
ON TP.HASH_EMPLOYEE_KEY = EMP_HUB.HASH_EMPLOYEE_KEY
and TP.rnk_ssn = 1 and TP.rnk_pay =1
LEFT JOIN Sandata_already_in_TP stf
on stf.HASH_EMPLOYEE_KEY = EMP_HUB.HASH_EMPLOYEE_KEY 
and stf.rnk_ssn = 1
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_Branch AS brnch ON brnch.SOURCE_SYSTEM_ID = 6 AND brnch.OFFICE_NUMBER = tp.EMPLOYEE_OFFICE_NUMBER
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH AS BRANCH ON BRANCH.SYSTEM_CODE = stf.AGENCYID AND BRANCH.OFFICE_CODE = stf.HOMELOCATION
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_State AS st ON UPPER(st.State_ISO_Code) = IFF( TRIM(UPPER(tp.Employee_State_Code))='''', UPPER(stf.State), TRIM( UPPER( tp.Employee_State_Code)))
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = IFF( TRIM( UPPER(tp.Employee_Zip))='''', UPPER(stf.Zip), TRIM( UPPER(tp.Employee_Zip)))
WHERE EMP_HUB.RECORD_SOURCE_SYSTEM_ID = 6

UNION ALL

SELECT 
    EMP_HUB.HASH_EMPLOYEE_KEY AS EMPLOYEE_KEY,
    EMP_HUB.EMPLOYEE_SID,
	EMP_HUB.RECORD_SOURCE_SYSTEM_ID
     , CASE WHEN stf.DOB >= CAST( ''1901-01-01'' AS DATE) AND stf.DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN stf.DOB
            ELSE NULL
       END AS EMPLOYEE_DOB
     , CASE WHEN stf.SOE >= CAST( ''1960-01-01'' AS DATE) AND stf.SOE <= DATEADD( YEAR, +1, CURRENT_DATE) AND stf.SOE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.SOE
            ELSE NULL
       END AS EMPLOYEE_HIRE_DATE
     , CASE WHEN stf.RehireDate >= CAST( ''1960-01-01'' AS DATE) AND stf.RehireDate <= DATEADD( YEAR, +1, CURRENT_DATE) AND stf.RehireDate >= DATEADD( YEAR, 12, NVL( Employee_Hire_Date, CAST(''1948-01-01'' AS DATE))) THEN stf.RehireDate
            ELSE NULL
       END AS EMPLOYEE_REHIRE_DATE
     , NULL AS Employee_Benefit_Start_Date
     , NULL AS Employee_First_Check_Date
     , NULL AS Employee_Last_Check_Date
     , CASE WHEN stf.Title <> ''-1'' AND stf.Title IS NOT NULL THEN UPPER( stf.Title)
            ELSE NULL
       END AS Employee_Prefix    
     , CASE WHEN UPPER( TRIM( stf.FirstName)) <> '''' AND UPPER( TRIM( stf.FirstName)) IS NOT NULL THEN UPPER( TRIM( stf.FirstName))
            ELSE NULL
       END AS Employee_First_Name
     , CASE WHEN UPPER( TRIM( stf.LastName)) <> '''' AND UPPER( TRIM( stf.LastName)) IS NOT NULL THEN UPPER( TRIM( stf.LastName))
            ELSE NULL
       END AS Employee_Last_Name
     , CASE WHEN UPPER( TRIM( stf.MIDDLEInitial)) <> '''' AND UPPER( TRIM( stf.MIDDLEInitial)) IS NOT NULL THEN TRIM( UPPER(replace(stf.MiddleInitial,'''')))
            ELSE NULL
       END AS Employee_Middle_Name
     , CASE WHEN UPPER( TRIM( stf.Suffix)) <> '''' AND UPPER( TRIM( stf.Suffix)) IS NOT NULL THEN UPPER( TRIM( stf.Suffix))
            ELSE NULL
       END AS Employee_Suffix
     , NULL AS Employee_Department
     , st.State_ISO_Code AS EMPLOYEE_STATE_CODE
     , zip.Zip_Code AS Employee_Zip
     , st.State_ISO_Code AS SUTA_State
     , stf.STATE AS Work_State
     , CASE WHEN TRIM( stf.Sex) = ''1'' THEN ''MALE''
            WHEN TRIM( stf.Sex) = ''2'' THEN ''FEMALE''
            ELSE NULL
       END AS Employee_Gender
     , CASE WHEN UPPER( stf.Ethnicity) = ''NONE'' OR TRIM( stf.Ethnicity) = '''' OR stf.Ethnicity IS NULL THEN NULL
            WHEN stf.Ethnicity = ''Native Hawaiian or Other Pacific Islander (NHL)'' THEN ''Native Hawaiian or Pacific Islander''
            WHEN stf.Ethnicity = ''Two or More Races (NHL)'' THEN ''Two or more races''
            WHEN stf.Ethnicity IS NOT NULL THEN TRIM( REPLACE( REPLACE( stf.Ethnicity, ''(NHL)'', ''''), ''(not Hispanic or Latino; NHL)'', ''''))
            ELSE NULL
       END AS Employee_Ethnicity
     , TRIM( stf.Class) AS Employee_Type
	 , TRIM( stf.Marital) AS Employee_Marital_Status	 
	 , IFF( stf.EOE IS NULL AND Status IN (''02''), ''TRUE'', ''FALSE'') AS Active_Employee_Flag
	, CASE WHEN stf.EOE >= CAST( ''1960-01-01'' AS DATE) AND stf.EOE > Employee_Hire_Date AND stf.EOE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.EOE
		ELSE NULL
		END AS Employee_Last_Worked_DATE
	, CASE WHEN stf.EOE < CAST( ''1960-01-01'' AS DATE) OR stf.EOE < stf.SOE OR stf.EOE < DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.EOE
		ELSE NULL
		END AS EMPLOYEE_TERMINATE_DATE
	, NULL AS Reason_To_Terminate
     , CASE WHEN stf.Position IS NOT NULL THEN TRIM( stf.Position) 
            ELSE NULL
       END AS Job_Title
     , NULL AS Job_Description
     , NULL AS Class_ID
     , NULL AS Workers_Comp
	 ,stf.FieldStaff AS FIELD_WORKER_FLAG
     , CASE WHEN stf.FieldStaff = ''TRUE'' THEN ''Field''
            WHEN stf.FieldStaff = ''FALSE'' THEN ''Admin''
            ELSE ''Field''
       END AS Employee_Category
     , COALESCE(BRANCH.BRANCH_KEY, MD5(stf.AGENCYID || ''-'' || NVL(stf.HOMELOCATION,'''') || ''-'' || ''SANDATAIMPORT'')) AS PRIMARY_BRANCH_KEY
     , NULL AS Able_to_Rehire_Flag
     , NULL AS PREVIOUS_WORKER_EMPLOYEE_KEY
     , NULL AS PREVIOUS_WORKER_EMPLOYEE_ID
     , NULL AS PREVIOUS_WORKER_TYPE
     , NULL AS PREVIOUS_WORKER_EFFECTIVE_FROM
     , NULL AS PREVIOUS_WORKER_EFFECTIVE_TO
     , -1 AS ETL_TASK_KEY
     , -1 AS ETL_INSERTED_TASK_KEY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.HUB_EMPLOYEE EMP_HUB 
LEFT JOIN SANDATA stf
on stf.HASH_EMPLOYEE_KEY = EMP_HUB.HASH_EMPLOYEE_KEY 
and stf.rnk_ssn = 1
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH AS BRANCH ON BRANCH.SYSTEM_CODE = stf.AGENCYID AND BRANCH.OFFICE_CODE = stf.HOMELOCATION
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.TrustPointData.Employees AS tp ON stf.AGENCYID = ''8485'' AND tp.EMPLOYEE_NUMBER = TRY_CAST(stf.STAFFAGENCYID AS INTEGER) 
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_State AS st ON st.State_ISO_Code = IFF( TRIM( UPPER( stf.State))='''', UPPER( tp.Employee_State_Code), TRIM( UPPER( stf.State)))
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = IFF( TRIM( UPPER( stf.Zip))='''', UPPER( tp.Employee_Zip), TRIM( UPPER( stf.Zip)))
WHERE EMP_HUB.RECORD_SOURCE_SYSTEM_ID=4 
AND stf.AgencyID = ''8485''
AND stf.Person = ''TRUE''
AND stf.ETL_LAST_UPDATED_DATE >= ''1900-01-01'' ;
`;
	          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}


resource "snowflake_procedure" "DW_HAH_GET_STAGE_SANDATAIMPORT_DIM_EMPLOYEE" {
	name ="GET_STAGE_SANDATAIMPORT_DIM_EMPLOYEE"
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
    --*****************************************************************************************************************************
-- NAME:  SandataImport_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to Sandata
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 02/21/20    Frank Noordover       Initial development
-- 04/01/20    Mohd Kamaludin        Added CDC
-- 05/04/20    Mohd Kamaludin        Updated Hash Employee to match Sandata Fact Visit and Fact Revenue (StaffAgencyID)
-- 06/21/20    Frank Noordover       Added logic for visit attributes and improve data quality
-- 10/22/20    Frank Noordover       Revised logic and added additional columns for DIM_EMPLOYEE     
-- 01/05/20    Mir Ali               Changed Branch_Key to be more consistent
-- 02/13/20    Frank Noordover       Fixed the State and Zip join logic for Sandata when State and Zip are empty strings
-- 09/08/21	   Mir Ali				 Fixed to accomodate other companies from TrustPoint
-- 02/10/23    Mirisha               Leveraged Dedupe
-- 09/25/2023  Trushali Ramoliya     added the logic for payroll_id
-- 11/10/2023  Deepen Gajjar         Added a logic for HISPANIC_OR_LATINO and update the logic for ethnicity as per ticket - IDDOX- 388.
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.SANDATAIMPORT_DIM_EMPLOYEE
WITH 
-- offbrnch AS
-- (
-- SELECT DISTINCT HomeLocation
--      , CASE WHEN HomeLocation = '''' OR HomeLocation = ''HAH'' THEN ''-1'' ELSE brnch.Office_Number END AS Employee_Office_Number
--      , CASE WHEN HomeLocation = '''' THEN ''2a3546e9ff960b04725a1f6823cd5b94'' WHEN HomeLocation = ''HAH'' THEN ''26090ef061fef40345a2fd24d38353fc'' ELSE brnch.Branch_Key END AS Primary_Branch_Key
--      , CASE WHEN HomeLocation = '''' THEN ''Unknown-PA'' WHEN HomeLocation = ''HAH'' THEN ''HAH'' ELSE brnch.Detailed_Office_Name END AS Primary_Branch_Name
--      , CASE WHEN HomeLocation = '''' THEN ''8485'' WHEN HomeLocation = ''HAH'' THEN ''8485'' ELSE brnch.System_Code END AS Primary_Branch_System_Code
--      , CASE WHEN HomeLocation = '''' THEN ''PA'' WHEN HomeLocation = ''HAH'' THEN ''PA'' ELSE brnch.Office_State_Code END AS Primary_Branch_State
-- FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Staffs AS stf
-- LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS AS eid ON stf.HomeLocation = eid.ExtID AND eid.Typ = ''L''
-- LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch ON LPAD( CAST( brnch.Office_Number AS VARCHAR), 3, ''0'') = LPAD( TRIM( eid.IntID), 3, ''0'') AND brnch.Source_System_ID = 4
-- WHERE AgencyID = ''8485''
-- AND Person = ''TRUE''
-- ),
employee_service_dates
AS
(
SELECT ss.AgencyID, sst.StaffID AS Employee_Number, CAST( MIN( ss.ScheduleDate) AS DATE) AS First_Service_Date, CAST( MAX( ss.ScheduleDate) AS DATE) AS Last_Service_Date
FROM DISC_${var.SF_ENVIRONMENT}.SanDataImport.SanData_Schedules AS ss
INNER JOIN DISC_${var.SF_ENVIRONMENT}.SanDataImport.SanData_SchedulesStaffs AS sst ON ss.AgencyID = sst.AgencyID AND ss.ScheduleID = sst.ScheduleID AND sst.Status IN ( ''05'')
WHERE ss.AgencyID = ''8485''
AND ss.Status NOT IN ( ''01'', ''09'', ''10'')
GROUP BY ss.AgencyID, sst.StaffID
)
SELECT DISTINCT
       MD5(NVL(stf.AGENCYID,''S'') || ''-'' || UPPER(COALESCE(TRY_CAST(STF.MASTER_ID AS INT)::STRING,TRIM(STF.MASTER_ID))) || ''-'' || ''1900-01-01'' || ''-'' || ''SANDATAIMPORT'') AS Employee_key
     , COALESCE(TRY_CAST(stf.MASTER_ID AS INT)::STRING, TRIM(stf.MASTER_ID)) AS Employee_ID
     , stf.AGENCYID AS System_Code
     , 4 AS Source_System_ID
     , CASE WHEN TRIM( tp.Employee_SSN) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( tp.Employee_SSN) NOT LIKE ''00000%'' AND LENGTH( TRIM( tp.Employee_SSN)) = 9 THEN HEX_ENCODE( TRIM( tp.Employee_SSN))
            WHEN TRIM( stf.ssn) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( stf.ssn) NOT LIKE ''00000%'' AND LENGTH( TRIM( stf.SSN)) = 9 THEN HEX_ENCODE( TRIM( stf.SSN))
            ELSE NULL
       END AS EMPLOYEE_PID
     , TRY_CAST(stf.STAFFAGENCYID AS INT) AS Employee_Number
     , CASE WHEN stf.DOB >= CAST( ''1901-01-01'' AS DATE) AND stf.DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN stf.DOB
            WHEN tp.Employee_DOB >= CAST( ''1901-01-01'' AS DATE) AND tp.Employee_DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN tp.Employee_DOB
            ELSE NULL
       END AS EMPLOYEE_DOB
     , CASE WHEN stf.DOD >= CAST( ''1960-01-01'' AS DATE) AND stf.DOD <= DATEADD( YEAR, +1, CURRENT_DATE) THEN stf.DOD
            ELSE NULL 
       END AS EMPLOYEE_Date_Of_Death
     , CASE WHEN stf.SOE >= CAST( ''1960-01-01'' AS DATE) AND stf.SOE <= DATEADD( YEAR, +1, CURRENT_DATE) AND stf.SOE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.SOE
            WHEN tp.Employee_Hire_Date >= CAST( ''1901-01-01'' AS DATE) AND tp.Employee_Hire_Date <= DATEADD( YEAR, -12, CURRENT_DATE) AND tp.Employee_Hire_Date >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN tp.Employee_Hire_Date
            ELSE NULL
       END AS EMPLOYEE_HIRE_DATE
     , CASE WHEN stf.RehireDate >= CAST( ''1960-01-01'' AS DATE) AND stf.RehireDate <= DATEADD( YEAR, +1, CURRENT_DATE) AND stf.RehireDate >= DATEADD( YEAR, 12, NVL( Employee_Hire_Date, CAST(''1948-01-01'' AS DATE))) THEN stf.RehireDate
            WHEN tp.Employee_Rehire_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Rehire_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Rehire_Date >= DATEADD( YEAR, 12, NVL( Employee_Hire_Date, CAST(''1948-01-01'' AS DATE))) THEN tp.Employee_Rehire_Date
            ELSE NULL
       END AS EMPLOYEE_REHIRE_DATE
     , NULL AS Employee_Benefit_Start_Date
     , NULL AS Employee_First_Check_Date
     , NULL AS Employee_Last_Check_Date
     , CASE WHEN stf.EOE >= CAST( ''1960-01-01'' AS DATE) AND stf.EOE > Employee_Hire_Date AND stf.EOE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.EOE
            WHEN tp.Employee_Last_Worked_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Last_Worked_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Last_Worked_Date > Employee_Hire_Date THEN tp.Employee_Last_Worked_Date
            ELSE NULL
       END AS Employee_Last_Worked_DATE
     , CASE WHEN stf.EOE < CAST( ''1960-01-01'' AS DATE) OR stf.EOE < stf.SOE OR stf.EOE < DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN stf.EOE
            WHEN tp.Employee_Terminate_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Terminate_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Terminate_Date > Employee_Hire_Date THEN tp.Employee_Terminate_Date
            ELSE NULL
       END AS EMPLOYEE_TERMINATE_DATE
     , tp.Reason_To_Terminate AS Reason_To_Terminate
     , IFF( stf.EOE IS NULL AND Status IN (''02''), ''TRUE'', ''FALSE'') AS Active_Employee_Flag
     , NULL AS Able_to_Rehire_Flag
     , CASE WHEN stf.Title <> ''-1'' AND stf.Title IS NOT NULL THEN UPPER( stf.Title)
            ELSE NULL
       END AS Employee_Prefix    
     , CASE WHEN UPPER( TRIM( stf.FirstName)) <> '''' AND UPPER( TRIM( stf.FirstName)) IS NOT NULL THEN UPPER( TRIM( stf.FirstName))
            WHEN UPPER( TRIM( tp.Employee_First_Name)) <> '''' THEN UPPER( TRIM( tp.Employee_First_Name))
            ELSE NULL
       END AS Employee_First_Name
     , CASE WHEN UPPER( TRIM( stf.MIDDLEInitial)) <> '''' AND UPPER( TRIM( stf.MIDDLEInitial)) IS NOT NULL THEN TRIM( UPPER( regexp_replace( stf.MiddleInitial,''\\\\d|\\\\.|\\\\+|\\\\,|\\\\-'','''')))
            WHEN UPPER( TRIM( tp.Employee_MIDDLE_NAME)) <> '''' THEN TRIM( UPPER( regexp_replace( tp.Employee_Middle_Name,''\\\\d|\\\\.|\\\\+|\\\\,|\\\\-'','''')))
            ELSE NULL
       END AS Employee_Middle_Name
     , CASE WHEN UPPER( TRIM( stf.LastName)) <> '''' AND UPPER( TRIM( stf.LastName)) IS NOT NULL THEN UPPER( TRIM( stf.LastName))
            WHEN UPPER( TRIM( tp.Employee_Last_Name)) <> '''' THEN UPPER( TRIM( tp.Employee_Last_Name))
            ELSE NULL
       END AS Employee_Last_Name
     , CASE WHEN UPPER( TRIM( stf.Suffix)) <> '''' AND UPPER( TRIM( stf.Suffix)) IS NOT NULL THEN UPPER( TRIM( stf.Suffix))
            WHEN UPPER( TRIM( tp.Employee_Suffix)) <> '''' THEN UPPER( TRIM( tp.Employee_Suffix))
            ELSE NULL
       END AS Employee_Suffix
     , CASE WHEN UPPER( TRIM( stf.Address)) <> '''' AND UPPER( TRIM( stf.Address)) IS NOT NULL THEN UPPER( TRIM( stf.Address))
            WHEN UPPER( TRIM( tp.Employee_Address1)) <> '''' THEN UPPER( TRIM( tp.Employee_Address1))
            ELSE NULL
       END AS Employee_Address1
     , CASE WHEN UPPER( TRIM( stf.Address2)) <>  '''' OR UPPER( TRIM( stf.AptNo)) <> ''''  THEN IFF( UPPER( TRIM( stf.Address2)) IS NOT NULL, UPPER( TRIM( stf.Address2)), '''') || IFF( UPPER( TRIM( stf.AptNo)) IS NOT NULL, '' ''||UPPER( TRIM( stf.AptNo)), '''')
            WHEN UPPER( TRIM( tp.Employee_Address2)) <>  '''' THEN UPPER( TRIM( tp.Employee_Address2))
            ELSE NULL
       END AS Employee_Address2
     , CASE WHEN UPPER( TRIM( stf.City)) <>  '''' AND UPPER( TRIM( stf.City)) IS NOT NULL THEN UPPER( TRIM( stf.City)) 
            WHEN UPPER( TRIM( tp.Employee_City)) <>  '''' THEN UPPER( TRIM( tp.Employee_City))
            ELSE NULL
       END AS Employee_City
     , st.State_ISO_Code AS EMPLOYEE_STATE_CODE
     , zip.Zip_Code AS Employee_Zip
     , CASE WHEN TRIM( REGEXP_REPLACE( stf.HomePhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND stf.HomePhone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( stf.HomePhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( stf.HomePhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) 
            WHEN TRIM( REGEXP_REPLACE( tp.Employee_Home_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND tp.Employee_Home_Phone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( tp.Employee_Home_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( tp.Employee_Home_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) 
            ELSE NULL
       END AS Employee_Home_Phone
     , CASE WHEN TRIM( REGEXP_REPLACE( stf.MobilePhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND stf.MobilePhone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( stf.MobilePhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( stf.MobilePhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) 
            WHEN TRIM( REGEXP_REPLACE( tp.Employee_Cell_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND tp.Employee_Cell_Phone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( tp.Employee_Cell_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( tp.Employee_Cell_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) 
            ELSE NULL
       END AS Employee_Cell_Phone
     , CASE WHEN TRIM( REGEXP_REPLACE( stf.WorkPhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND stf.WorkPhone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( stf.WorkPhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( stf.WorkPhone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) 
            WHEN TRIM( REGEXP_REPLACE( tp.Employee_Work_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND tp.Employee_Work_Phone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( tp.Employee_Work_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( tp.Employee_Work_Phone,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'''''','''')) 
            ELSE NULL
       END AS Employee_Work_Phone
     , UPPER( TRIM( stf.Email)) AS Employee_Personal_Email
     , NULL AS Employee_Work_Email
     , NULL AS Linked_In_Profile_URL
     , CASE WHEN TRIM( stf.Sex) = ''1'' THEN ''MALE''
            WHEN TRIM( stf.Sex) = ''2'' THEN ''FEMALE''
            WHEN UPPER( TRIM( tp.Employee_Gender)) = ''M'' THEN ''MALE''
            WHEN UPPER( TRIM( tp.Employee_Gender)) = ''F'' THEN ''FEMALE''
            ELSE NULL
       END AS Employee_Gender
     ,CASE WHEN UPPER(stf.Ethnicity) = ''NONE''  THEN NULL
            WHEN stf.Ethnicity = ''Native Hawaiian or Other Pacific Islander (NHL)'' THEN UPPER(''Native Hawaiian or Other Pacific Islander'')
            WHEN stf.Ethnicity = ''American Indian or Alaskan Native (NHL)'' THEN UPPER(''American Indian or Alaska Native'')
            WHEN stf.Ethnicity = ''Two or More Races (NHL)'' THEN UPPER(''Two or more'')
    WHEN trim(stf.Ethnicity) = '''' THEN CASE         
            WHEN UPPER( TRIM( tp.Employee_Ethnicity)) = ''UNIDENTIFIED/OPT OUT'' OR TRIM( tp.Employee_Ethnicity) = '''' OR tp.Employee_Ethnicity IS NULL THEN NULL
            WHEN TRIM( tp.Employee_Ethnicity) ILIKE  ''Native Hawaiian or Other Pacific Islander%'' THEN UPPER(''Native Hawaiian or Other Pacific Islander'')
            WHEN TRIM( tp.Employee_Ethnicity) ILIKE  ''Two or More Races%'' THEN UPPER(''Two or more'')
            WHEN  tp.Employee_Ethnicity ILIKE ANY (''not%'',''hispanic%'') THEN NULL
              WHEN tp.Employee_Ethnicity ILIKE  ''('' OR  TRIM( tp.Employee_Ethnicity) IS NOT NULL THEN UPPER(TRIM( REPLACE( tp.Employee_Ethnicity, ''(not Hispanic or Latino)'', ''''))) 
              ELSE NULL END 
            WHEN   stf.Ethnicity ILIKE ANY (''not%'',''hispanic%'') THEN NULL 
          WHEN stf.Ethnicity IS NOT NULL THEN UPPER(TRIM( REPLACE( REPLACE( stf.Ethnicity, ''(NHL)'', ''''), ''(not Hispanic or Latino; NHL)'', '''')))
          ELSE NULL
       END AS Employee_Ethnicity,
       CASE WHEN  stf.Ethnicity  ILIKE ANY (''%not%HISPANIC%OR%LATINO%'') THEN FALSE 
  WHEN stf.Ethnicity ILIKE ANY  (''%HISPANIC%OR%LATINO%'') THEN TRUE 
  WHEN trim(stf.Ethnicity) = '''' AND tp.Employee_Ethnicity ILIKE ANY (''%not%HISPANIC%OR%LATINO%'') THEN FALSE 
  WHEN  trim(stf.Ethnicity) = '''' AND tp.Employee_Ethnicity ILIKE ANY  (''%HISPANIC%OR%LATINO%'') THEN TRUE
  ELSE FALSE END AS HISPANIC_OR_LATINO, 
     stf.LANGUAGE AS EMPLOYEE_LANGUAGE
     ,TRIM( stf.Marital) AS Employee_Marital_Status
     , TRIM( stf.Class) AS Employee_Type
     , CASE WHEN stf.FieldStaff = ''TRUE'' THEN ''FIELD''
            WHEN STF.FIELDSTAFF = ''FALSE'' THEN ''ADMIN''
            WHEN UPPER(TP.FIELD_WORKER_FLAG) = ''TRUE'' THEN ''FIELD''
            WHEN UPPER(TP.FIELD_WORKER_FLAG) = ''FALSE'' THEN ''ADMIN''
            ELSE ''FIELD''
       END AS Employee_Category
     , NULL AS Exempt_Flag
     , CASE WHEN stf.Position IS NOT NULL THEN TRIM( stf.Position) 
            WHEN tp.Job_Title IS NOT NULL THEN TRIM( tp.Job_Title)
            ELSE NULL
       END AS Job_Title
     , NULL AS Job_Description
     , NULL AS Class_ID
     , NULL AS Workers_Comp
     , TRY_CAST(stf.STAFFAGENCYID AS INT)  AS Payroll_ID
     , NULL AS Percent_401k_Deduction
     , NULL AS Amount_401k_Deduction
     , NULL AS JazzHR_Applicant_ID
     , NULL AS JazzHR_User_ID
     , NULL AS JazzHR_Contact_ID
     , CASE WHEN stf.AgencyID = ''5841'' THEN ''TN''
            WHEN stf.AgencyID = ''8380'' THEN ''IL''
            WHEN stf.AgencyID = ''8463'' THEN ''MO''
            WHEN stf.AgencyID = ''8485'' THEN ''PA''
            WHEN stf.AgencyID = ''38004'' THEN ''IN''
            WHEN stf.AgencyID = ''38005'' THEN ''MI''
       END AS Work_State
     , st.State_ISO_Code AS SUTA_State
     , NULL AS Employee_Department
     -- , offbrnch.Employee_Office_Number
     -- , offbrnch.Primary_Branch_Key
     -- , offbrnch.Primary_Branch_State
     -- , offbrnch.Primary_Branch_Name
     -- , offbrnch.Primary_Branch_System_Code
     , COALESCE(BRANCH.OFFICE_NUMBER::STRING, '''') AS EMPLOYEE_OFFICE_CODE
     , COALESCE(BRANCH.BRANCH_KEY, MD5(stf.AGENCYID || ''-'' || NVL(stf.HOMELOCATION,'''') || ''-'' || ''SANDATAIMPORT'')) AS PRIMARY_BRANCH_KEY
     , COALESCE(BRANCH.OFFICE_STATE_CODE, ''PA'') AS PRIMARY_BRANCH_STATE
     , COALESCE(BRANCH.DETAILED_OFFICE_NAME, ''PA - UNKNOWN'') AS PRIMARY_BRANCH_NAME
     , COALESCE(BRANCH.SYSTEM_CODE, ''8485'') AS PRIMARY_BRANCH_SYSTEM_CODE
	 ,NULL AS CASE_MANAGER_FLAG
	 ,NULL AS SUPERVISOR_FLAG
	 ,NULL AS COORDINATOR_FLAG
     , IFF( Employee_ReHire_Date IS NULL, IFF( Employee_Hire_Date IS NULL,  CAST( ''1900-01-01'' AS DATE), Employee_Hire_Date), Employee_ReHire_Date) AS Effective_From_Date
     , IFF( Employee_Terminate_Date IS NULL, CAST( ''2030-12-31'' AS DATE), Employee_Terminate_Date) AS Effective_To_Date
	 ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.SANDATAIMPORT.EMPLOYEE_MASTER_LIST AS stf
-- INNER JOIN offbrnch ON offbrnch.HomeLocation = stf.HomeLocation
LEFT OUTER JOIN HAH.DIM_BRANCH AS BRANCH ON BRANCH.SYSTEM_CODE = stf.AGENCYID AND BRANCH.OFFICE_CODE = stf.HOMELOCATION
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.TrustPointData.Employees AS tp ON tp.COMPANY = ''EXCEL'' AND stf.AGENCYID = ''8485'' AND TRY_CAST(tp.EMPLOYEE_NUMBER AS INT) = TRY_CAST(stf.STAFFAGENCYID AS INTEGER) --stf.ID = tp.ID
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = IFF( TRIM( UPPER( stf.State))='''', UPPER( tp.Employee_State_Code), TRIM( UPPER( stf.State)))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = IFF( TRIM( UPPER( stf.Zip))='''', UPPER( tp.Employee_Zip), TRIM( UPPER( stf.Zip)))
--LEFT OUTER JOIN employee_service_dates AS csd ON csd.AgencyID = stf.AgencyID AND csd.Employee_Number = stf.StaffID
WHERE stf.AgencyID = ''8485''
AND stf.Person = ''TRUE'';
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}


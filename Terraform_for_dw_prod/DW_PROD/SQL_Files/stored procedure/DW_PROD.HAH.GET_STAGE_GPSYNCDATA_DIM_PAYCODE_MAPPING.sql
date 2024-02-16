CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_GPSYNCDATA_DIM_PAYCODE_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    
--*****************************************************************************************************************************
-- NAME:  GPSyncData_DIM_PAYCODE_MAPPING
--
-- PURPOSE: Creates one row for each database (DB), paycode and assigns a paycode category according to Great Plains
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 03/22/21    Frank Noordover       Initial development
-- 12/??/21    Alex Marianyi         Categorization updates
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.GPSYNCDATA_DIM_PAYCODE_MAPPING
WITH Find_Latest_Changes AS
(
SELECT LEAST( MAX( dtl.ETL_Last_Updated_Date), MAX( m.ETL_Last_Updated_Date), MAX( eep.ETL_Last_Updated_Date)) AS Date_to_Start_Processing
FROM DISC_PROD.GPSyncData.PayStub_Detailline AS dtl
INNER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_Master AS m ON TRIM( dtl.CheckID) = TRIM( m.CheckID)
LEFT OUTER JOIN DISC_PROD.GPSyncData.Employer_Edge_Paycodes AS eep ON m.DB = eep.Company_Code AND dtl.PayCode = eep.Pay_Code
),
paycode_descriptions AS (
SELECT 5 AS Source_System_ID, TRIM( m.DB) AS System_Code, m.WorkState AS State_Code, 
       TRIM( dtl.Paycode) AS Pay_Code, TRIM( dtl.CodeTypes) AS Code_Types,
       -- capture both descriptions for a paycode within a system for a work state when it has two descriptions, this logic will only capture two if there are more than two
       CASE WHEN MIN( TRIM( UPPER( dtl.Descriptions))) <> MAX( TRIM( UPPER( dtl.Descriptions))) THEN MIN( TRIM( UPPER( dtl.Descriptions))) ||'', '' || MAX( TRIM( UPPER( dtl.Descriptions)))
            WHEN MIN( TRIM( UPPER( dtl.Descriptions))) = MAX( TRIM( UPPER( dtl.Descriptions))) THEN MIN( TRIM( UPPER( dtl.Descriptions)))
       END AS Descriptn
FROM DISC_PROD.GPSyncData.PayStub_Detailline AS dtl
INNER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_Master AS m ON TRIM( dtl.CheckID) = TRIM( m.CheckID)
GROUP BY m.DB, m.WorkState, dtl.PayCode, dtl.CodeTypes
),
paycode_usage_dates AS (
SELECT 5 AS Source_System_ID, m.DB AS System_Code, m.WorkState AS State_Code, 
       dtl.Paycode AS Pay_Code, dtl.CodeTypes AS Code_Types,
       MIN( m.PayDate) AS First_Used_Date,
       MAX( m.PayDate) AS Most_Recent_Used_Date,
       CAST( COUNT( DISTINCT m.EmployeeID) AS INTEGER) AS Number_Employees_Used
FROM DISC_PROD.GPSyncData.PayStub_Detailline AS dtl
INNER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_Master AS m ON TRIM( dtl.CheckID) = TRIM( m.CheckID)
GROUP BY m.DB, m.WorkState, dtl.PayCode, dtl.CodeTypes
),
paycode_field_usage AS (
SELECT DISTINCT 5 AS Source_System_ID, m.DB AS System_Code, m.WorkState AS State_Code, 
       dtl.Paycode AS Pay_Code, dtl.CodeTypes AS Code_Types,
       CAST( CASE WHEN NVL( m.EmployeeType, ''F'') = ''F'' THEN ''TRUE''
                  ELSE ''FALSE''
             END AS BOOLEAN) AS Field_PayRate_Flag
FROM DISC_PROD.GPSyncData.PayStub_Detailline AS dtl
INNER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_Master AS m ON TRIM( dtl.CheckID) = TRIM( m.CheckID)
WHERE NVL( m.EmployeeType, ''F'') = ''F''
),
paycode_admin_usage AS (
SELECT DISTINCT 5 AS Source_System_ID, m.DB AS System_Code, m.WorkState AS State_Code, 
       dtl.Paycode AS Pay_Code, dtl.CodeTypes AS Code_Types,
       CAST( CASE WHEN NVL( m.EmployeeType, ''F'') = ''A'' THEN ''TRUE''
                  ELSE ''FALSE''
             END AS BOOLEAN) AS Admin_PayRate_Flag
FROM DISC_PROD.GPSyncData.PayStub_Detailline AS dtl
INNER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_Master AS m ON TRIM( dtl.CheckID) = TRIM( m.CheckID)
WHERE NVL( m.EmployeeType, ''F'') = ''A''
),
SALARY_HOURS_USAGE AS (
SELECT DISTINCT 5 AS Source_System_ID,
	UPPER( TRIM( pc.$2)) AS DB, UPPER( TRIM( pc.$3)) AS PAY_CODE, UPPER( TRIM( pc.$6)) AS PAY_TYPE,
	(CASE WHEN PAY_TYPE IN (''HOURLY'') THEN ''TRUE'' ELSE ''FALSE'' END)::BOOLEAN AS SALARY_PAY_CODE,
	(CASE WHEN PAY_TYPE IN (''HOURLY'',''DOUBLETIME'',''HOLIDAY'',''OVERTIME'',''PIECEWORK'',''SICK'',''VACATION'') THEN ''TRUE'' ELSE ''FALSE'' END)::BOOLEAN
		AS HOURS_PAYCODE
FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Files/MERCER/Mercer_OE22_HAHpaycodes_20211006 (file_format => DISC_PROD.STAGE.CSV_FORMAT) pc --RSUTHAR - Change Stage/File Format
WHERE UPPER( TRIM( pc.$5)) = ''NO''
	AND PAY_TYPE IN (''HOURLY'',''DOUBLETIME'',''HOLIDAY'',''OVERTIME'',''PIECEWORK'',''SICK'',''VACATION'')
--	AND PAY_CODE IN (''DW1220'',''DW0321'')
)
SELECT DISTINCT MD5( ''5'' || m.DB || m.WorkState || dtl.PayCode || dtl.CodeTypes) AS Paycode_Mapping_Key, 
       5 AS Source_System_ID, m.DB AS System_Code, m.WorkState AS State_Code, 
       dtl.Paycode AS Pay_Code, 
       pd.Descriptn, dtl.CodeTypes AS Pay_Code_Type, 
       CASE WHEN UPPER( Descriptn) LIKE ''%BONUS%'' OR UPPER( Descriptn) LIKE ''%INCENT%'' THEN ''Bonus''
            WHEN UPPER( Descriptn) LIKE ''%VAC%'' OR UPPER( Descriptn) LIKE ''%PTO%'' OR UPPER( Descriptn) LIKE ''%BEREAV%'' OR UPPER( dtl.PayCode) = ''BER'' OR UPPER( dtl.PayCode) LIKE ''%PTO%'' THEN ''PTO''
            WHEN UPPER( Descriptn) LIKE ''%HOLID%''  OR UPPER( Descriptn) LIKE ''%GEN%HOL%'' THEN ''Holiday''
            WHEN UPPER( Descriptn) LIKE ''%INSERV%'' OR UPPER( Descriptn) LIKE ''%TRAIN%'' OR UPPER( Descriptn) LIKE ''%TRNG%'' THEN ''Training''
            WHEN UPPER( Descriptn) LIKE ''%SICK%'' THEN ''Sick''
            WHEN UPPER( Descriptn) LIKE ''%ON%CALL%'' OR UPPER( Descriptn) LIKE ''%OCP%'' THEN ''On-Call''
            WHEN UPPER( Descriptn) LIKE ''%ASSES%'' THEN ''Assessment''
            WHEN UPPER( Descriptn) LIKE ''%SUPERV%'' THEN ''Supervisor''
            WHEN UPPER( Descriptn) LIKE ''%NO%BILL%'' OR UPPER( Descriptn) LIKE ''%NO%CHARGE%'' OR UPPER( Descriptn) LIKE ''%NO%SHOW%'' THEN ''No Bill & No Show & No Charge''
            WHEN UPPER( Descriptn) LIKE ''%UNION%'' OR UPPER( Descriptn) LIKE ''%DUE%'' OR CAST( dtl.IsUnionDue AS BOOLEAN) THEN ''Union''
            WHEN UPPER( Descriptn) LIKE ''%DAILY%'' OR UPPER( Descriptn) LIKE ''%DAY%'' OR UPPER( dtl.Paycode) IN (''MRS2'', ''MRS4'') OR UPPER( dtl.Paycode) LIKE ''RD%''THEN ''Daily''
            WHEN UPPER( Descriptn) LIKE ''%OVER%TIME%'' OR UPPER( Descriptn) LIKE ''%OTM%'' THEN ''Overtime''
            WHEN UPPER( Descriptn) LIKE ''%TRAVEL%TIME%'' OR UPPER( Descriptn) LIKE ''%TTI%'' OR UPPER( Descriptn) LIKE ''%TVL%'' OR UPPER( Descriptn) LIKE ''%MILE%'' THEN ''Travel Time & Mileage''
            WHEN UPPER( Descriptn) LIKE ''%HEALTH%INS%'' OR UPPER( Descriptn) LIKE ''%DENTAL%'' OR UPPER( Descriptn) LIKE ''%VISION%'' OR UPPER( Descriptn) LIKE ''%DISABILITY%'' OR UPPER( Descriptn) LIKE ''%AD&D%'' OR UPPER( Descriptn) LIKE ''%LIFE%INS%'' OR UPPER( Descriptn) LIKE ''%VOL%LIFE%'' OR UPPER( Descriptn) LIKE ''%MEDIC%INS%'' OR UPPER( Descriptn) LIKE ''%FSA%'' OR UPPER( Descriptn) LIKE ''%HSA%'' OR UPPER( Descriptn) LIKE ''%UNITED%HEALTH%'' OR UPPER( Descriptn) LIKE ''%FLEX%SPEND%'' OR UPPER( Descriptn) LIKE ''%MIN%ESSENT%'' OR UPPER( Descriptn) LIKE ''%401%K%'' OR UPPER( Descriptn) LIKE ''%LIMIT%MEDIC%'' OR UPPER( Descriptn) LIKE ''%VOL%ACCID%'' OR UPPER( Descriptn) = ''STD'' OR UPPER( Descriptn) = ''LTD'' OR UPPER( Descriptn) = ''MEDICAL'' OR UPPER( Descriptn) LIKE ''%MEDICAL%PRE%TAX%'' OR UPPER( Descriptn) LIKE ''%CRITIC%I%'' OR UPPER( Descriptn) LIKE ''%DEDUCT%'' OR UPPER( Descriptn) LIKE ''%GARNISH%'' OR UPPER( Descriptn) LIKE ''%ACCIDENT%'' OR UPPER( Descriptn) LIKE ''%LOAN%'' OR UPPER( Descriptn) LIKE ''%SCRUBS%'' OR UPPER( Descriptn) LIKE ''%ID%REPLACE%'' OR UPPER( Descriptn) LIKE ''%REPLACE%KEY%''  OR UPPER( Descriptn) LIKE ''%KEY%REPLACE%'' OR UPPER( Descriptn) LIKE ''%HOSP%INDEM%'' OR UPPER( Descriptn) LIKE ''%DED%ADV%'' OR UPPER( Descriptn) LIKE ''%BACKGROUND%'' THEN ''Benefits & Deductions''
            WHEN UPPER( Descriptn) LIKE ''%ADJ%'' OR UPPER( Descriptn) LIKE ''%SETTLE%'' OR UPPER( Descriptn) LIKE ''%REFUND%'' OR UPPER( Descriptn) LIKE ''%RETRO%'' OR UPPER( Descriptn) LIKE ''%PREMIUM%'' OR UPPER( Descriptn) LIKE ''%COVID%'' OR UPPER( Descriptn) LIKE ''%SEVER%'' OR UPPER( Descriptn) LIKE ''%ADVANCE%'' OR UPPER( Descriptn) LIKE ''%RECOVER%'' OR UPPER( Descriptn) LIKE ''%ASSIGN%'' OR UPPER( Descriptn) LIKE ''%EARN%INCOME%'' OR UPPER( Descriptn) LIKE ''%GEN%EIC%'' OR UPPER( Descriptn) LIKE ''%DEFER%COMP%'' /* OR CAST( dtl.IsHistory AS BOOLEAN) */ THEN ''Adjustment''
            WHEN /* CAST( dtl.IsWage AS BOOLEAN) OR */ CAST( NVL( eep.Count_Hours, ''FALSE'') AS BOOLEAN) OR UPPER( Descriptn) LIKE ''%MCO%'' OR UPPER( Descriptn) LIKE ''%DORS%'' OR UPPER( Descriptn) LIKE ''%IDOA%'' OR UPPER( Descriptn) LIKE ''%DCFS%'' OR UPPER( Descriptn) LIKE ''% SK %'' OR UPPER( Descriptn) LIKE ''% RN %'' OR UPPER( Descriptn) LIKE ''%RESPITE%'' OR UPPER( Descriptn) LIKE ''%HOME%'' OR UPPER( Descriptn) LIKE ''%TRANS%'' OR UPPER( Descriptn) LIKE ''%SERVICE%'' OR UPPER( Descriptn) LIKE ''%DD%SVC%'' OR UPPER( Descriptn) LIKE ''%DD%HOUSE%'' THEN ''Regular Pay''
            WHEN UPPER( Descriptn) LIKE ''%REIMB%'' OR UPPER( Descriptn) LIKE ''%BUS%TRAVEL%'' OR UPPER( Descriptn) LIKE ''%BUS%REIMB%'' OR UPPER( Descriptn) LIKE ''%BUS%EXP%'' /*OR CAST( dtl.IsReimbursement AS BOOLEAN)*/ THEN ''Reimbursement''
            WHEN UPPER( Descriptn) LIKE ''%TAX%'' OR UPPER( Descriptn) LIKE ''%FICA%''  OR UPPER( Descriptn) LIKE ''%WITHHOLD%'' OR CAST( dtl.IsTax AS BOOLEAN) THEN ''Tax''
       END AS Pay_Code_Category,
       CAST( NULL AS VARCHAR) AS Finance_Category,
       CASE WHEN CAST( NVL( eep.IsHomeCare, ''FALSE'') AS BOOLEAN) THEN ''HC'' 
            WHEN CAST( NVL( eep.IsSkilled, ''FALSE'') AS BOOLEAN) THEN ''HH''
            WHEN CAST( NVL( eep.IsDD, ''FALSE'') AS BOOLEAN) THEN ''CLS''
       END AS Revenue_Category,
       CAST( NULL AS VARCHAR) AS Revenue_Subcategory_Code,
       CAST( NULL AS VARCHAR) AS Revenue_Subcategory_Name,
       pud.First_Used_Date,
       pud.Most_Recent_Used_Date,
       pud.Number_Employees_Used,
       CAST( CASE WHEN DATEADD( ''YEAR'', 1, pud.Most_Recent_Used_Date) >= CURRENT_DATE THEN ''TRUE''
                  ELSE ''FALSE''
             END AS BOOLEAN) AS Active_Flag,
       CAST( NVL( pau.Admin_PayRate_Flag, ''FALSE'') AS BOOLEAN) AS Admin_PayRate_Flag,
       CAST( NVL( pfu.Field_PayRate_Flag, ''FALSE'') AS BOOLEAN) AS Field_PayRate_Flag,
       (NVL( shu.SALARY_PAY_CODE, ''FALSE''))::BOOLEAN AS INCLUDE_SALARY_PAYRATE_CALC_FLAG,
       (NVL( shu.HOURS_PAYCODE, ''FALSE''))::BOOLEAN AS INCLUDE_FULL_TIME_HOURS_CALC_FLAG,
	   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	   convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	   CURRENT_USER as ETL_INSERTED_BY ,
	   convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	   CURRENT_USER as ETL_LAST_UPDATED_BY,
	   0 as ETL_DELETED_FLAG
FROM DISC_PROD.GPSyncData.PayStub_Detailline AS dtl
INNER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_Master AS m ON TRIM( dtl.CheckID) = TRIM( m.CheckID)
LEFT OUTER JOIN DISC_PROD.GPSyncData.Employer_Edge_Paycodes AS eep ON m.DB = eep.Company_Code AND dtl.PayCode = eep.Pay_Code
LEFT OUTER JOIN paycode_descriptions AS pd ON pd.Source_System_ID = 5 AND pd.System_Code = m.DB AND pd.State_Code = m.WorkState AND pd.Pay_Code = dtl.Paycode AND pd.Code_Types = dtl.CodeTypes
LEFT OUTER JOIN paycode_usage_dates AS pud ON pud.Source_System_ID = 5 AND pud.System_Code = m.DB AND pud.State_Code = m.WorkState AND pud.Pay_Code = dtl.Paycode AND pud.Code_Types = dtl.CodeTypes
LEFT OUTER JOIN paycode_field_usage AS pfu ON pfu.Source_System_ID = 5 AND pfu.System_Code = m.DB AND pfu.State_Code = m.WorkState AND pfu.Pay_Code = dtl.Paycode AND pfu.Code_Types = dtl.CodeTypes
LEFT OUTER JOIN paycode_admin_usage AS pau ON pau.Source_System_ID = 5 AND pau.System_Code = m.DB AND pau.State_Code = m.WorkState AND pau.Pay_Code = dtl.Paycode AND pau.Code_Types = dtl.CodeTypes
LEFT OUTER JOIN SALARY_HOURS_USAGE AS shu ON shu.Source_System_ID = 5 AND shu.DB = m.DB AND shu.PAY_CODE = dtl.PAYCODE
WHERE dtl.ETL_LAST_UPDATED_DATE >= ( SELECT Date_to_Start_Processing FROM Find_Latest_Changes);

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';
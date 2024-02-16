create or replace view DW_PROD.REPORT.VW_RISKONNECT_EXTRACT(
	ACCOUNT,
	ACTIVE_INACTIVE,
	ADDRESS_1,
	ADDRESS_2,
	BIRTHDATE,
	CITY,
	DATA_WAREHOUSE_ID,
	EMAIL,
	ETHNIC_ORIGIN,
	FIRST_NAME,
	GENDER,
	HOME_PHONE,
	LAST_NAME,
	MIDDLE_INITIAL,
	OTHER_PHONE,
	SSN,
	STATE,
	TERMINATION_DATE,
	ZIP_CODE,
	HAH_SYSTEM_NUMBER,
	HAH_INTERNAL_NUMBER,
	INITIAL_HIRE_DATE,
	ADJUSTED_HIRE_DATE,
	DEPARTMENT,
	POSITION,
	MARITAL_STATUS,
	PERSONAL_EMAIL,
	SERVICE_START_DATE__C,
	SERVICE_END_DATE__C,
	DATE_OF_DEATH,
	RECORD_TYPE,
	LOCATION
) as
SELECT DISTINCT
	ACCOUNT, ACTIVE_INACTIVE, ADDRESS_1, ADDRESS_2, BIRTHDATE, CITY, DATA_WAREHOUSE_ID, EMAIL, ETHNIC_ORIGIN, FIRST_NAME, GENDER,
	COALESCE( HOME_PHONE, OTHER_PHONE, '9999999999') AS HOME_PHONE,
	LAST_NAME, MIDDLE_INITIAL, OTHER_PHONE, SSN, STATE, TERMINATION_DATE, ZIP_CODE, HAH_SYSTEM_NUMBER, HAH_INTERNAL_NUMBER,
	Initial_Hire_Date, ADJUSTED_HIRE_DATE, DEPARTMENT, POSITION, MARITAL_STATUS, PERSONAL_EMAIL,
	SERVICE_START_DATE__C, SERVICE_END_DATE__C, DATE_OF_DEATH, RECORD_TYPE, LOCATION--, EMPLOYEE_KEY
FROM (
SELECT DISTINCT
	'001j000000Cfz2T' AS ACCOUNT,
    ACTIVE_INACTIVE,
    ADDRESS_1,
    ADDRESS_2,
    CASE WHEN BIRTHDATE::DATE <= '1900-01-01' THEN NULL
    	 WHEN BIRTHDATE::DATE >= CURRENT_DATE() THEN NULL
    	 WHEN DATEDIFF( YEAR, BIRTHDATE::DATE, Initial_Hire_Date::DATE) < 14 THEN NULL
	     ELSE TO_VARCHAR( BIRTHDATE::DATE, 'MM/DD/YYYY') END
		AS BIRTHDATE,
    CITY,
    DATA_WAREHOUSE_ID,
    EMAIL,
    ETHNIC_ORIGIN,
    NULLIF( TRIM( REGEXP_REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( 
    	FIRST_NAME,'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','')
    		,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)|\\]|\\[','')),'') AS FIRST_NAME,
    GENDER,
    CASE WHEN TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( HOME_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))) IS NULL THEN NULL
    	 WHEN TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( HOME_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)','')))
		 	IN ('0','0000000000','1111111111','2222222222','3333333333','4444444444','5555555555','6666666666','7777777777','8888888888','9999999999') THEN NULL
		 WHEN LEN( TRIM( TRY_TO_NUMBER( REGEXP_REPLACE( HOME_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)','')))) <> 10 THEN NULL
		 WHEN LEFT( TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( HOME_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))),3) = '000' THEN NULL
		 WHEN RIGHT( TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( HOME_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))),7) = '0000000' THEN NULL
		 ELSE TO_VARCHAR( TRY_TO_NUMBER( REGEXP_REPLACE( HOME_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))) END
   		AS HOME_PHONE,
    NULLIF( TRIM( REGEXP_REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE(
    	LAST_NAME,'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','')
    		,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)|\\]|\\[','')
            ,'\\-',' ')),' ') AS LAST_NAME,
    TRIM( REGEXP_REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( 
    	MIDDLE_INITIAL,'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','')
    		,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)|\\]|\\[','')) AS MIDDLE_INITIAL,
     CASE WHEN TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( OTHER_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))) IS NULL THEN NULL
    	  WHEN TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( OTHER_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)','')))
    	 	IN ('0','0000000000','1111111111','2222222222','3333333333','4444444444','5555555555','6666666666','7777777777','8888888888','9999999999') THEN NULL
    	  WHEN LEFT( TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( OTHER_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))),3) = '000' THEN NULL
    	  WHEN RIGHT( TRY_TO_NUMBER( TRIM( REGEXP_REPLACE( OTHER_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))),7) = '0000000' THEN NULL
    	  WHEN LEN( TRIM( TRY_TO_NUMBER( REGEXP_REPLACE( OTHER_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)','')))) <> 10 THEN NULL
    	  ELSE COALESCE( TO_VARCHAR( TRY_TO_NUMBER( REGEXP_REPLACE( OTHER_PHONE,'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''))),'9999999999') END
    	AS OTHER_PHONE,
    LEFT( CASE WHEN LEN( TRIM( RISK.SSN)) <8 THEN NULL
		 	   WHEN LEN( TRIM( RISK.SSN)) >9 THEN NULL
		       WHEN TRY_TO_DECIMAL( TRIM( RISK.SSN)) IS NULL THEN NULL
		       WHEN TRIM( RISK.SSN) IN ('111111111','222222222','333333333','444444444','555555555','666666666','777777777','888888888','999999999',
		       							'121212121','123123123','011111111','101010101','111223333','111222333','100000000','111111112','12222222', 
										'454545454','010101011','01213454678','020202020','030303030','100000001','120000000') THEN NULL
		       WHEN DQSSN.SSN IS NOT NULL THEN NULL
		       ELSE RISK.SSN END, 3) || '-' ||
		RIGHT( LEFT( CASE WHEN LEN( TRIM( RISK.SSN)) <8 THEN NULL
						  WHEN LEN( TRIM( RISK.SSN)) >9 THEN NULL
						  WHEN TRY_TO_DECIMAL( TRIM( RISK.SSN)) IS NULL THEN NULL
						  WHEN TRIM( RISK.SSN) IN ('111111111','222222222','333333333','444444444','555555555','666666666','777777777','888888888','999999999',
		       										'121212121','123123123','011111111','101010101','111223333','111222333','100000000','111111112','12222222', 
													'454545454','010101011','01213454678','020202020','030303030','100000001','120000000') THEN NULL
						  WHEN DQSSN.SSN IS NOT NULL THEN NULL
						  ELSE RISK.SSN END, 5), 2) || '-' ||
		RIGHT( CASE WHEN LEN( TRIM( RISK.SSN)) <8 THEN NULL
		 	   WHEN LEN( TRIM( RISK.SSN)) >9 THEN NULL
		       WHEN TRY_TO_DECIMAL( TRIM( RISK.SSN)) IS NULL THEN NULL
		       WHEN TRIM( RISK.SSN) IN ('111111111','222222222','333333333','444444444','555555555','666666666','777777777','888888888','999999999',
		       							'121212121','123123123','011111111','101010101','111223333','111222333','100000000','111111112','12222222', 
										'454545454','010101011','01213454678','020202020','030303030','100000001','120000000') THEN NULL
		       WHEN DQSSN.SSN IS NOT NULL THEN NULL
		       ELSE RISK.SSN END, 4)
	AS SSN,
    STATE,
    TO_VARCHAR( TERMINATION_DATE::DATE, 'MM/DD/YYYY') AS TERMINATION_DATE,
    RIGHT( '00000'||TRIM( ZIP_CODE), 5) AS ZIP_CODE,
    HAH_SYSTEM_NUMBER,
    RISK.EMPLOYEE_NUMBER AS HAH_INTERNAL_NUMBER,
    TO_VARCHAR( Initial_Hire_Date::DATE, 'MM/DD/YYYY') AS Initial_Hire_Date,
    TO_VARCHAR( HIRE_DATE::DATE, 'MM/DD/YYYY') AS ADJUSTED_HIRE_DATE,
    DEPARTMENT,
    POSITION,
    MARITAL_STATUS,
    CONTACT_EMAIL AS PERSONAL_EMAIL,
    TO_VARCHAR( SERVICE_START_DATE__C::DATE, 'MM/DD/YYYY') AS SERVICE_START_DATE__C,
    TO_VARCHAR( SERVICE_END_DATE__C::DATE, 'MM/DD/YYYY') AS SERVICE_END_DATE__C,
    TO_VARCHAR( DATE_OF_DEATH::DATE, 'MM/DD/YYYY') AS DATE_OF_DEATH,
    RECORD_TYPE,
    CASE WHEN LOCATION = '1239' THEN '1039' ELSE LOCATION END AS LOCATION,
    EMPLOYEE_KEY
--    ,PAYROLL_ID::VARCHAR AS PAYROLL_ID
--    ,EMPLOYEE_ID::VARCHAR AS EMPLOYEE_ID
--    ,MEDICAID_NUMBER, CHART_ID
	--data quality checks (Abby asked that these be commented out now)
/*	,CASE WHEN IFNULL( TRIM( Address_1), '') = '' THEN 'Address 1 Blank'
		WHEN IFNULL( TRIM( City), '') = '' THEN 'City Blank'
		WHEN IFNULL( TRIM( State), '') = '' THEN 'State Blank'
		WHEN IFNULL( TRIM( Zip_Code), '') = '' THEN 'Zip Code Blank'
		WHEN TRY_TO_DECIMAL( TRIM( Address_1)) IS NOT NULL THEN 'Address 1 Error'
		WHEN TRY_TO_DECIMAL( TRIM( City)) IS NOT NULL THEN 'City Error'
		WHEN TRY_TO_DECIMAL( TRIM( State)) IS NOT NULL THEN 'State Error'
		WHEN TRY_TO_DECIMAL( REPLACE( TRIM( Zip_Code), '-','')) IS NULL THEN 'Zip Code Error'
		ELSE NULL END AS FLAG_Address
	,CASE WHEN UPPER( Address_1) ILIKE '%P%O%BOX%' THEN 'PO Box'
		ELSE NULL END AS FLAG_PObox
	,CASE WHEN IFNULL( TRIM( HOME_PHONE, ''), '') = '' THEN 'Phone Number Blank'
		WHEN TRY_TO_DECIMAL( REGEXP_REPLACE( TRIM( Zip_Code),'\\.|\\#|\\-|\\(|\\)','')) IS NULL THEN 'Phone Number Invalid'
		WHEN DQPN.PHONE_NUMBER IS NOT NULL THEN 'Phone Number Invalid'
		ELSE NULL END AS FLAG_HomePhoneNumber
	,CASE WHEN IFNULL( TRIM( BIRTHDATE), '') = '' THEN 'Birthdate Blank'
		WHEN TO_DATE( IFNULL( TRIM( BIRTHDATE) ,'11/11/1111'), 'MM/DD/YYYY') <= '1900-01-01' THEN 'Birthdate Unlikely'
		WHEN TO_DATE( IFNULL( TRIM( BIRTHDATE) ,'99/99/9999'), 'MM/DD/YYYY') > CURRENT_DATE() THEN 'Birthdate Unlikely'
		ELSE NULL END AS FLAG_DoB
	,CASE WHEN RECORD_TYPE = 'CLI' AND IFNULL( TRIM( SERVICE_START_DATE__C), '') = '' THEN 'Service Date Blank'
		WHEN RECORD_TYPE = 'CLI' AND TO_DATE( IFNULL( TRIM( SERVICE_START_DATE__C) ,'11/11/1111'), 'MM/DD/YYYY') <= '1900-01-01' THEN 'Service Date(s) Unlikely'
		WHEN RECORD_TYPE = 'CLI' AND TO_DATE( IFNULL( TRIM( SERVICE_END_DATE__C) ,'11/11/1111'), 'MM/DD/YYYY') <= '1900-01-01' THEN 'Service Date(s) Unlikely'
		WHEN RECORD_TYPE = 'CLI' AND TO_DATE( IFNULL( TRIM( SERVICE_START_DATE__C) ,'99/99/9999'), 'MM/DD/YYYY') > CURRENT_DATE() THEN 'Service Date(s) Unlikely'
		WHEN RECORD_TYPE = 'CLI' AND TO_DATE( IFNULL( TRIM( SERVICE_END_DATE__C) ,'99/99/9999'), 'MM/DD/YYYY') > CURRENT_DATE() THEN 'Service Date(s) Unlikely'
		ELSE NULL END AS FLAG_ServiceDates
	,CASE WHEN RECORD_TYPE = 'EMP' AND IFNULL( TRIM( Initial_Hire_Date), '') = '' THEN 'Hire Date Blank'
		WHEN RECORD_TYPE = 'EMP' AND IFNULL( TRIM( Hire_Date), '') = '' THEN 'Hire Date Blank'
		WHEN RECORD_TYPE = 'EMP' AND TO_DATE( IFNULL( TRIM( Initial_Hire_Date) ,'11111111'), 'YYYYMMDD') <= '1900-01-01' THEN 'Hire Date(s) Unlikely'
		WHEN RECORD_TYPE = 'EMP' AND TO_DATE( IFNULL( TRIM( Hire_Date) ,'11111111'), 'YYYYMMDD') <= '1900-01-01' THEN 'Hire Date(s) Unlikely'
		WHEN RECORD_TYPE = 'EMP' AND TO_DATE( IFNULL( TRIM( Initial_Hire_Date) ,'99999999'), 'YYYYMMDD') > CURRENT_DATE() THEN 'Hire Date(s) Unlikely'
		WHEN RECORD_TYPE = 'EMP' AND TO_DATE( IFNULL( TRIM( Hire_Date) ,'99999999'), 'YYYYMMDD') > CURRENT_DATE() THEN 'Hire Date(s) Unlikely'
		ELSE NULL END AS FLAG_HireDates
	,CASE WHEN IFNULL ( TRIM( RISK.SSN), '') = '' THEN 'SSN Blank'
		WHEN LEN( TRIM( RISK.SSN)) <8 THEN 'SSN Error'
		WHEN LEN( TRIM( RISK.SSN)) >9 THEN 'SSN Error'
		WHEN TRY_TO_DECIMAL( TRIM( RISK.SSN)) IS NULL THEN 'SSN Error'
		WHEN DQSSN.SSN IS NOT NULL THEN 'SSN Error'
		ELSE NULL END AS FLAG_SSN */
--	,MATCH_STATE
FROM (
-- client extract
(
WITH UNIQUE_CLIENT AS
(
--	SELECT CLIENT_SSN, COUNT(*) FROM (
	(SELECT DISTINCT
		REPLACE(NVL( CASE WHEN NULLIF( dfc.SSN,'') IS NOT NULL AND dfc.SSN <> '' THEN dfc.SSN
       					  WHEN cvp.SOCIAL_SECURITY_NUMBER IS NOT NULL AND cvp.SOCIAL_SECURITY_NUMBER <> '' THEN cvp.SOCIAL_SECURITY_NUMBER
                          ELSE NULL END, sc.SSN), '-', '')
	        AS CLIENT_SSN,
	FIRST_VALUE( cl.CLIENT_KEY IGNORE NULLS) OVER (PARTITION BY CLIENT_SSN ORDER BY cl.ACTIVE_CLIENT_FLAG DESC, cl.LAST_SERVICE_DATE DESC NULLS LAST, cl.REFERRAL_DATE DESC NULLS LAST) AS CLIENT_KEY
	 FROM DW_PROD.HAH.DIM_CLIENT cl
	 LEFT OUTER JOIN DISC_Prod.DataFlexSyncData.DFClients AS dfc ON cl.Source_System_ID = 3 AND cl.Client_State_Code = dfc.DBName AND cl.Client_Number = dfc.Number
	 LEFT OUTER JOIN DISC_Prod.SandataImport.Sandata_Clients AS sc ON cl.Source_System_ID = 4 AND sc.AgencyID = '8485' AND cl.Client_Number::VARCHAR = TRIM( sc.ClientID)::VARCHAR
	 LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.CV_PATIENTS AS cvp ON cl.SOURCE_SYSTEM_ID IN (1,2) AND TRIM( cl.SYSTEM_CODE) = TRIM( cvp.DB) AND cl.CLIENT_NUMBER::VARCHAR = TRIM( cvp.PATIENT_NUMBER)::VARCHAR
	 WHERE NULLIF( REPLACE(NVL( CASE WHEN NULLIF( dfc.SSN,'') IS NOT NULL AND dfc.SSN <> '' THEN dfc.SSN
       					     		 WHEN cvp.SOCIAL_SECURITY_NUMBER IS NOT NULL AND cvp.SOCIAL_SECURITY_NUMBER <> '' THEN cvp.SOCIAL_SECURITY_NUMBER
                            		 ELSE NULL END, sc.SSN), '-', '') ,'')
     		IS NOT NULL
	) UNION (
	 SELECT DISTINCT NULL AS CLIENT_SSN, cl.CLIENT_KEY
	 FROM DW_PROD.HAH.DIM_CLIENT cl
	 LEFT OUTER JOIN DISC_Prod.DataFlexSyncData.DFClients AS dfc ON cl.Source_System_ID = 3 AND cl.Client_State_Code = dfc.DBName AND cl.Client_Number = dfc.Number
	 LEFT OUTER JOIN DISC_Prod.SandataImport.Sandata_Clients AS sc ON cl.Source_System_ID = 4 AND sc.AgencyID = '8485' AND cl.Client_Number::VARCHAR = TRIM( sc.ClientID)::VARCHAR
	 LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.CV_PATIENTS AS cvp ON cl.SOURCE_SYSTEM_ID IN (1,2) AND TRIM( cl.SYSTEM_CODE) = TRIM( cvp.DB) AND cl.CLIENT_NUMBER::VARCHAR = TRIM( cvp.PATIENT_NUMBER)::VARCHAR
	 WHERE NULLIF( REPLACE(NVL( CASE WHEN NULLIF( dfc.SSN,'') IS NOT NULL AND dfc.SSN <> '' THEN dfc.SSN
       					     		 WHEN cvp.SOCIAL_SECURITY_NUMBER IS NOT NULL AND cvp.SOCIAL_SECURITY_NUMBER <> '' THEN cvp.SOCIAL_SECURITY_NUMBER
                            		 ELSE NULL END, sc.SSN), '-', '') ,'')
     		IS NULL
	)
--	) WHERE CLIENT_SSN IS NOT NULL GROUP BY 1 HAVING COUNT(*) > 1 ORDER BY 2 DESC
),
latest_intake AS
(
SELECT DISTINCT intake2.Source_System_ID, intake2.Client_Key, MAX( intake2.Report_Date) AS Max_Report_Date
FROM DW_Prod.HAH.FACT_Intake AS intake2 
GROUP BY intake2.Source_System_ID, intake2.Client_Key
),
client_branch AS
(
SELECT intake.Source_System_ID, intake.Client_Key, MIN( intake.Branch_Key) AS Branch_Key
FROM   DW_Prod.HAH.FACT_Intake AS intake
INNER JOIN latest_intake AS li ON li.Client_Key = intake.CLient_Key AND li.Max_Report_Date = intake.Report_Date AND li.Source_System_ID = intake.Source_System_ID
GROUP BY intake.Source_System_ID, intake.Client_Key
),
client_office AS
(
SELECT cb.Source_System_ID, cb.Client_Key, cb.Branch_Key, brnch.Office_State_Code, brnch.OFFICE_NUMBER, brnch.OFFICE_CODE, brnch.Office_Name, brnch.Office_Name_Alt, brnch.Detailed_Office_Name
FROM   (SELECT* FROM DW_Prod.HAH.DIM_Branch WHERE BRANCH_KEY <> '115cd45a7a09b6c402f4191bf6e21b62') AS brnch
INNER JOIN client_branch AS cb ON cb.Branch_Key = brnch.Branch_Key AND cb.Source_System_ID = brnch.Source_System_ID
),
visit AS
(
SELECT v.CLIENT_KEY, MIN( v.SERVICE_DATE) AS FIRST_SERVICE_DATE, MAX( v.SERVICE_DATE) AS LAST_SERVICE_DATE
FROM DW_PROD.HAH.FACT_VISIT v
GROUP BY 1
),
COASTAL_LOCATION AS
(
SELECT mh.DB, mh.CLIENTNUMBER,
	FIRST_VALUE( mh2.LOCATION_CODE IGNORE NULLS) OVER (PARTITION BY mh2.DB, mh2.CLIENTNUMBER ORDER BY mh2.FIRSTDATEOFSERVICE DESC, mh2.REFERRALDATE DESC) AS LOCATION_CODE
FROM (SELECT DISTINCT DB, CLIENTNUMBER FROM DISC_PROD.COSTALSYNCDATA.CV_MONTHLYHOURS
	  WHERE NVL( HoursAuthorized,0) <> 0 AND ETL_LAST_UPDATED_DATE >= '1900-01-01') mh
LEFT OUTER JOIN ( SELECT DISTINCT DB, CLIENTNUMBER, LOCATION_CODE, FIRSTDATEOFSERVICE, REFERRALDATE FROM DISC_PROD.COSTALSYNCDATA.CV_MONTHLYHOURS
	  WHERE NVL( HoursAuthorized,0) <> 0 AND ETL_LAST_UPDATED_DATE >= '1900-01-01') mh2
ON mh.DB = mh2.DB AND mh.CLIENTNUMBER = mh2.CLIENTNUMBER
),
PA_MRN_CHART AS
(
SELECT DISTINCT CLIENTID,
	FIRST_VALUE( MRN IGNORE NULLS) OVER (PARTITION BY CLIENTID ORDER BY SOC DESC, ROC DESC, EOC DESC) AS MEDICAID_NUMBER,
	FIRST_VALUE( CHARTID IGNORE NULLS) OVER (PARTITION BY CLIENTID ORDER BY SOC DESC, ROC DESC, EOC DESC) AS CHART_ID
FROM (SELECT * FROM DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS WHERE AGENCYID = '8485')
)
SELECT 'CLI' AS Record_Type, NULL AS Department, NULL AS Department_Code,
       CASE WHEN cl.SOURCE_SYSTEM_ID IN (3,4) THEN ro.Node_Key
       		WHEN cl.SOURCE_SYSTEM_ID IN (1,2) THEN ro2.NODE_KEY 
       		ELSE NULL END AS Location,
       co.Office_State_Code, co.OFFICE_NUMBER, co.Office_Name, NVL( co.OFFICE_CODE, cloc.LOCATION_CODE) AS OFFICE_CODE,
       'C-' || CASE WHEN TRIM( cl.SYSTEM_CODE) IN ('8485') THEN 'EXCEL'
       				WHEN TRIM( cl.SYSTEM_CODE) IN ('AL') THEN 'STATEWIDE-AL'
       				WHEN TRIM( cl.SYSTEM_CODE) IN ('MS') THEN 'STATEWIDE-MS'
       				WHEN TRIM( cl.SYSTEM_CODE) IN ('MI') THEN 'MICHIGAN'
       				WHEN TRIM( cl.SYSTEM_CODE) IN ('SHC_SAVANNAH') THEN 'COASTAL'
       				WHEN TRIM( cl.SYSTEM_CODE) IN ('SHC_ALTRUS') THEN 'ALTRUS'
       				ELSE 'HAH'||TRIM( cl.SYSTEM_CODE) END
        AS HAH_SYSTEM_CODE,
	   cl.Client_Number::STRING AS Employee_Number,
	   HAH_SYSTEM_CODE || '-' || cl.Client_Number::STRING AS HAH_SYSTEM_NUMBER,
       NULL AS Contact_Type,
       NULL AS Supervisor_ID, NULL AS Supervisor_Name, NULL AS Salutation, 
       NULL AS Title,
       REGEXP_REPLACE( UPPER( TRIM( cl.Client_First_Name)),'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)','') AS First_Name,
       SUBSTRING( REGEXP_REPLACE( UPPER( TRIM( cl.Client_Middle_Name)),'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''), 0, 1) AS Middle_Initial,
       REGEXP_REPLACE( UPPER( TRIM( cl.Client_Last_Name)),'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\(|\\)','') AS Last_Name,
       NULL AS Mailing_Street, NULL AS Apartment_Number, NULL AS Mailing_City, NULL AS Mailing_State, NULL AS Mailing_Postal_Code, NULL AS Mailing_Country,
       'C-'||cl.Client_KEY || '@hah.com' AS Email, 
       cl.Client_Home_Phone AS Home_Phone, 
       NULL AS Mobile_Phone, NULL AS Business_Phone, NULL AS Business_Fax, NULL AS Drivers_License_Number,
       CASE WHEN cl.Client_DOB >= CURRENT_DATE() THEN NULL ELSE TO_CHAR( cl.Client_DOB, 'MM/DD/YYYY') END AS Birthdate,
       CASE WHEN UPPER( cl.Client_Gender) IN ('F', 'FEMALE') THEN 'Female' WHEN UPPER( cl.Client_Gender) IN ('M', 'MALE') THEN 'Male' ELSE NULL END AS Gender, 
       NULL AS Contact_Description, NULL AS Other_Street, NULL AS Other_City, NULL AS Other_Postal_Code, NULL AS Other_State, NULL AS Other_Country,
       CASE WHEN cl.CLIENT_CELL_PHONE IS NOT NULL AND TRIM( cl.CLIENT_CELL_PHONE) <> '' THEN cl.CLIENT_CELL_PHONE
            WHEN cl.CLIENT_WORK_PHONE IS NOT NULL AND TRIM( cl.CLIENT_WORK_PHONE) <> '' THEN cl.CLIENT_WORK_PHONE
            ELSE NULL END AS Other_Phone,
       REPLACE(NVL( CASE WHEN NULLIF( dfc.SSN,'') IS NOT NULL AND dfc.SSN <> '' THEN dfc.SSN
       					 WHEN cvp.SOCIAL_SECURITY_NUMBER IS NOT NULL AND cvp.SOCIAL_SECURITY_NUMBER <> '' THEN cvp.SOCIAL_SECURITY_NUMBER
                         ELSE NULL END, sc.SSN), '-', '')
        AS SSN,
       NULL AS Job_Code, NULL AS Pay_Type, NULL AS Average_Weekly_Wage, NULL AS Salary, NULL AS Employment_Status,
       NULL AS Hire_Date,
       sc.DOD AS Date_of_Death,
       NULL AS Termination_Date,
       NULL AS Custom_Checkbox_1, NULL AS Custom_Checkbox_2,
       NULL AS Custom_Datetime_1, NULL AS Custom_Datetime_2,
       NULL AS Custom_Number_1, NULL AS Custom_Number_2,
       NULL AS Custom_Phone_1, NULL AS Custom_Phone_2,
       CASE WHEN TRIM( cvp.MARITALSTATS_CODE) IN ('M','MAR','Mar') THEN 'Married'
       		WHEN TRIM( cvp.MARITALSTATS_CODE) IN ('S','W','D') THEN 'Single'
       		WHEN TRIM( sc.MARITAL) IN ('Married') THEN 'Married'
       		WHEN TRIM( sc.MARITAL) IN ('Single','Widowed','Divorced') THEN 'Single'
       		ELSE 'Unknown' END
       	AS Marital_Status,
       CASE WHEN cl.ACTIVE_CLIENT_FLAG = TRUE THEN 'Active'
            ELSE 'Inactive'
            END AS Active_Inactive,
       REPLACE( REPLACE( REPLACE(
       		REGEXP_REPLACE( 
       		UPPER( TRIM( SUBSTRING ( NVL( NULLIF( TRIM( cl.Client_Address1||' '||cl.Client_Address2),''),
       								 NVL( NULLIF( cvp.STREET_NAME,'                               '), cvp.ADDRESS)), 0, 100))),
       		'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''),
       		'SUITE', 'STE'),
       		'APARTMENT', 'APT'),
       		'STREET', 'ST') AS Address_1,
       NULL AS Address_2,
       NVL( NULLIF( SUBSTRING( cl.Client_City, 1, 40),''), cvp.CITY) AS City,
       NVL( TRIM( cl.Client_State_Code), cvp.STATE_CODE) AS State,
       NVL( cl.Client_Zip, cvp.ZIPCODE) AS Zip_Code,
       'USA' AS Country,
       cl.Client_Number AS Client_ID,
       'C-'||cl.Client_Key AS Data_Warehouse_ID,
       NULL AS Initial_Hire_Date,
       NVL( CASE WHEN TRIM( dfc.Ethics) = 'A' THEN 'Asian'
                 WHEN TRIM( dfc.Ethics) = 'B' THEN 'Black or African American'
                 WHEN TRIM( dfc.Ethics) = 'W' THEN 'White'
                 WHEN TRIM( dfc.Ethics) = 'H' THEN 'Hispanic or Latino'
                 WHEN TRIM( dfc.Ethics) = 'N' THEN 'Native Hawaiian or Other Pacific Islander'
                 WHEN TRIM( dfc.Ethics) = 'E' THEN 'Eskimo'
                 WHEN TRIM( dfc.Ethics) = 'I' THEN 'American Indian/Alaskan'
                 WHEN TRIM( cvp.RACE_CODE) = '1' THEN 'American Indian/Alaskan'
                 WHEN TRIM( cvp.RACE_CODE) = '2' THEN 'Asian'
                 WHEN TRIM( cvp.RACE_CODE) = '3' THEN 'Black or African American'
                 WHEN TRIM( cvp.RACE_CODE) = '4' THEN 'Hispanic or Latino'
                 WHEN TRIM( cvp.RACE_CODE) = '5' THEN 'Native Hawaiian or Other Pacific Islander'
                 WHEN TRIM( cvp.RACE_CODE) = '6' THEN 'White'
                 WHEN TRIM( cvp.RACE_CODE) = 'UK' THEN 'Unknown'
                 WHEN TRIM( cvp.RACE_CODE) = 'O' THEN 'Other'
                 ELSE NULL
             END, sc.Ethnicity) AS Ethnic_Origin,
       NULL AS Contact_Email,
       NULL AS Position,
       'Help At Home' AS Account,
       TO_CHAR( v.First_Service_Date, 'MM/DD/YYYY') AS Service_Start_Date__c, 
       TO_CHAR( v.Last_Service_Date, 'MM/DD/YYYY') AS Service_End_Date__c
--	   ,cl.Client_State_Code AS MATCH_STATE
	   ,mc.MEDICAID_NUMBER, mc.CHART_ID
	   ,NULL AS PAYROLL_ID
	   ,NULL AS EMPLOYEE_ID
	   ,NULL AS EMPLOYEE_KEY
FROM UNIQUE_CLIENT uc
LEFT OUTER JOIN DW_PROD.HAH.DIM_CLIENT AS cl ON uc.CLIENT_KEY = cl.CLIENT_KEY
LEFT OUTER JOIN visit AS v ON v.CLIENT_KEY = cl.CLIENT_KEY
LEFT OUTER JOIN DISC_Prod.DataFlexSyncData.DFClients AS dfc ON cl.Source_System_ID = 3 AND cl.Client_State_Code = dfc.DBName AND cl.Client_Number = dfc.Number
LEFT OUTER JOIN DISC_Prod.SandataImport.Sandata_Clients AS sc ON cl.Source_System_ID = 4 AND sc.AgencyID = '8485' AND cl.Client_Number::VARCHAR = TRIM( sc.ClientID)::VARCHAR
LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.CV_PATIENTS AS cvp ON cl.SOURCE_SYSTEM_ID IN (1,2) AND TRIM( cl.SYSTEM_CODE) = TRIM( cvp.DB) AND cl.CLIENT_NUMBER::VARCHAR = TRIM( cvp.PATIENT_NUMBER)::VARCHAR
LEFT OUTER JOIN client_office AS co ON cl.SOURCE_SYSTEM_ID IN (3,4) AND cl.Source_System_ID = co.Source_System_ID AND cl.Client_Key = co.Client_Key
LEFT OUTER JOIN COASTAL_LOCATION AS cloc ON cl.SOURCE_SYSTEM_ID IN (1,2) AND TRIM( cloc.DB) = cl.SYSTEM_CODE AND TRIM( cloc.CLIENTNUMBER) = cl.CLIENT_NUMBER
LEFT OUTER JOIN (SELECT * FROM DW_DEV.REPORT.VW_RISKONNECT_NODE_HIERARCHY WHERE UPPER( HIERARCHY_NODE) NOT LIKE ('%INACTIVE%')) AS ro
	ON cl.SOURCE_SYSTEM_ID IN (3,4)
				AND ro.State = co.Office_State_Code AND TO_VARCHAR( ro.OfficeNo) = TO_VARCHAR( co.Office_Number)
LEFT OUTER JOIN (SELECT * FROM DW_DEV.REPORT.VW_RISKONNECT_NODE_HIERARCHY WHERE UPPER( HIERARCHY_NODE) NOT LIKE ('%INACTIVE%')) AS ro2
	ON cl.SOURCE_SYSTEM_ID IN (1,2)
				AND ro2.OFFICE_CODE = TRIM( cloc.LOCATION_CODE)
LEFT OUTER JOIN PA_MRN_CHART mc
	ON cl.SOURCE_SYSTEM_ID = 4 AND cl.CLIENT_NUMBER = mc.CLIENTID
--LEFT OUTER JOIN @DISC_DEV.Stage.AZStage/CSV_Files/RK_PAclients_fromNicole_20200104 (file_format => DISC_DEV.Stage.CSV_Format) pa ON cl.SOURCE_SYSTEM_ID = 4 AND cl.CLIENT_NUMBER = TRIM( pa.$3)
WHERE cl.Source_System_ID IN (1,2,4)
	OR (cl.SOURCE_SYSTEM_ID = 3
		AND cl.SYSTEM_CODE NOT IN ('PA','GA','SC')
	   )
	AND UPPER( TRIM( cl.CLIENT_FIRST_NAME)) <> 'BRANCH'
	AND LEFT( TRIM( cl.CLIENT_LAST_NAME),3) <> 'DD '
) UNION ALL (
-- Coastal employee extract
WITH UNIQUE_PID AS
	(
		SELECT DISTINCT MD5( HEX_DECODE_STRING( EMPLOYEE_PID)) AS EMPLOYEE_PID,
			FIRST_VALUE( EMPLOYEE_KEY) IGNORE NULLS 
				OVER( PARTITION BY EMPLOYEE_PID
				ORDER BY NVL( EMPLOYEE_LAST_CHECK_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_BENEFIT_START_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_HIRE_DATE, '1900-01-01') DESC, EMPLOYEE_NUMBER)
				AS EMPLOYEE_KEY
		FROM (
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (1,2)
			  ) UNION
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (4) AND SYSTEM_CODE = '8485'
			  ) UNION
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (5) AND UPPER( WORK_STATE) NOT IN ('GA','SC')
			 )) e
		WHERE MD5( HEX_DECODE_STRING( EMPLOYEE_PID)) NOT IN ('07eaad40608dee87230752347b2d29f4','bbb8aae57c104cda40c93843ad5e6db8','a19a654c4403b86cb0c437097ff04466',
									 '77c9749b451ab8c713c48037ddfbb2c4','9e4524c2628490392f0db89f7487b3da','4c93008615c2d041e33ebac605d14b5b')
	),
GP_COASTAL AS
	(
		SELECT DISTINCT *,
			ROW_NUMBER() OVER( PARTITION BY TRIM( DB), TRIM( EMPLOYEE_ID) ORDER BY BENEFIT_START_DATE DESC) AS ROWNUMBER
		FROM DISC_PROD.COSTALSYNCDATA.GPALLEMPLOYEESBASE
	),
CV_EMP AS
	(
		SELECT DISTINCT TRIM( DB) AS DB,
			TRIM( NURSE_ID) AS NURSE_ID,
			FIRST_VALUE( TRIM( LOCATION_CODE) IGNORE NULLS)
				OVER (PARTITION BY TRIM( DB), TRIM( NURSE_ID) ORDER BY ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC, USER_CODE)
				AS LOCATION_CODE,
			FIRST_VALUE( TRIM( FACILITY_CODE) IGNORE NULLS)
				OVER (PARTITION BY TRIM( DB), TRIM( NURSE_ID) ORDER BY ETL_LAST_UPDATED_DATE DESC, ETL_INSERTED_DATE DESC, USER_CODE)
				AS FACILITY_CODE
		FROM DISC_PROD.COSTALSYNCDATA.CV_EMPLOYEES
	)
SELECT DISTINCT 'EMP' AS Record_Type,
	   		CASE WHEN cgp.IS_ADMIN = 1 THEN 'Admin'
		   		 WHEN cgp.IS_ADMIN = 0 THEN 'Field'
	   			 WHEN emp.EMPLOYEE_CATEGORY = 'Field' THEN 'Field'
	   			 ELSE 'Admin' END
	   		AS Department,
	   NULL AS Department_Code,
	   brnch.RISKCONNECT_NODE_KEY AS LOCATION,
       brnch.OFFICE_STATE_CODE, brnch.OFFICE_NUMBER, brnch.OFFICE_CODE, brnch.OFFICE_NAME,
       'E-' ||
       		CASE WHEN TRIM( emp.SYSTEM_CODE) IN ('SHC_SAVANNAH','GA','SC') THEN 'COASTAL'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('SHC_ALTRUS') THEN 'ALTRUS'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('8485') THEN 'EXCEL'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('STW','AL','MS') THEN 'STATEWIDE'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('MI','MICH') THEN 'MICHIGAN'
       			 ELSE 'HAH' END
       		AS HAH_SYSTEM_CODE,
       TRIM( emp.EMPLOYEE_ID) AS Employee_Number,
       HAH_SYSTEM_CODE || '-' || TRIM( emp.EMPLOYEE_ID) AS HAH_SYSTEM_NUMBER,
       NULL AS Contact_Type,
       NULL AS Supervisor_ID, NULL AS Supervisor_Name, NULL AS Salutation,
       NULL AS Title,
       emp.Employee_First_Name AS First_Name, SUBSTRING( emp.Employee_Middle_Name, 0, 1) AS Middle_Initial, emp.Employee_Last_Name AS Last_Name,
       NULL AS Mailing_Street, NULL AS Apartment_Number, NULL AS Mailing_City, NULL AS Mailing_State, NULL AS Mailing_Postal_Code, NULL AS Mailing_Country,
       'E-'||MD5( HEX_DECODE_STRING( emp.Employee_PID))||'@hah.com' AS Email,
       NULLIF( NULLIF( TRIM( cgp.PHONE_NUMBER),'0000000000'),'') AS Home_Phone,
       NULL AS Mobile_Phone, NULL AS Business_Phone, NULL AS Business_Fax, NULL AS Drivers_License_Number,
       TO_CHAR( COALESCE( NULLIF( emp.Employee_DOB,'1900-01-01'), NULLIF( cgp.DOB, '1900-01-01')), 'MM/DD/YYYY') AS Birthdate,
       CASE WHEN UPPER( emp.Employee_Gender) IN ('F', 'FEMALE') THEN 'Female' WHEN UPPER( emp.Employee_Gender) IN ( 'M', 'MALE') THEN 'Male' ELSE NULL END AS Gender,
       NULL AS Contact_Description, NULL AS Other_Street, NULL AS Other_City, NULL AS Other_Postal_Code, NULL AS Other_State, NULL AS Other_Country,
       NULLIF( NULLIF( TRIM( cgp.PHONE_NUMBER_2),'0000000000'),'') AS Other_Phone,
       REPLACE( COALESCE( HEX_DECODE_STRING( emp.Employee_PID), TRIM( cgp.SSN)), '-', '') AS SSN,
       NULL AS Job_Code,
       NULL AS Pay_Type,
       NULL AS Average_Weekly_Wage, NULL AS Salary,
       NULL AS Employment_Status,
       TO_CHAR( COALESCE( NULLIF( emp.Employee_Hire_Date,'1900-01-01'),
       					  NULLIF( cgp.HIRE_DATE, '1900-01-01'))
       					  , 'MM/DD/YYYY') AS Hire_Date,
       NULL AS Date_of_Death,
       TO_CHAR( NULLIF( emp.Employee_Terminate_Date,'1900-01-01'), 'MM/DD/YYYY') AS Termination_Date,
       NULL AS Custom_Checkbox_1, NULL AS Custom_Checkbox_2,
       NULL AS Custom_Datetime_1, NULL AS Custom_Datetime_2,
       NULL AS Custom_Number_1, NULL AS Custom_Number_2,
       NULL AS Custom_Phone_1, NULL AS Custom_Phone_2,
       CASE WHEN emp.EMPLOYEE_MARITAL_STATUS IS NULL OR emp.EMPLOYEE_MARITAL_STATUS IN ('','Separated','N/A') THEN 'Unknown'
	       	WHEN emp.EMPLOYEE_MARITAL_STATUS IN ('Widowed','Divorced') THEN 'Single'
	       	ELSE emp.EMPLOYEE_MARITAL_STATUS END
	   	AS Marital_Status,
       CASE WHEN emp.Active_Employee_Flag = TRUE THEN 'Active'
            ELSE 'Inactive' END
       	AS Active_Inactive,
       REPLACE( REPLACE( REPLACE(
       		REGEXP_REPLACE( 
       		UPPER( SUBSTRING ( TRIM( emp.EMPLOYEE_ADDRESS1)||' '||NVL( TRIM( emp.EMPLOYEE_ADDRESS2),''), 0, 100)),
       		'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''),
       		'SUITE', 'STE'),
       		'APARTMENT', 'APT'),
       		'STREET', 'ST')
       		AS Address_1,
       NULL AS Address_2,
       SUBSTRING ( emp.EMPLOYEE_CITY, 1, 40) AS City,
	   UPPER( COALESCE( NULLIF( emp.EMPLOYEE_STATE_CODE,''), NULLIF( emp.WORK_STATE,''), NULLIF( emp.SUTA_STATE,''))) AS State,
	   TRIM( emp.EMPLOYEE_ZIP) AS Zip_Code,
       'USA' AS Country,
       NULL AS Client_ID,
       'E-'||MD5( HEX_DECODE_STRING( emp.Employee_PID)) AS Data_Warehouse_ID,
      TO_CHAR(  COALESCE( NULLIF( emp.Employee_Hire_Date,'1900-01-01'),
       					  NULLIF( cgp.HIRE_DATE, '1900-01-01'))
       					  ,'MM/DD/YYYY')
       		AS Initial_Hire_Date,
       emp.Employee_Ethnicity AS Ethnic_Origin,
       NULL AS Contact_Email,
       CASE WHEN NULLIF( TRIM( emp.Job_Title),'') IS NULL OR NULLIF( TRIM( emp.Job_Description),'') IS NULL 
       			THEN NVL( NULLIF( TRIM( emp.Job_Title),''), NULLIF( TRIM( emp.Job_Description),''))
       		ELSE TRIM( emp.Job_Title)||' - '||TRIM( emp.Job_Description)
       	END AS Position,
       'Help At Home' AS Account,
       NULL AS Service_Start_Date__c,
       NULL AS Service_End_Date__c
--       ,COALESCE( NULLIF( brnch.OFFICE_STATE_CODE,''), NULLIF( emp.EMPLOYEE_STATE_CODE,''), NULLIF( emp.WORK_STATE,''), NULLIF( emp.SUTA_STATE,'')) AS MATCH_STATE
	   ,NULL AS MEDICAID_NUMBER, NULL AS CHART_ID
	   ,cgp.EMPLOYEE_ID::VARCHAR AS PAYROLL_ID
	   ,cgp.EMPLOYEE_ID::VARCHAR AS EMPLOYEE_ID
	   ,upid.EMPLOYEE_KEY
FROM UNIQUE_PID upid
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.DIM_Employee WHERE SOURCE_SYSTEM_ID IN (1,2)) AS emp
	ON upid.EMPLOYEE_KEY = emp.EMPLOYEE_KEY
LEFT OUTER JOIN GP_COASTAL AS cgp
	ON TRIM( cgp.EMPLOYEE_ID) = TRIM( emp.EMPLOYEE_ID)
	AND TRIM( cgp.DB) = CASE WHEN TRIM( emp.SYSTEM_CODE) = 'SHC_ALTRUS' THEN 'ALTRU'
							 WHEN TRIM( emp.SYSTEM_CODE) = 'SHC_SAVANNAH' THEN 'SHC'
							 ELSE TRIM( emp.SYSTEM_CODE) END
	AND cgp.ROWNUMBER = 1
LEFT OUTER JOIN CV_EMP AS cve
	ON CASE WHEN cve.DB = 'SHC_ALTRUS' THEN 'ALTRU' WHEN cve.DB = 'SHC_SAVANNAH' THEN 'SHC' ELSE NULL END = TRIM( emp.SYSTEM_CODE)
		   AND TRIM( cve.NURSE_ID) = TRIM( emp.EMPLOYEE_ID)
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.DIM_Branch WHERE BRANCH_KEY <> '115cd45a7a09b6c402f4191bf6e21b62') AS brnch
	ON emp.PRIMARY_BRANCH_KEY = brnch.BRANCH_KEY
LEFT OUTER JOIN (SELECT * FROM DW_DEV.REPORT.VW_RISKONNECT_NODE_HIERARCHY WHERE UPPER( HIERARCHY_NODE) NOT LIKE ('%INACTIVE%')) AS ro
	ON NVL( TRIM( brnch.PARENT_OFFICE_CODE), TRIM( cgp.DEPARTMENT)) = TRIM( ro.OFFICE_CODE)
WHERE NULLIF( TRIM( emp.EMPLOYEE_LAST_NAME),'') IS NOT NULL AND NULLIF( TRIM( emp.EMPLOYEE_FIRST_NAME),'') IS NOT NULL
	AND LEFT( TRIM( emp.EMPLOYEE_LAST_NAME),9) <> 'HOST HOME'
)
UNION ALL
-- HAH/DF employee extract
(
WITH UNIQUE_PID AS
	(
		SELECT DISTINCT MD5( HEX_DECODE_STRING( EMPLOYEE_PID)) AS EMPLOYEE_PID,
			FIRST_VALUE( EMPLOYEE_KEY) IGNORE NULLS 
				OVER( PARTITION BY EMPLOYEE_PID
				ORDER BY NVL( EMPLOYEE_LAST_CHECK_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_BENEFIT_START_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_HIRE_DATE, '1900-01-01') DESC, EMPLOYEE_NUMBER)
				AS EMPLOYEE_KEY
		FROM (
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (1,2)
			  ) UNION
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (4) AND SYSTEM_CODE = '8485'
			  ) UNION
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (5) AND UPPER( WORK_STATE) NOT IN ('GA','SC')
			 )) e
		WHERE MD5( HEX_DECODE_STRING( EMPLOYEE_PID)) NOT IN ('07eaad40608dee87230752347b2d29f4','bbb8aae57c104cda40c93843ad5e6db8','a19a654c4403b86cb0c437097ff04466',
									 '77c9749b451ab8c713c48037ddfbb2c4','9e4524c2628490392f0db89f7487b3da','4c93008615c2d041e33ebac605d14b5b')
	),
UNIQUE_DFID AS
	(
		SELECT DISTINCT TRIM( SSN) AS SSN,
			FIRST_VALUE( TRIM( DBNAME)) IGNORE NULLS 
				OVER( PARTITION BY TRIM( SSN)
				ORDER BY NVL( LASTCHECKDATE, '1900-01-01') DESC, NVL( TERMINATEDATE, '1900-01-01') DESC, NVL( HIREDATE, '1900-01-01'), NUMBER )
				AS DBNAME,
			FIRST_VALUE( NUMBER) IGNORE NULLS 
				OVER( PARTITION BY TRIM( SSN)
				ORDER BY NVL( LASTCHECKDATE, '1900-01-01') DESC, NVL( TERMINATEDATE, '1900-01-01') DESC, NVL( HIREDATE, '1900-01-01'), NUMBER)
				AS NUMBER,
			FIRST_VALUE( PAYROLLID) IGNORE NULLS 
				OVER( PARTITION BY TRIM( SSN)
				ORDER BY NVL( LASTCHECKDATE, '1900-01-01') DESC, NVL( TERMINATEDATE, '1900-01-01') DESC, NVL( HIREDATE, '1900-01-01'), NUMBER)
				AS PAYROLLID
		FROM DISC_PROD.DATAFLEXSYNCDATA.DFEMPLOYEES
		WHERE TRIM( SSN) NOT IN ('123456789','111111111') AND TRIM( SSN) NOT LIKE '%0000%'
	)
SELECT DISTINCT 'EMP' AS Record_Type,
	   CASE WHEN emp.EMPLOYEE_CATEGORY = 'Field' THEN 'Field' ELSE 'Admin' END AS Department,
	   NULL AS Department_Code,
       brnch.RISKCONNECT_NODE_KEY
       		AS Location,
       brnch.OFFICE_STATE_CODE, brnch.OFFICE_NUMBER, brnch.OFFICE_CODE, brnch.OFFICE_NAME,
       'E-' ||
       		CASE WHEN TRIM( emp.SYSTEM_CODE) IN ('SHC_SAVANNAH','GA','SC') THEN 'COASTAL'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('SHC_ALTRUS') THEN 'ALTRUS'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('8485') THEN 'EXCEL'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('STW','AL','MS') THEN 'STATEWIDE'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('MI','MICH') THEN 'MICHIGAN'
       			 ELSE 'HAH' END
       		AS HAH_SYSTEM_CODE,
       /*NVL( dfe."NUMBER"::VARCHAR,*/ TRIM( emp.EMPLOYEE_ID)--)
       		AS Employee_Number,
       HAH_SYSTEM_CODE || '-' || /*NVL( dfe."NUMBER"::VARCHAR,*/ TRIM( emp.EMPLOYEE_ID)/*)*/ AS HAH_SYSTEM_NUMBER,
       NULL AS Contact_Type,
       NULL AS Supervisor_ID, NULL AS Supervisor_Name, NULL AS Salutation,
       NULL AS Title,
       TRIM( emp.Employee_First_Name) AS First_Name, SUBSTRING( emp.Employee_Middle_Name, 0, 1) AS Middle_Initial, TRIM( emp.Employee_Last_Name) AS Last_Name,
       NULL AS Mailing_Street, NULL AS Apartment_Number, NULL AS Mailing_City, NULL AS Mailing_State, NULL AS Mailing_Postal_Code, NULL AS Mailing_Country,
       'E-'||MD5( HEX_DECODE_STRING( emp.Employee_PID))||'@hah.com' AS Email,
       COALESCE( NULLIF( NULLIF( TRIM( gpe.Phone_Number),''),'0000000000'),
       			 NULLIF( NULLIF( TRIM( dfe.PHONENUMBER),''),'0000000000'))
       		AS Home_Phone,
       NULL AS Mobile_Phone, NULL AS Business_Phone, NULL AS Business_Fax, NULL AS Drivers_License_Number,
       TO_CHAR( emp.Employee_DOB, 'MM/DD/YYYY') AS Birthdate,
       CASE WHEN UPPER( emp.Employee_Gender) IN ('F', 'FEMALE') THEN 'Female' WHEN UPPER( emp.Employee_Gender) IN ( 'M', 'MALE') THEN 'Male' ELSE NULL END AS Gender,
       NULL AS Contact_Description, NULL AS Other_Street, NULL AS Other_City, NULL AS Other_Postal_Code, NULL AS Other_State, NULL AS Other_Country,
       COALESCE( NULLIF( NULLIF( TRIM( gpe.Phone_Number_2),''),'0000000000'),
       			 IFF( NULLIF( NULLIF( TRIM( dfe.PHONENUMBER),''),'0000000000') <> Home_Phone, NULLIF( NULLIF( TRIM( dfe.PHONENUMBER),''),'0000000000'), NULL))
       		AS Other_Phone,
       REPLACE( COALESCE( HEX_DECODE_STRING( emp.Employee_PID), NULLIF( TRIM( gpe.SSN),''), NULLIF( TRIM( dfe.SSN),'')), '-', '') AS SSN,
       NULL AS Job_Code,
       NULL AS Pay_Type,
       NULL AS Average_Weekly_Wage, NULL AS Salary,
       NULL AS Employment_Status,
--       TO_CHAR( COALESCE( NULLIF( emp.Employee_Hire_Date,'1900-01-01'),
--       					  NULLIF( gpe.HIRE_DATE, '1900-01-01'),
--       					  NULLIF( dfe.HIREDATE, '1900-01-01')),
--       			'MM/DD/YYYY')
--       		AS Hire_Date,
	   TO_CHAR( NULLIF( emp.EMPLOYEE_BENEFIT_START_DATE,'1900-01-01'),'MM/DD/YYYY') AS HIRE_DATE,
       NULL AS Date_of_Death,
       TO_CHAR( NULLIF( emp.Employee_Terminate_Date,'1900-01-01'), 'MM/DD/YYYY') AS Termination_Date,
       NULL AS Custom_Checkbox_1, NULL AS Custom_Checkbox_2,
       NULL AS Custom_Datetime_1, NULL AS Custom_Datetime_2,
       NULL AS Custom_Number_1, NULL AS Custom_Number_2,
       NULL AS Custom_Phone_1, NULL AS Custom_Phone_2,
       CASE WHEN emp.EMPLOYEE_MARITAL_STATUS IS NULL OR emp.EMPLOYEE_MARITAL_STATUS IN ('','Separated','N/A') THEN 'Unknown'
	       	WHEN emp.EMPLOYEE_MARITAL_STATUS IN ('Widowed','Divorced') THEN 'Single'
	       	ELSE emp.EMPLOYEE_MARITAL_STATUS END
       	AS Marital_Status,
       CASE WHEN emp.Active_Employee_Flag = TRUE THEN 'Active'
            ELSE 'Inactive' END
       	AS Active_Inactive,
       REPLACE( REPLACE( REPLACE(
       		REGEXP_REPLACE( 
       		UPPER( SUBSTRING ( NVL( TRIM( gpe.Address1),'')||' '||NVL( TRIM( gpe.Address2),'')||' '||NVL( TRIM( gpe.Address3),''), 0, 100)),
       		'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''),
       		'SUITE', 'STE'),
       		'APARTMENT', 'APT'),
       		'STREET', 'ST')
       		AS Address_1,
       NULL AS Address_2,
       COALESCE( SUBSTRING( gpe.City, 1, 40), SUBSTRING ( dfe.CITY, 1, 40)) AS City,
	   COALESCE( NULLIF( emp.EMPLOYEE_STATE_CODE,''), NULLIF( emp.WORK_STATE,''), NULLIF( emp.SUTA_STATE,'')) AS State,
	   emp.EMPLOYEE_ZIP AS Zip_Code,
       'USA' AS Country,
       NULL AS Client_ID,
       'E-'||MD5( HEX_DECODE_STRING( emp.Employee_PID)) AS Data_Warehouse_ID,
       TO_CHAR( COALESCE( NULLIF( emp.Employee_Hire_Date,'1900-01-01'),
       					  NULLIF( gpe.HIRE_DATE, '1900-01-01'),
       					  NULLIF( dfe.HIREDATE, '1900-01-01')),
       			'MM/DD/YYYY')
       		AS Initial_Hire_Date,
       emp.Employee_Ethnicity AS Ethnic_Origin,
       NULL AS Contact_Email,
       CASE WHEN NULLIF( TRIM( emp.Job_Title),'') IS NULL OR NULLIF( TRIM( emp.Job_Description),'') IS NULL 
       			THEN NVL( NULLIF( TRIM( emp.Job_Title),''), NULLIF( TRIM( emp.Job_Description),''))
       		ELSE TRIM( emp.Job_Title)||' - '||TRIM( emp.Job_Description)
       	END AS Position,
       'Help At Home' AS Account,
       NULL AS Service_Start_Date__c,
       NULL AS Service_End_Date__c
--       ,COALESCE( NULLIF( brnch.OFFICE_STATE_CODE,''), NULLIF( emp.EMPLOYEE_STATE_CODE,''), NULLIF( emp.WORK_STATE,''), NULLIF( emp.SUTA_STATE,'')) AS MATCH_STATE
	   ,NULL AS MEDICAID_NUMBER, NULL AS CHART_ID
	   ,gpe.EMPLOYEE_ID::VARCHAR AS PAYROLL_ID
	   ,dfe."NUMBER"::VARCHAR AS EMPLOYEE_ID
	   ,upid.EMPLOYEE_KEY
FROM UNIQUE_PID upid
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.DIM_Employee
				 WHERE SOURCE_SYSTEM_ID = 5 AND WORK_STATE NOT IN ('GA','SC','PA')) emp
	ON upid.EMPLOYEE_KEY = emp.EMPLOYEE_KEY
LEFT OUTER JOIN DISC_Prod.GPSyncData.GPAllEmployeesBase AS gpe	
	ON TRIM( gpe.Employee_ID) = TRIM( emp.EMPLOYEE_ID) AND TRIM( gpe.DB) = TRIM( emp.System_Code)
LEFT OUTER JOIN UNIQUE_DFID udf
	ON HEX_DECODE_STRING( emp.EMPLOYEE_PID) = TRIM( udf.SSN)
--	ON TRIM( emp.EMPLOYEE_ID) = TRIM( udf.PAYROLLID)
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFEMPLOYEES AS dfe
	ON TRIM( udf.DBNAME) = TRIM( dfe.DBNAME) AND udf.NUMBER = dfe.NUMBER
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.DIM_Branch WHERE BRANCH_KEY <> '115cd45a7a09b6c402f4191bf6e21b62') AS brnch ON brnch.Branch_Key = emp.Primary_Branch_Key
LEFT OUTER JOIN (SELECT * FROM DW_DEV.REPORT.VW_RISKONNECT_NODE_HIERARCHY WHERE UPPER( HIERARCHY_NODE) NOT LIKE ('%INACTIVE%')) AS ro
	ON TRIM( brnch.OFFICE_CODE) = TRIM( ro.OFFICE_CODE)
WHERE NULLIF( TRIM( emp.EMPLOYEE_LAST_NAME),'') IS NOT NULL AND NULLIF( TRIM( emp.EMPLOYEE_FIRST_NAME),'') IS NOT NULL
)
UNION ALL
-- PA field employee extract
(
WITH UNIQUE_PID AS
	(
		SELECT DISTINCT EMPLOYEE_PID,
			FIRST_VALUE( EMPLOYEE_KEY) IGNORE NULLS 
				OVER( PARTITION BY EMPLOYEE_PID
				ORDER BY NVL( EMPLOYEE_LAST_CHECK_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_BENEFIT_START_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_HIRE_DATE, '1900-01-01') DESC, EMPLOYEE_NUMBER)
				AS EMPLOYEE_KEY
		FROM (
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (1,2)
			  ) UNION
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (4) AND SYSTEM_CODE = '8485'
			  ) UNION
			  (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (5) AND UPPER( WORK_STATE) NOT IN ('GA','SC')
			 )) e
		WHERE EMPLOYEE_PID NOT IN ('07eaad40608dee87230752347b2d29f4','bbb8aae57c104cda40c93843ad5e6db8','a19a654c4403b86cb0c437097ff04466',
									 '77c9749b451ab8c713c48037ddfbb2c4','9e4524c2628490392f0db89f7487b3da','4c93008615c2d041e33ebac605d14b5b')
	)
SELECT DISTINCT 'EMP' AS Record_Type,
	   CASE WHEN emp.EMPLOYEE_CATEGORY = 'Field' THEN 'Field' ELSE 'Admin' END AS Department,
	   NULL AS Department_Code,
	   brnch.RISKCONNECT_NODE_KEY AS Location,
       brnch.OFFICE_STATE_CODE, brnch.OFFICE_NUMBER, brnch.OFFICE_CODE, brnch.OFFICE_NAME,
       'E-' ||
       		CASE WHEN TRIM( emp.SYSTEM_CODE) IN ('SHC_SAVANNAH','GA','SC') THEN 'COASTAL'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('SHC_ALTRUS') THEN 'ALTRUS'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('8485') THEN 'EXCEL'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('STW','AL','MS') THEN 'STATEWIDE'
       			 WHEN TRIM( emp.SYSTEM_CODE) IN ('MI','MICH') THEN 'MICHIGAN'
       			 ELSE 'HAH' END
       		AS HAH_SYSTEM_CODE,
       TRIM( emp.EMPLOYEE_ID) AS Employee_Number,
       HAH_SYSTEM_CODE || '-' || TRIM( emp.EMPLOYEE_ID) AS HAH_SYSTEM_NUMBER,
       NULL AS Contact_Type,
       NULL AS Supervisor_ID, NULL AS Supervisor_Name, NULL AS Salutation,
       NULL AS Title,
       TRIM( emp.Employee_First_Name) AS First_Name, SUBSTRING( TRIM( emp.Employee_Middle_Name), 0, 1) AS Middle_Initial, TRIM( emp.Employee_Last_Name) AS Last_Name,
       NULL AS Mailing_Street, NULL AS Apartment_Number, NULL AS Mailing_City, NULL AS Mailing_State, NULL AS Mailing_Postal_Code, NULL AS Mailing_Country,
       'E-'||MD5( HEX_DECODE_STRING( emp.Employee_PID))||'@hah.com' AS Email,
       NULLIF( NULLIF( TRIM( stf.HomePhone),'0000000000'),'') AS Home_Phone,
       NULL AS Mobile_Phone, NULL AS Business_Phone, NULL AS Business_Fax, NULL AS Drivers_License_Number,
       TO_CHAR( COALESCE( NULLIF( emp.Employee_DOB,'1900-01-01'), NULLIF( tp.EMPLOYEE_DOB, '1900-01-01'), NULLIF( stf.DOB,'1900-01-01')), 'MM/DD/YYYY') AS Birthdate,
       CASE WHEN UPPER( emp.Employee_Gender) IN ('F', 'FEMALE') THEN 'Female' WHEN UPPER( emp.Employee_Gender) IN ( 'M', 'MALE') THEN 'Male' ELSE NULL END AS Gender,
       NULL AS Contact_Description, NULL AS Other_Street, NULL AS Other_City, NULL AS Other_Postal_Code, NULL AS Other_State, NULL AS Other_Country,
       COALESCE( NULLIF( NULLIF( TRIM( stf.WorkPhone),''),'0000000000'),
       			 NULLIF( NULLIF( TRIM( stf.MobilePhone),''),'0000000000')) AS Other_Phone,
       HEX_DECODE_STRING( emp.Employee_PID) AS SSN,
       NULL AS Job_Code,
       NULL AS Pay_Type,
       NULL AS Average_Weekly_Wage, NULL AS Salary,
       NULL AS Employment_Status,
       TO_CHAR( COALESCE( NULLIF( emp.Employee_Hire_Date,'1900-01-01'),
       					  NULLIF( stf.SOE, '1900-01-01')),
       					  'MM/DD/YYYY') AS Hire_Date,
       TO_CHAR( stf.DOD, 'MM/DD/YYYY') AS Date_of_Death,
       TO_CHAR( COALESCE( NULLIF( emp.Employee_Terminate_Date,'1900-01-01'), NULLIF( stf.EOE, '1900-01-01')), 'MM/DD/YYYY') AS Termination_Date,
       NULL AS Custom_Checkbox_1, NULL AS Custom_Checkbox_2,
       NULL AS Custom_Datetime_1, NULL AS Custom_Datetime_2,
       NULL AS Custom_Number_1, NULL AS Custom_Number_2,
       NULL AS Custom_Phone_1, NULL AS Custom_Phone_2,
       CASE WHEN emp.EMPLOYEE_MARITAL_STATUS IS NULL OR emp.EMPLOYEE_MARITAL_STATUS IN ('','Separated','N/A') THEN 'Unknown'
	       	WHEN TRIM( emp.EMPLOYEE_MARITAL_STATUS) IN ('Widowed','Divorced') THEN 'Single'
	       	ELSE TRIM( emp.EMPLOYEE_MARITAL_STATUS) END
       	AS Marital_Status,
       CASE WHEN emp.Active_Employee_Flag = TRUE THEN 'Active'
            ELSE 'Inactive'
       		END AS Active_Inactive,
       REPLACE( REPLACE( REPLACE(
       		REGEXP_REPLACE( 
       		COALESCE(
       			NULLIF( TRIM( UPPER( SUBSTRING( NVL( TRIM( emp.EMPLOYEE_ADDRESS1),'')||' '||NVL( TRIM( emp.EMPLOYEE_ADDRESS2),''), 0, 100))),''),
       			NULLIF( TRIM( UPPER( SUBSTRING( NVL( TRIM( tp.EMPLOYEE_ADDRESS1),'')||' '||NVL( TRIM( tp.EMPLOYEE_ADDRESS2),''), 0, 100))),''),
       			NULLIF( TRIM( UPPER( SUBSTRING( NVL( TRIM( stf.Address),'')||' '||NVL( TRIM( stf.Address2),'')||' '||NVL( TRIM( stf.AptNo),''), 0, 100))),'')),
       		'\\.|\\,|\\#|\\%|\\$|\\@|\\&|\\-|\\(|\\)',''),
       		'SUITE', 'STE'),
       		'APARTMENT', 'APT'),
       		'STREET', 'ST')
       		AS Address_1,
       NULL AS Address_2,
       COALESCE( NULLIF( SUBSTRING( TRIM( emp.EMPLOYEE_CITY), 1, 40),''),
       			 NULLIF( SUBSTRING( TRIM( tp.EMPLOYEE_CITY), 1, 40),''),
       			 NULLIF( SUBSTRING( TRIM( stf.City), 1, 40),''))
       		AS City,
	   COALESCE( NULLIF( emp.EMPLOYEE_STATE_CODE,''), NULLIF( emp.WORK_STATE,''), NULLIF( emp.SUTA_STATE,'')) AS State,
	   emp.EMPLOYEE_ZIP AS Zip_Code,
       'USA' AS Country,
       NULL AS Client_ID,
       'E-'||MD5( HEX_DECODE_STRING( emp.Employee_PID)) AS Data_Warehouse_ID,
       TO_CHAR( COALESCE( NULLIF( emp.Employee_Hire_Date,'1900-01-01'),
       					  NULLIF( stf.SOE, '1900-01-01')),
       			'MM/DD/YYYY')
       		AS Initial_Hire_Date,
       TRIM( emp.Employee_Ethnicity) AS Ethnic_Origin,
       TRIM( stf.EMAIL) AS Contact_Email,
       CASE WHEN NULLIF( TRIM( emp.Job_Title),'') IS NULL OR NULLIF( TRIM( emp.Job_Description),'') IS NULL 
       			THEN NVL( NULLIF( TRIM( emp.Job_Title),''), NULLIF( TRIM( emp.Job_Description),''))
       		ELSE TRIM( emp.Job_Title)||' - '||TRIM( emp.Job_Description)
       	END AS Position,
       'Help At Home' AS Account,
       NULL AS Service_Start_Date__c,
       NULL AS Service_End_Date__c
--       ,COALESCE( NULLIF( brnch.OFFICE_STATE_CODE,''), NULLIF( emp.EMPLOYEE_STATE_CODE,''), NULLIF( emp.WORK_STATE,''), NULLIF( emp.SUTA_STATE,'')) AS MATCH_STATE
	   ,NULL AS MEDICAID_NUMBER, NULL AS CHART_ID
	   ,tp.EMPLOYEE_NUMBER::VARCHAR AS PAYROLL_ID
	   ,tp.EMPLOYEE_NUMBER::VARCHAR AS EMPLOYEE_ID
	   ,upid.EMPLOYEE_KEY
FROM UNIQUE_PID upid
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.DIM_Employee WHERE SOURCE_SYSTEM_ID = 4 AND TRIM( SYSTEM_CODE) = '8485') AS emp
	ON upid.EMPLOYEE_KEY = emp.EMPLOYEE_KEY
LEFT OUTER JOIN (SELECT * FROM DISC_Prod.SanDataImport.Sandata_Staffs
				 WHERE AgencyID = '8485' AND TRY_TO_NUMBER( NULLIF( TRIM( STAFFAGENCYID),'')) IS NOT NULL) AS stf
	ON TRY_TO_NUMBER( NULLIF( TRIM( STAFFAGENCYID),''))::INTEGER = TRY_TO_NUMBER( emp.Employee_Number) AND TRIM( stf.AgencyID) = TRIM( emp.System_Code)
LEFT OUTER JOIN (SELECT * FROM DISC_DEV.TRUSTPOINTDATA.EMPLOYEES WHERE TRIM( COMPANY) = 'EXCEL') tp
	ON TRY_TO_NUMBER( TRIM( tp.EMPLOYEE_NUMBER)) = emp.EMPLOYEE_NUMBER AND emp.SOURCE_SYSTEM_ID = 4 AND emp.SYSTEM_CODE = '8485'
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.DIM_Branch WHERE BRANCH_KEY <> '115cd45a7a09b6c402f4191bf6e21b62') AS brnch ON brnch.Branch_Key = emp.Primary_Branch_Key
LEFT OUTER JOIN (SELECT * FROM DW_DEV.REPORT.VW_RISKONNECT_NODE_HIERARCHY WHERE UPPER( HIERARCHY_NODE) NOT LIKE ('%INACTIVE%')) AS ro
	ON TRIM( brnch.OFFICE_CODE) = TRIM( ro.OFFICE_CODE)
)
) RISK
LEFT OUTER JOIN DATA_MANAGEMENT.DATA_QUALITY.INVALID_SSN DQSSN
ON RISK.SSN = DQSSN.SSN
LEFT OUTER JOIN DATA_MANAGEMENT.DATA_QUALITY.INVALID_PHONE_NUMBER DQPN
ON RISK.Home_Phone = DQPN.PHONE_NUMBER
/*LEFT OUTER JOIN @DISC_DEV.Stage.AZStage/CSV_Files/RISKONNECT/Riskonnect_contactList_20210111_145PM (file_format => DISC_DEV.Stage.CSV_Format) rkSSN
ON TRIM( RISK.SSN) = RIGHT( '000000000'||REPLACE( TRIM( rkSSN.$4),'-',''),9)
LEFT OUTER JOIN @DISC_DEV.Stage.AZStage/CSV_Files/RISKONNECT/Riskonnect_contactList_20210111_145PM (file_format => DISC_DEV.Stage.CSV_Format) rkPAY
ON TRIM( RISK.PAYROLL_ID)::VARCHAR = TRIM( rkPAY.$8)::VARCHAR*/
--INNER JOIN @DW_DEV.Stage.AZStage/CSV_Files/RISKONNECT/RK_lostSouls_20210126 (file_format => DW_DEV.PUBLIC.CSV_Format) rkLS
--ON TRIM( RISK.SSN) = RIGHT( '000000000'||REPLACE( TRIM( rkLS.$1),'-',''),9)
) RK
WHERE HAH_SYSTEM_NUMBER IS NOT NULL AND HAH_INTERNAL_NUMBER IS NOT NULL
	AND NVL( TRIM( FIRST_NAME),'') <> 'TEST' AND TRIM( LAST_NAME) <> 'TEST'
	AND NULLIF( TRIM( FIRST_NAME),'') IS NOT NULL AND NULLIF( TRIM( LAST_NAME),'') IS NOT NULL
	AND NULLIF( TRIM( FIRST_NAME),'') <> 'HOME'
	AND NULLIF( TRIM( LAST_NAME),'') NOT IN ('HOME','WHISPERING PINES','SPECIAL TRANSITIONS','LIVING PEACEFULLY','PINE SHADOWS RETIREMENT')
	AND ACTIVE_INACTIVE = 'Active'
--	AND RECORD_TYPE = 'EMP'
--	AND LOCATION IS NULL AND State = 'PA'
--	AND SSN = '591-27-7463'
--	AND HAH_SYSTEM_NUMBER = 'E-EXCEL-98373'
--	AND UPPER( TRIM( FIRST_NAME)) LIKE '%JENN%' AND UPPER( TRIM( LAST_NAME)) LIKE '%MILLER%'
--	AND DATA_WAREHOUSE_ID IN ('E-ecc10cc4ba70c67a1874362cbfa55b61','E-096705faed328cd920c767f138bbbc7c')
--	AND REPLACE( SSN,'-','') IN ('308963899','490174418','587730854','426692088','428719273','473318360','425791538','425393525','427350677','428635898','428671724','307766332','428772892','473318360')
;
create or replace view DW_PROD.REPORT.VW_EQUIFAX_EMPLOYEE(
	"EmployeeUniqueIdentifier",
	"ControlledGroupCode",
	"EffectiveDateTime",
	"DataSource",
	"IsInvalid",
	"TransactionType",
	SSN,
	"Status",
	"FirstName",
	"LastName",
	"MiddleName",
	"Suffix",
	"HomeAddressLine1",
	"HomeAddressLine2",
	"HomeAddressCity",
	"HomeAddressState",
	"HomeAddressZip",
	"HomeAddressCountry",
	"ACAEmployeeDesignationCode",
	"ACAEmployeeCategoryCode",
	"DateOfBirth",
	"UserID",
	"DefaultPIN",
	"AdjustedHireDate",
	"WorkNumberDivision",
	"EmailAddress",
	"PrimaryPhoneNumber"
) as
SELECT DISTINCT EmployeeUniqueIdentifier AS "EmployeeUniqueIdentifier", ControlledGroupCode AS "ControlledGroupCode",
	EffectiveDateTime AS "EffectiveDateTime", DataSource AS "DataSource", IsInvalid AS "IsInvalid", TransactionType AS "TransactionType",
	SSN_COAL AS "SSN",
	Status AS "Status", upper(INITCAP( FirstName)) AS "FirstName", upper(INITCAP( LastName)) AS "LastName", upper(MiddleName) AS "MiddleName", upper(Suffix) AS "Suffix",
	upper(NULLIF( HomeAddressLine1,'')) AS "HomeAddressLine1",
	upper(NULLIF( HomeAddressLine2,'')) AS "HomeAddressLine2",
	upper(NULLIF( HomeAddressCity,'')) AS "HomeAddressCity",
	upper(NULLIF( HomeAddressState,'')) AS "HomeAddressState",
	NULLIF( HomeAddressZip,'') AS "HomeAddressZip",
	HomeAddressCountry AS "HomeAddressCountry",
	ACAEmployeeDesignationCode AS "ACAEmployeeDesignationCode", ACAEmployeeCategoryCode AS "ACAEmployeeCategoryCode",
	NVL( DateOfBirth,'1970-01-01') AS "DateOfBirth",
	UserID AS "UserID", DefaultPIN AS "DefaultPIN",
	AdjustedHireDate AS "AdjustedHireDate", WorkNumberDivision AS "WorkNumberDivision",
	upper(COALESCE( EmailAddress, NULLIF( s.$6,''), 'invalid@invalid.com'))  AS "EmailAddress",
	CASE WHEN LEN( PrimaryPhoneNumber) <> 10 THEN '5555555555'
		 WHEN DQPN.PHONE_NUMBER IS NOT NULL THEN '5555555555'
		 WHEN LEFT( PrimaryPhoneNumber,1) = '0' OR LEFT( PrimaryPhoneNumber,3) = '000' THEN '5555555555'
		 ELSE COALESCE( NULLIF( PrimaryPhoneNumber,'0'), '5555555555') END
		AS "PrimaryPhoneNumber"
FROM (
	WITH UNIQUE_PID AS
	(
		SELECT DISTINCT MD5( TRIM( HEX_DECODE_STRING( EMPLOYEE_PID))) AS EmployeeUniqueIdentifier,
			FIRST_VALUE( EMPLOYEE_KEY) IGNORE NULLS 
				OVER( PARTITION BY EMPLOYEE_PID ORDER BY ACTIVE_EMPLOYEE_FLAG DESC NULLS LAST, NVL( EMPLOYEE_LAST_CHECK_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_HIRE_DATE, '1900-01-01') DESC, EMPLOYEE_NUMBER)
				AS EMPLOYEE_KEY
		FROM DW_PROD.HAH.DIM_EMPLOYEE e
		WHERE (e.SOURCE_SYSTEM_ID IN (1,2,4) OR (e.SOURCE_SYSTEM_ID IN (5) AND e.WORK_STATE NOT IN ('GA','SC','PA')))
			AND MD5( TRIM( HEX_DECODE_STRING( e.EMPLOYEE_PID))) NOT IN ('07eaad40608dee87230752347b2d29f4','bbb8aae57c104cda40c93843ad5e6db8','a19a654c4403b86cb0c437097ff04466',
									 '77c9749b451ab8c713c48037ddfbb2c4','9e4524c2628490392f0db89f7487b3da')
			AND NVL( UPPER( TRIM( e.EMPLOYEE_FIRST_NAME)),'TEST') <> 'TEST' AND NVL( UPPER( TRIM( e.EMPLOYEE_LAST_NAME)),'TEST') <> 'TEST'
			AND NVL( UPPER( TRIM( e.EMPLOYEE_FIRST_NAME)),'PAYSTUB') NOT LIKE '%PAYSTUB%' AND NVL( UPPER( TRIM( e.EMPLOYEE_LAST_NAME)),'PAYSTUB') NOT LIKE '%PAYSTUB%'
--			AND MD5( TRIM( HEX_DECODE_STRING( EMPLOYEE_PID))) IN ('eac3c28f0271b47fd8a9b50f696a5675')
	),
	EFFECTIVE_DATES AS
	(
		SELECT DISTINCT upid.*,
			CASE WHEN e.SOURCE_SYSTEM_ID = 5
					THEN COALESCE( COALESCE( NULLIF( e.EMPLOYEE_HIRE_DATE, '1900-01-01'), NULLIF( gpe.HIRE_DATE, '1900-01-01')), NULLIF( gpe.FIRST_CHECK_DATE, '1900-01-01'))
				 WHEN e.SOURCE_SYSTEM_ID IN (1,2)
					THEN COALESCE( COALESCE( NULLIF( e.EMPLOYEE_HIRE_DATE, '1900-01-01'), NULLIF( gpc.HIRE_DATE, '1900-01-01')), NULLIF( gpc.FIRST_CHECK_DATE, '1900-01-01'))
				 WHEN e.SOURCE_SYSTEM_ID = 4
				 	THEN COALESCE( NULLIF( e.EMPLOYEE_HIRE_DATE, '1900-01-01'), NULLIF( tpe.EMPLOYEE_HIRE_DATE, '1900-01-01'), NULLIF( sds.SOE, '1900-01-01'))
				 ELSE NULL END
				AS EffectiveDateTime_HireDate,
			CASE WHEN NULLIF( sds.REHIREDATE, '1900-01-01') = NULLIF( e.EMPLOYEE_HIRE_DATE, '1900-01-01') THEN NULL
				 WHEN NULLIF( e.EMPLOYEE_REHIRE_DATE, '1900-01-01') = DATEADD( DAY, 1, NULLIF( e.EMPLOYEE_TERMINATE_DATE, '1900-01-01')) THEN NULL
				 WHEN e.SOURCE_SYSTEM_ID IN (1,2,5)
					THEN NULLIF( e.EMPLOYEE_REHIRE_DATE, '1900-01-01')
				 WHEN e.SOURCE_SYSTEM_ID = 4
				 	THEN COALESCE( NULLIF( e.EMPLOYEE_REHIRE_DATE, '1900-01-01'), NULLIF( tpe.EMPLOYEE_REHIRE_DATE, '1900-01-01'),  NULLIF( sds.REHIREDATE, '1900-01-01'))
				 ELSE NULL END
				AS EffectiveDateTime_RehireDate,
			CASE WHEN NULLIF( sds.REHIREDATE, '1900-01-01') = DATEADD( DAY, 1, NULLIF( e.EMPLOYEE_TERMINATE_DATE, '1900-01-01')) THEN NULL
				 WHEN e.SOURCE_SYSTEM_ID = 5 AND e.ACTIVE_EMPLOYEE_FLAG = FALSE
					THEN COALESCE( NVL( NVL( NULLIF( e.EMPLOYEE_TERMINATE_DATE, '1900-01-01'), NULLIF( gpe.TERMINATE_DATE, '1900-01-01')), NULLIF( gpe.LAST_CHECK_DATE, '1900-01-01')), NULLIF( gpe.LAST_DAY_WORKED, '1900-01-01'))
				 WHEN e.SOURCE_SYSTEM_ID IN (1,2) AND e.ACTIVE_EMPLOYEE_FLAG = FALSE
					THEN COALESCE( NVL( NVL( NULLIF( e.EMPLOYEE_TERMINATE_DATE, '1900-01-01'), NULLIF( gpc.TERMINATE_DATE, '1900-01-01')), NULLIF( gpc.LAST_CHECK_DATE, '1900-01-01')), NULLIF( gpc.LAST_DAY_WORKED, '1900-01-01'))
				 WHEN e.SOURCE_SYSTEM_ID = 4 AND e.ACTIVE_EMPLOYEE_FLAG = FALSE
				 	THEN COALESCE( NULLIF( e.EMPLOYEE_TERMINATE_DATE, '1900-01-01'), NULLIF( tpe.EMPLOYEE_TERMINATE_DATE, '1900-01-01'), NULLIF( sds.EOE, '1900-01-01'))
				 ELSE NULL END
				AS EffectiveDateTime_TermDate,
			CASE WHEN (EffectiveDateTime_RehireDate < '2020-06-15'::DATE OR EffectiveDateTime_HireDate < '2020-06-15'::DATE)
					AND NVL( EffectiveDateTime_TermDate, CURRENT_DATE()) >= '2020-06-15'
					THEN 'Y'
					ELSE NULL END
				AS ACAempCatCode_FLAG
		FROM UNIQUE_PID upid
		LEFT OUTER JOIN DW_PROD.HAH.DIM_EMPLOYEE e
			ON upid.EMPLOYEE_KEY = e.EMPLOYEE_KEY
		LEFT OUTER JOIN DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE gpe
			ON e.SOURCE_SYSTEM_ID = 5 AND e.SYSTEM_CODE = TRIM( gpe.DB) AND e.EMPLOYEE_NUMBER = TRIM( gpe.EMPLOYEE_ID)
		LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.GPALLEMPLOYEESBASE gpc
			ON e.SOURCE_SYSTEM_ID IN (1,2) AND e.SYSTEM_CODE = TRIM( gpc.DB) AND TRIM( e.EMPLOYEE_ID) = TRIM( gpc.EMPLOYEE_ID)
		LEFT OUTER JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS sds
			ON e.SOURCE_SYSTEM_ID = 4 AND e.SYSTEM_CODE = '8485' AND sds.AGENCYID = '8485'
				AND e.Employee_Number = NULLIF( sds.STAFFAGENCYID,'')::INTEGER
		LEFT OUTER JOIN (SELECT * FROM DISC_PROD.TRUSTPOINTDATA.EMPLOYEES WHERE TRIM( COMPANY) = 'EXCEL') tpe
			ON e.SOURCE_SYSTEM_ID = 4 AND e.SYSTEM_CODE = '8485'
				AND e.Employee_Number = tpe.EMPLOYEE_NUMBER::INTEGER
	),
	ADDRESS AS
---- where we're missing address 1, city, state, or zip, we replace with Chicago corporate address ----
	(
		(
		 SELECT e.SOURCE_SYSTEM_ID, TRIM( e.SYSTEM_CODE) AS SYSTEM_CODE, TRIM( e.EMPLOYEE_ID) AS EMPLOYEE_ID,
			CASE WHEN TRIM( NVL( gpe.Address1,'')) = '' OR TRIM( NVL( gpe.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS1 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE REGEXP_REPLACE( 
       				UPPER( TRIM( SUBSTRING ( gpe.Address1, 0, 75))),
       				'\\,|','')			-- removing commas
       			END AS HomeAddressLine1,
       		CASE WHEN TRIM( NVL( gpe.Address1,'')) = '' OR TRIM( NVL( gpe.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS1 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE REGEXP_REPLACE( 
       				UPPER( TRIM( SUBSTRING ( gpe.Address2 || ' ' || gpe.Address3, 0, 75))),
       				'\\,|\\-|\\@|\\+|\\=','')			-- removing commas
       			END AS HomeAddressLine2,
       		CASE WHEN TRIM( NVL( gpe.Address1,'')) = '' OR TRIM( NVL( gpe.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS1 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE SUBSTRING( gpe.City, 1, 40)
       			END AS HomeAddressCity,
       		CASE WHEN TRIM( NVL( gpe.Address1,'')) = '' OR TRIM( NVL( gpe.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_STATE_CODE FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE UPPER( e.EMPLOYEE_STATE_CODE)
				END AS HomeAddressState,
			CASE WHEN TRIM( NVL( gpe.Address1,'')) = '' OR TRIM( NVL( gpe.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ZIP FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE e.EMPLOYEE_ZIP 
				END AS HomeAddressZip
       	 FROM DW_PROD.HAH.DIM_EMPLOYEE e
       	 LEFT OUTER JOIN DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE gpe
			ON e.SOURCE_SYSTEM_ID = 5 AND e.SYSTEM_CODE = TRIM( gpe.DB) AND e.EMPLOYEE_NUMBER = TRIM( gpe.EMPLOYEE_ID)
       	 WHERE e.SOURCE_SYSTEM_ID = 5
       	) UNION ALL (
       	 SELECT e.SOURCE_SYSTEM_ID, TRIM( e.SYSTEM_CODE) AS SYSTEM_CODE, TRIM( e.EMPLOYEE_ID) AS EMPLOYEE_ID,
			CASE WHEN TRIM( NVL( gpc.Address1,'')) = '' OR TRIM( NVL( gpc.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS1 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE REGEXP_REPLACE( 
       				UPPER( TRIM( SUBSTRING ( gpc.Address1, 0, 75))),
       				'\\,|','')			-- removing commas
       			END AS HomeAddressLine1,
       		CASE WHEN TRIM( NVL( gpc.Address1,'')) = '' OR TRIM( NVL( gpc.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS1 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE REGEXP_REPLACE( 
       				UPPER( TRIM( SUBSTRING ( gpc.Address2 || ' ' || gpc.Address3, 0, 75))),
      				'\\,|\\-|\\@|\\+|\\=','')			-- removing commas
       			END AS HomeAddressLine2,
       		CASE WHEN TRIM( NVL( gpc.Address1,'')) = '' OR TRIM( NVL( gpc.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS1 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE SUBSTRING( gpc.City, 1, 40)
       			END AS HomeAddressCity,
       		CASE WHEN TRIM( NVL( gpc.Address1,'')) = '' OR TRIM( NVL( gpc.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_STATE_CODE FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE UPPER( e.EMPLOYEE_STATE_CODE)
				END AS HomeAddressState,
			CASE WHEN TRIM( NVL( gpc.Address1,'')) = '' OR TRIM( NVL( gpc.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ZIP FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE e.EMPLOYEE_ZIP 
				END AS HomeAddressZip
       	 FROM DW_PROD.HAH.DIM_EMPLOYEE e
       	 LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.GPALLEMPLOYEESBASE gpc
			ON e.SOURCE_SYSTEM_ID IN (1,2) AND e.SYSTEM_CODE = TRIM( gpc.DB) AND TRIM( e.EMPLOYEE_ID) = TRIM( gpc.EMPLOYEE_ID)
       	 WHERE e.SOURCE_SYSTEM_ID IN (1,2)
       	) UNION ALL (
         SELECT e.SOURCE_SYSTEM_ID, TRIM( e.SYSTEM_CODE) AS SYSTEM_CODE, TRIM( e.EMPLOYEE_ID) AS EMPLOYEE_ID,
         	CASE WHEN TRIM( NVL( sds.Address,'')) = '' OR TRIM( NVL( sds.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS1 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE REGEXP_REPLACE( 
	       			UPPER( TRIM( SUBSTRING ( NVL( tpe.EMPLOYEE_ADDRESS1, sds.Address), 0, 75))),
	       			'\\,|','')	-- removing commas
	       		END AS HomeAddressLine1,
			CASE WHEN TRIM( NVL( sds.Address,'')) = '' OR TRIM( NVL( sds.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ADDRESS2 FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE REGEXP_REPLACE( 
	       			UPPER( TRIM( SUBSTRING ( NVL( tpe.EMPLOYEE_ADDRESS2, sds.Address2 || ' ' || sds.AptNo), 0, 75))),
	       			'\\,|\\-|\\@|\\+|\\=','')	-- removing commas
	       		END AS HomeAddressLine2,
			CASE WHEN TRIM( NVL( sds.Address,'')) = '' OR TRIM( NVL( sds.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_CITY FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE SUBSTRING( NVL( tpe.EMPLOYEE_CITY, sds.City), 1, 40)
				END AS HomeAddressCity,
			CASE WHEN TRIM( NVL( sds.Address,'')) = '' OR TRIM( NVL( sds.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_STATE_CODE FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE UPPER( NVL( tpe.EMPLOYEE_STATE_CODE, e.EMPLOYEE_STATE_CODE))
				END AS HomeAddressState,
			CASE WHEN TRIM( NVL( sds.Address,'')) = '' OR TRIM( NVL( sds.City,'')) = '' OR TRIM( NVL( e.EMPLOYEE_STATE_CODE,'')) = '' OR TRIM( NVL( e.EMPLOYEE_ZIP,'')) = '' OR LEN( e.EMPLOYEE_ZIP) IN (1,2,3,4,6,8)
					THEN (SELECT DISTINCT OFFICE_ZIP FROM DW_PROD.HAH.DIM_BRANCH WHERE OFFICE_NUMBER = '0')
				 ELSE NVL( tpe.EMPLOYEE_ZIP, e.EMPLOYEE_ZIP::VARCHAR)
				END AS HomeAddressZip
         FROM DW_PROD.HAH.DIM_EMPLOYEE e
       	 LEFT OUTER JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS sds
			ON e.SOURCE_SYSTEM_ID = 4 AND e.SYSTEM_CODE = '8485' AND sds.AGENCYID = '8485'
				AND NULLIF( sds.STAFFAGENCYID,'')::INTEGER = e.Employee_Number
		 LEFT OUTER JOIN (SELECT * FROM DISC_PROD.TRUSTPOINTDATA.EMPLOYEES WHERE TRIM( COMPANY) = 'EXCEL') tpe
		 	ON e.SOURCE_SYSTEM_ID = 4 AND e.SYSTEM_CODE = '8485' AND e.EMPLOYEE_ID::INTEGER = tpe.ID::INTEGER
       	 WHERE e.SOURCE_SYSTEM_ID = 4
       	)
	),
	PAYROLL_DATES AS
	(
		SELECT SOURCE_SYSTEM_ID, TRIM( SYSTEM_CODE) AS SYSTEM_CODE, TRIM( EMPLOYEE_ID) AS EMPLOYEE_ID,
			NVL( MIN( PAYROLL_DATE), MIN( PAY_PERIOD_END_DATE)) AS FIRST_PAYROLL_DATE
		FROM DW_PROD.HAH.FACT_PAYROLL
		WHERE SOURCE_SYSTEM_ID IN (1,2,4,5)
		GROUP BY 1,2,3
	)
	SELECT DISTINCT
		up.EmployeeUniqueIdentifier,								-- Hashed SSN
		'CG1' AS ControlledGroupCode,								-- Need value from Equifax/HR
		CASE WHEN TransactionType = 'HIR' AND (EffectiveDateTime IS NULL OR EffectiveDateTime > pd.FIRST_PAYROLL_DATE)
				THEN pd.FIRST_PAYROLL_DATE							-- Making sure hire isn't after first payroll
			 ELSE EffectiveDateTime END
			AS EffectiveDateTime,									-- Hire, Rehire, or Term date
		CASE WHEN TRIM( e.SYSTEM_CODE) = '8485' THEN 'EXCEL' ELSE TRIM( e.SYSTEM_CODE) END AS DataSource,							-- Source system
		'No' AS IsInvalid,											-- There will be separate process for invalidating records
		TransactionType,											-- Indicates type of record
		COALESCE( HEX_DECODE_STRING( e.EMPLOYEE_PID), NULLIF( TRIM( gpe.SSN),''), NULLIF( TRIM( gpc.SSN),''), NULLIF( TRIM( tpe.EMPLOYEE_SSN),''), NULLIF( TRIM( sds.SSN),'')) AS SSN_COAL,
		CASE WHEN gpe.INACTIVE = 0 THEN 'A'
			 WHEN gpc.INACTIVE = 0 THEN 'A'
			 WHEN UPPER( tpe.ACTIVE_EMPLOYEE_FLAG) = 'TRUE' THEN 'A'
			 WHEN e.ACTIVE_EMPLOYEE_FLAG = FALSE THEN 'T'
			 ELSE 'A' END
			AS Status,												-- Active/Terminated/Inactive
		UPPER( e.EMPLOYEE_FIRST_NAME) AS FirstName,
		UPPER( e.EMPLOYEE_LAST_NAME) AS LastName,
		UPPER( e.EMPLOYEE_MIDDLE_NAME) AS MiddleName,
		UPPER( e.EMPLOYEE_SUFFIX) AS Suffix,
		CASE WHEN e.EMPLOYEE_ADDRESS1 IS NULL OR e.EMPLOYEE_STATE_CODE IS NULL OR e.EMPLOYEE_ZIP IS NULL THEN NVL( tpe.EMPLOYEE_ADDRESS1, ad.HomeAddressLine1) ELSE UPPER( e.EMPLOYEE_ADDRESS1) END AS HomeAddressLine1,
		CASE WHEN e.EMPLOYEE_ADDRESS1 IS NULL AND e.EMPLOYEE_STATE_CODE IS NULL AND e.EMPLOYEE_ZIP IS NULL THEN NVL( tpe.EMPLOYEE_ADDRESS2, ad.HomeAddressLine2) ELSE UPPER( e.EMPLOYEE_ADDRESS2) END AS HomeAddressLine2,
		CASE WHEN e.EMPLOYEE_ADDRESS1 IS NULL OR e.EMPLOYEE_STATE_CODE IS NULL OR e.EMPLOYEE_ZIP IS NULL THEN NVL( tpe.EMPLOYEE_CITY, ad.HomeAddressCity) ELSE UPPER( e.EMPLOYEE_CITY) END AS HomeAddressCity,
		CASE WHEN e.EMPLOYEE_ADDRESS1 IS NULL OR e.EMPLOYEE_STATE_CODE IS NULL OR e.EMPLOYEE_ZIP IS NULL THEN NVL( tpe.EMPLOYEE_STATE_CODE, ad.HomeAddressState) ELSE UPPER( e.EMPLOYEE_STATE_CODE) END AS HomeAddressState,
		CASE WHEN e.EMPLOYEE_ADDRESS1 IS NULL OR e.EMPLOYEE_STATE_CODE IS NULL OR e.EMPLOYEE_ZIP IS NULL THEN NVL( tpe.EMPLOYEE_ZIP, ad.HomeAddressZip) ELSE UPPER( e.EMPLOYEE_ZIP) END AS HomeAddressZIP,
		'US' AS HomeAddressCountry,								-- All employees are based in US
		CASE WHEN e.EMPLOYEE_CATEGORY = 'Field' THEN 'V' ELSE 'FT' END
			AS ACAEmployeeDesignationCode,						-- Admin = Full Time; Field = Variable
		up.ACAEmployeeCategoryCode,						-- EC1/EC2
		COALESCE( NULLIF( e.EMPLOYEE_DOB,'1900-01-01'), tpe.EMPLOYEE_DOB) AS DateOfBirth,							-- Will need to address blank DOBs
		up.EmployeeUniqueIdentifier AS UserID,					-- Inserting unique ID because employees will not be using
		RIGHT( '0000000'||ROW_NUMBER() OVER( ORDER BY up.EmployeeUniqueIdentifier), 8)::VARCHAR AS DefaultPIN,
		NULL AS AdjustedHireDate,								-- Hard coded NULL as we're not using service requiring this field
		NULL AS WorkNumberDivision,								-- Hard coded NULL as we're not using service requiring this field
		COALESCE( NULLIF( e.EMPLOYEE_WORK_EMAIL,''), NULLIF( e.EMPLOYEE_PERSONAL_EMAIL,'')) AS EmailAddress,
		COALESCE(NULLIF( NULLIF( REPLACE( REPLACE( REGEXP_REPLACE( TRIM( gpe.Phone_Number), '\\-|\\)|\\(|',''),' ',''),'O','0'), '0000000000'), ''),
				 NULLIF( NULLIF( REPLACE( REPLACE( REGEXP_REPLACE( TRIM( gpe.Phone_Number_2), '\\-|\\)|\\(|',''),' ',''),'O','0'), '0000000000'), ''),
				 NULLIF( NULLIF( REPLACE( REPLACE( REGEXP_REPLACE( TRIM( gpc.Phone_Number), '\\-|\\)|\\(|',''),' ',''),'O','0'), '0000000000'), ''),
				 NULLIF( NULLIF( REPLACE( REPLACE( REGEXP_REPLACE( TRIM( gpc.Phone_Number_2), '\\-|\\)|\\(|',''),' ',''),'O','0'), '0000000000'), ''),
				 NULLIF( NULLIF( REPLACE( REPLACE( REGEXP_REPLACE( TRIM( sds.HomePhone), '\\-|\\)|\\(|',''),' ',''),'O','0'), '0000000000'), ''),
				 NULLIF( NULLIF( REPLACE( REPLACE( REGEXP_REPLACE( TRIM( sds.WorkPhone), '\\-|\\)|\\(|',''),' ',''),'O','0'), '0000000000'), ''),
				 NULLIF( NULLIF( REPLACE( REPLACE( REGEXP_REPLACE( TRIM( sds.MobilePhone), '\\-|\\)|\\(|',''),' ',''),'O','0'), '0000000000'), '')
				 )
			AS PrimaryPhoneNumber
	FROM (
		  (SELECT EmployeeUniqueIdentifier, EMPLOYEE_KEY, EffectiveDateTime_HireDate AS EffectiveDateTime, 'HIR' AS TransactionType,
		  		CASE WHEN EffectiveDateTime_HireDate < '2020-06-15'::DATE THEN 'EC1' ELSE 'EC2' END AS ACAEmployeeCategoryCode
		  	FROM EFFECTIVE_DATES WHERE EffectiveDateTime_HireDate IS NOT NULL AND EffectiveDateTime_HireDate < CURRENT_DATE()) UNION ALL
		  (SELECT EmployeeUniqueIdentifier, EMPLOYEE_KEY, EffectiveDateTime_REhireDate AS EffectiveDateTime, 'RHR' AS TransactionType,
				CASE WHEN NVL( EffectiveDateTime_RehireDate,'2020-06-15') < '2020-06-15'::DATE THEN 'EC1' ELSE 'EC2' END AS ACAEmployeeCategoryCode
		  	FROM EFFECTIVE_DATES WHERE EffectiveDateTime_RehireDate IS NOT NULL AND EffectiveDateTime_RehireDate < CURRENT_DATE()
		  							AND DATEADD( DAY, 1, EffectiveDateTime_TermDate::DATE) < EffectiveDateTime_RehireDate AND EffectiveDateTime_TermDate IS NOT NULL) UNION ALL
		  (SELECT EmployeeUniqueIdentifier, EMPLOYEE_KEY, DATEADD( DAY, 1, EffectiveDateTime_TermDate::DATE) AS EffectiveDateTime, 'TER' AS TransactionType,
				CASE WHEN EffectiveDateTime_TermDate < '2020-06-15'::DATE THEN 'EC1' ELSE 'EC2' END AS ACAEmployeeCategoryCode
		  	FROM EFFECTIVE_DATES WHERE EffectiveDateTime_TermDate IS NOT NULL AND EffectiveDateTime_TermDate < CURRENT_DATE()) UNION ALL
		  (SELECT EmployeeUniqueIdentifier, EMPLOYEE_KEY, '2020-06-15'::DATE AS EffectiveDateTime, 'JOB' AS TransactionType,
		  		'EC2' AS ACAEmployeeCategoryCode
		  	FROM EFFECTIVE_DATES WHERE EffectiveDateTime_HireDate < '2020-06-15'::DATE
		  							AND (EffectiveDateTime_TermDate > '2020-06-15'::DATE OR NULLIF( EffectiveDateTime_TermDate, '1900-01-01') IS NULL)
		  							AND (NULLIF( EffectiveDateTime_RehireDate,'1900-01-01') IS NULL OR EffectiveDateTime_RehireDate <> '2020-06-15'::DATE))
		 ) up
	LEFT OUTER JOIN DW_PROD.HAH.DIM_EMPLOYEE e
		ON up.EMPLOYEE_KEY = e.EMPLOYEE_KEY
	LEFT OUTER JOIN DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE gpe
		ON e.SOURCE_SYSTEM_ID = 5 AND e.SYSTEM_CODE = TRIM( gpe.DB) AND e.EMPLOYEE_NUMBER = TRIM( gpe.EMPLOYEE_ID)
	LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.GPALLEMPLOYEESBASE gpc
		ON e.SOURCE_SYSTEM_ID IN (1,2)
			AND CASE WHEN TRIM( e.SYSTEM_CODE) = 'SHC_SAVANNAH' THEN 'SHC'
					 WHEN TRIM( e.SYSTEM_CODE) = 'SHC_ALTRUS' THEN 'ALTRU'
					 ELSE TRIM( e.SYSTEM_CODE) END
				= TRIM( gpc.DB) AND TRIM( e.EMPLOYEE_ID) = TRIM( gpc.EMPLOYEE_ID)
	LEFT OUTER JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS sds
		ON e.SOURCE_SYSTEM_ID = 4 AND e.SYSTEM_CODE = '8485' AND sds.AGENCYID = '8485'
			AND NULLIF( sds.STAFFAGENCYID,'')::INTEGER = e.Employee_Number
	LEFT OUTER JOIN (SELECT * FROM DISC_PROD.TRUSTPOINTDATA.EMPLOYEES WHERE TRIM( COMPANY) = 'EXCEL') tpe
		ON e.SOURCE_SYSTEM_ID = 4 AND e.SYSTEM_CODE = '8485'
			AND e.Employee_Number = tpe.EMPLOYEE_NUMBER::INTEGER
	LEFT OUTER JOIN ADDRESS ad
		ON e.SOURCE_SYSTEM_ID = ad.SOURCE_SYSTEM_ID AND TRIM( e.SYSTEM_CODE) = ad.SYSTEM_CODE AND TRIM( e.EMPLOYEE_ID) = ad.EMPLOYEE_ID
	LEFT OUTER JOIN PAYROLL_DATES pd
		ON e.SOURCE_SYSTEM_ID = pd.SOURCE_SYSTEM_ID AND TRIM( e.SYSTEM_CODE) = pd.SYSTEM_CODE AND TRIM( e.EMPLOYEE_ID) = pd.EMPLOYEE_ID
) Equifax
LEFT OUTER JOIN (SELECT s.$3, s.$6 FROM @DW_DEV.Stage.AZStage/CSV_Files/HAH_Emails_SISCO_20201006 (file_format => DW_DEV.PUBLIC.CSV_Format) s
				 WHERE s.$6 IS NOT NULL AND s.$6 NOT LIKE '%\\_@%' ESCAPE '\\') s
	ON SSN_COAL = TRIM( s.$3)
LEFT OUTER JOIN DATA_MANAGEMENT.DATA_QUALITY.INVALID_SSN DQSSN
	ON Equifax.SSN_COAL = DQSSN.SSN
LEFT OUTER JOIN DATA_MANAGEMENT.DATA_QUALITY.INVALID_PHONE_NUMBER DQPN
	ON Equifax.PrimaryPhoneNumber = DQPN.PHONE_NUMBER
--INNER JOIN @DW_DEV.Stage.AZStage/CSV_Files/EQUIFAX/Equifax_EmpsNoAddress_20210211 (file_format => DW_DEV.PUBLIC.CSV_Format) noAdd
--	ON Equifax.EmployeeUniqueIdentifier = TRIM( noAdd.$6)
WHERE (LASTNAME IS NOT NULL OR FIRSTNAME IS NOT NULL)
	AND TRIM( SSN_COAL) NOT IN ('000000000','123456789')
	AND DQSSN.SSN IS NULL
--	AND (NULLIF( HomeAddressLine1,'') IS NULL OR NULLIF( HomeAddressCity,'') IS NULL OR NULLIF( HomeAddressState,'') IS NULL OR NULLIF( HomeAddressZip,'') IS NULL)
--	AND (UPPER( TRIM( LastName)) LIKE '%FEIL%' AND UPPER( TRIM( FirstName)) LIKE '%JANA%')
--	AND "EmployeeUniqueIdentifier" IN ('d7f695c1d7cd5b9d9e048e5507e64c35')
--) --GROUP BY 1 ORDER BY 1
--) WHERE "DateOfBirth" IS NULL
;
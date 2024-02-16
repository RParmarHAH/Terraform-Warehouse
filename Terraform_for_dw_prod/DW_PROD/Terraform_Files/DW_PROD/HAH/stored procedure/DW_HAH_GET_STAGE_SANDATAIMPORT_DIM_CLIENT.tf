resource "snowflake_procedure" "DW_HAH_GET_STAGE_SANDATAIMPORT_DIM_CLIENT" {
	name ="GET_STAGE_SANDATAIMPORT_DIM_CLIENT"
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
-- NAME:  SANDATAIMPORT_DIM_CLIENT
--
-- PURPOSE: Creates one row per client according to Sandata
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 02/13/20     Rachel Stewart         Initial Development
-- 03/18/20     Frank Noordover      Updated for Production rollout
-- 05/11/20     Frank Noordover      Updated logic for PID, DOB, Gender and Address
-- 06/15/20		Mir Ali				 Updated VISIT cte to use Fact_Visit + confirmed visits only
-- 21/12/20		Shraddha Sejpal		 Created hold_status cte to populate on_hold flag and cast nulls
-- 07/04/21     Prateek Bhatt		 Change DDL for DIM_CLIENT_DK and Cast nulls
-- 07/07/21		Mir Ali				 Added new attributes including email, fax number, salutation, and marital status
-- 02/10/23     Mirisha              Leveraged Dedupe
-- 07/27/23    DEEPEN GAJJAR         ADDED REFERRER KEY FIELD
-- 11/08/2023 Trushali Ramoliya      Added the column for HISPANIC_OR_LATINO and also updated the logic for ethnicity as per IDDOX - 388
-- 11/20/23    Sandesh	Gosavi      Added CLIENT_STATUS Field
-- 11/21/2023  Sandesh Gosavi       ADDED A LOGIC AND COLUMN FOR DISCHARGE_REASON
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.SANDATAIMPORT_DIM_CLIENT
WITH VISIT AS (
    SELECT
        F.SYSTEM_CODE AS AGENCYID,
        F.CLIENT_NUMBER AS CLIENTID,
        MAX(F.SERVICE_DATE) AS LAST_TIMEOUT,
        MIN(F.SERVICE_DATE) AS FIRST_TIMEIN,
        MAX(F.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
    FROM HAH.FACT_VISIT F
	WHERE F.SYSTEM_CODE = ''8485'' AND F.CONFIRMED_FLAG=''YES''
-- F.STATUS_CODE IN (''02'', ''03'',''04'', ''05'')
    GROUP BY 1,2
), CLIENT_REFERRALS AS (
	WITH master AS (
	--master query
		WITH fin AS (
		SELECT DISTINCT cl.AGENCYID ,cl.master_id,
		cl.CLIENTID ,
		first_value(cad.ADMISSIONSTATUS) OVER (PARTITION BY cl.CLIENTID ORDER BY iff(cad.ADMISSIONSTATUS =''02'',0,1)) AS adstatus, 
		first_value(cad.REFERRALSOURCEID) OVER (PARTITION BY cl.CLIENTID ORDER BY iff(cad.ADMISSIONSTATUS =''02'',0,1)) AS adref, 
		first_value(cad.REFERRALSOURCEID) OVER (PARTITION BY cl.CLIENTID ORDER BY cad.STATUSASOFDATE DESC , iff(cad.REFERRALSOURCEID <>0,0,1)) AS refval 
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.SANDATAIMPORT.CLIENT_MASTER_LIST cl
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS cad ON 
		cad.CLIENTID =cl.CLIENTID AND cl.AGENCYID = cad.AGENCYID 
		WHERE cl.AGENCYID =''8485''
		--AND cl.clientid = ''1311''
		)
		SELECT a.master_id ,a.clientid, cc.CLIENT_NAME , iff(rf.LASTNAME='''',NULL,rf.LASTNAME ) referral,
        md5(rf.AGENCYID||''-''||rf.REFERRALID||''-''||''SANDATAIMPORT'') as REFERRER_KEY
		FROM fin a
		-- due to multiple client admissions we are giving prioroty to Active (02) first, and if adstatus <> 02 then giving prioroty to latest status as of date admission
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_REFERRALSOURCES rf ON rf.REFERRALID =iff(a.adstatus=''02'',a.adref, a.refval)
		LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT cc ON a.clientid = cc.CLIENT_NUMBER  AND cc.SYSTEM_CODE =''8485''
	)
SELECT 
MASTER_ID, CLIENTID,REFERRAL AS REFERRALS,REFERRER_KEY
FROM MASTER
WHERE REFERRAL IS NOT NULL
),
--added by mohan kewlani on 10-21-2022
 CA_PHW AS  (
SELECT IFF(ADMISSIONTYPE=''PHW'',1,2) AS TOD,*
FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS WHERE AGENCYID=8485)
,
CA_CMB AS (
SELECT ROW_NUMBER() OVER (PARTITION BY T.CLIENTID ORDER BY TOD,MRN) AS RNUM,
		T.CLIENTID,
        T.AGENCYID,
        T.TOD,
        T.ADMISSIONTYPE,
        FIRST_VALUE(IFF(LENGTH (T.MRN)>0 ,LPAD(trim(t.MRN,''~''),10,''0''),'''')) OVER (PARTITION BY T.CLIENTID  ORDER BY T.TOD ASC,T.UPDATEDAT DESC) MRN,
        T.ROC AS ROC,
        t.SOC AS SOC,
		T.UPDATEDAT as UPDATEDAT,
        T.ID AS ID FROM CA_PHW T
       
        ) ,
 serv as (SELECT    
      	t.CLIENTID,
      	t.AGENCYID,
      	MIN(t.ROC) AS ROC,
     	MIN(t.SOC) AS SOC,
		MIN(t.MRN) AS MRN,
    	MAX(T.UPDATEDAT) as UPDATEDAT,
    	MAX(T.ID) AS max_ID     
      	FROM CA_CMB   t
      	GROUP BY t.CLIENTID,
     			 t.AGENCYID),
     
--serv as (
 --   SELECT
   --     t.CLIENTID,
    --    t.AGENCYID,
    --    MIN(t.ROC) AS ROC,
    --    MIN(t.SOC) AS SOC,
	--	MIN(t.MRN) AS MRN,
     --   MAX(UPDATEDAT) as UPDATEDAT,
     --   MAX(ID) AS max_ID
   -- FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS t
   -- WHERE t.AGENCYID = 8485
   -- GROUP BY 1, 2
  --  ),
CLIENT_STATUS AS 
(SELECT DISTINCT CLIENTID  ,TRIM(ADMISSIONSTATUS) AS ADMISSIONSTATUS ,TRIM(ADMISSIONSTATUS2) AS ADMISSIONSTATUS2,ADMISSIONID , 
ROW_NUMBER() OVER (PARTITION BY CLIENTID ORDER BY ADMISSIONID desc) Rank  
FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS WHERE  AGENCYID =8485 
QUALIFY RANK =1) , 																															   
hold_status AS (
   SELECT * FROM (SELECT 
    a.CLIENTID,
    a.AGENCYID,
    a.ADMISSIONSTATUS AS STATUS_CODE,
    ETL_LAST_UPDATED_DATE,
    ROW_NUMBER() OVER (PARTITION BY CLIENTID ORDER BY ETL_LAST_UPDATED_DATE DESC) AS RN
   FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS a 
   WHERE a.AGENCYID = 8485) WHERE RN=1
  ),
coord as (
    SELECT
        t.CLIENTID,
        t.AGENCYID,
        MAX(nvl(Coordinators.STAFFID::string, ''Unknown-'' || nvl(t.agencyID,''S''))) AS CURRENT_SUPERVISOR_CODE,
        MAX(TO_CHAR(Coordinators.LASTNAME) || '', '' || TO_CHAR(Coordinators.FIRSTNAME) || '' '' || TO_CHAR(Coordinators.MIDDLEINITIAL)) AS CURRENT_SUPERVISOR_NAME
    FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS t
    INNER JOIN serv s
        on t.CLIENTID = s.CLIENTID
        and t.AGENCYID = s.AGENCYID
        and t.ID = s.max_ID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_STAFFS Coordinators
        ON Coordinators.agencyID = t.agencyID
        AND Coordinators.staffID = t.CoordinatorID
    WHERE t.AGENCYID = 8485
    GROUP BY 1,2
    )
SELECT
     md5(C.AGENCYID || ''-'' || C.MASTER_ID || ''-''  ||  ''SANDATAIMPORT'' ) AS CLIENT_KEY
    ,C.CLIENTID AS CLIENT_NUMBER --BK
    ,C.AGENCYID AS SYSTEM_CODE  --SANDATAIMPORT??
    ,4 AS SOURCE_SYSTEM_ID
    ,md5( C.SSN) AS Client_PID	 
    , NULL AS CLIENT_MEDICARE_ID
	, serv.MRN AS MEDICAID_ID
    ,c.DOB AS Client_DOB
	,NULL CLIENT_DATE_OF_DEATH 
--    ,c.Sex AS Client_Gender
    ,CASE WHEN TRIM( c.Sex) = ''1'' THEN ''MALE''
          WHEN TRIM( c.Sex) = ''2'' THEN ''FEMALE''
          ELSE NULL
     END AS Client_Gender
     ,CASE WHEN UPPER( TRIM( c.Ethnicity)) = ''NONE'' OR TRIM( c.Ethnicity) = '''' OR c.Ethnicity IS NULL THEN NULL
			  WHEN TRIM( c.Ethnicity) LIKE ''Black%'' THEN UPPER(''Black or African American'')
			  WHEN TRIM( c.Ethnicity) LIKE ''White%'' THEN UPPER(''White'')
			  WHEN TRIM( c.Ethnicity) LIKE ''Asian%'' THEN UPPER(''Asian'')
			  WHEN TRIM( c.Ethnicity) LIKE ''Hispanic%'' THEN NULL
			  WHEN TRIM( c.Ethnicity) LIKE ''Indian%'' THEN UPPER(''Indian Sub-Continent or Pakistani'')
			  WHEN TRIM( c.Ethnicity) = ''American Indian or Alaskan Native (NHL)'' THEN UPPER(''American Indian or Alaska Native'')
			  WHEN TRIM( c.Ethnicity) = ''Native Hawaiian or Other Pacific Islander (NHL)'' THEN UPPER(''Native Hawaiian or other Pacific Islander'')
			  WHEN TRIM( c.Ethnicity) = ''Two or More Races (NHL)'' THEN UPPER(''Two or more'')
	--          ELSE TRIM( c.Ethnicity)
			  ELSE NULL
		 END AS Client_Ethnicity,
		 IFF(UPPER(TRIM(c.Ethnicity)) = ''HISPANIC OR LATINO'' ,TRUE , FALSE ) AS HISPANIC_OR_LATINO
--	,NULL CLIENT_ETHNICITY	  
		, NULL AS CLIENT_GENDER_IDENTITY -- NA
		, NULL AS CLIENT_SEXUAL_ORIENTATION -- NA
		, NULL AS CLIENT_RACE --NA
     ,NULLIF(TRIM(C.MARITAL), '''') AS CLIENT_MARITAL_STATUS
     ,CASE WHEN SEX = 1 THEN ''MR.'' 
			WHEN TRIM(NVL(C.TITLE, '''')) <> '''' AND TRY_CAST(C.TITLE AS INTEGER) IS NULL THEN UPPER(C.TITLE)
			WHEN SEX = 2 THEN ''MS.'' END AS CLIENT_SALUTATION
    ,c.FirstName AS Client_First_Name
    ,c.MiddleInitial AS Client_Middle_Name
    ,c.LastName AS Client_Last_Name
    ,TO_CHAR(C.LASTNAME) || '', '' || TO_CHAR(C.FIRSTNAME) || '' '' || TO_CHAR(C.MIDDLEINITIAL) AS CLIENT_NAME
    ,c.Address AS Client_Address1
    ,c.Address2 AS Client_Address2
    ,c.City AS Client_City
    ,CASE WHEN S.STATE_ISO_CODE IS NOT NULL THEN S.STATE_ISO_CODE ELSE ''PA'' END AS CLIENT_STATE_CODE
    ,c.Zip AS Client_Zip
	,NULL CLIENT_CLN_ADDRESS1
	,NULL CLIENT_CLN_ADDRESS2
	,NULL CLIENT_CLN_CITY
	,NULL CLIENT_CLN_STATE_CODE
	,NULL CLIENT_CLN_ZIP
	,NULL CLIENT_STD_ADDRESS1
	,NULL CLIENT_STD_ADDRESS2
	,NULL CLIENT_STD_CITY
	,NULL CLIENT_STD_STATE_CODE
	,NULL CLIENT_STD_ZIP
    ,c.HomePhone AS Client_Home_Phone
    ,c.MobilePhone AS Client_Cell_Phone
    ,c.WorkPhone AS Client_Work_Phone
    ,NULLIF(TRIM(C.FAX), '''') AS CLIENT_FAX_NUMBER
	,NULLIF(TRIM(C.EMAIL), '''') AS CLIENT_PERSONAL_EMAIL           
    ,serv.ROC  AS REFERRAL_DATE   
    ,datediff(day, serv.ROC, VISIT.FIRST_TIMEIN) AS DAYS_TO_SERVICE	
	,NULL CONTRACT_BEGIN_DATE     
	,NULL CONTRACT_END_DATE       
    ,VISIT.FIRST_TIMEIN AS FIRST_SERVICE_DATE
    ,COALESCE(VISIT.LAST_TIMEOUT,CASE WHEN VISIT.FIRST_TIMEIN < serv.SOC THEN VISIT.FIRST_TIMEIN ELSE serv.SOC END) AS LAST_SERVICE_DATE
    ,NULL AS BEGIN_DATE
    ,NULL AS END_DATE
    ,IFF (DATEDIFF(''day'',VISIT.LAST_TIMEOUT,CURRENT_DATE()) <= 30, ''TRUE'', ''FALSE'') AS ACTIVE_CLIENT_FLAG -- needs to change to look up last visit date
    --,CAST( NULL AS BOOLEAN) AS On_Hold_Flag
	,CASE TRIM(CA.ADMISSIONSTATUS) WHEN  ''01'' THEN ''REFERRAL''
			                       WHEN  ''02'' THEN ''ACTIVE''
			                       WHEN  ''03'' THEN ''HOLD''
			                       WHEN  ''04'' THEN ''DISCHARGED''
			                       WHEN  ''05'' THEN ''CANCELLED''
			                       ELSE NULL END AS CLIENT_STATUS												  
	,CASE WHEN CA.ADMISSIONSTATUS2 = ''01'' THEN ''Admmited to Hospital''
          WHEN CA.ADMISSIONSTATUS2 = ''02'' THEN ''Client Changed for Payor''
          WHEN CA.ADMISSIONSTATUS2 = ''03'' THEN ''non compliant''
          WHEN CA.ADMISSIONSTATUS2 = ''04'' THEN ''Lack of Progress''
          WHEN CA.ADMISSIONSTATUS2 = ''05'' THEN ''Admitted to Nursing Home''
          WHEN CA.ADMISSIONSTATUS2 = ''06'' THEN ''Care Completed''
          WHEN CA.ADMISSIONSTATUS2 = ''07'' THEN ''MD Ordered Discharge''
          WHEN CA.ADMISSIONSTATUS2 = ''08'' THEN ''Patient Expired''
          WHEN CA.ADMISSIONSTATUS2 = ''09'' THEN ''Goals met''
          WHEN CA.ADMISSIONSTATUS2 = ''10'' THEN ''Transferred to Another Agency''
          WHEN CA.ADMISSIONSTATUS2 = ''11'' THEN ''Patient Request''
          WHEN CA.ADMISSIONSTATUS2 = ''12'' THEN ''No Longer Eligible for Service''
          WHEN CA.ADMISSIONSTATUS2 = ''13'' THEN ''Transferred to Hospice''
          WHEN CA.ADMISSIONSTATUS2 = ''14'' THEN ''Moved Out of Service Area''
          --
          WHEN CA.ADMISSIONSTATUS2 = ''D01'' THEN ''Client - Admitted to Long Term Care Facility''
          WHEN CA.ADMISSIONSTATUS2 = ''D02'' THEN ''Client - Changed Payor/Admission''
          WHEN CA.ADMISSIONSTATUS2 = ''D03'' THEN ''Field Staff - Non Compliant''
          WHEN CA.ADMISSIONSTATUS2 = ''D04'' THEN ''Lack of Progress''
          WHEN CA.ADMISSIONSTATUS2 = ''D06'' THEN ''Care Completed'' --NOT FOUND ON UI (?)
          WHEN CA.ADMISSIONSTATUS2 = ''D07'' THEN ''Payor - Billing Issues''
          WHEN CA.ADMISSIONSTATUS2 = ''D08'' THEN ''Client - DECEASED''
          WHEN CA.ADMISSIONSTATUS2 = ''D09'' THEN ''Client - 30 DAY NOTICE ISSUED''
          WHEN CA.ADMISSIONSTATUS2 = ''D10'' THEN ''SWITCHED AGENCIES''
          WHEN CA.ADMISSIONSTATUS2 = ''D11'' THEN ''Patient Request'' --NOT FOUND ON UI (?)
          WHEN CA.ADMISSIONSTATUS2 = ''D12'' THEN ''Payor - 4021- INELIGIBLE''
          WHEN CA.ADMISSIONSTATUS2 = ''D13'' THEN ''Transferred to Hospice'' --NOT FOUND ON UI (?)
          WHEN CA.ADMISSIONSTATUS2 = ''D14'' THEN ''Client - Moved Out of Service Area''
          WHEN CA.ADMISSIONSTATUS2 = ''D15'' THEN ''Operations - Unable to Staff''
          WHEN CA.ADMISSIONSTATUS2 = ''D16'' THEN ''Field Staff - EVV''
          WHEN CA.ADMISSIONSTATUS2 = ''D17'' THEN ''Payroll - Payment Issues''
          WHEN CA.ADMISSIONSTATUS2 = ''D18'' THEN ''Case Mgmt - Communication''
          WHEN CA.ADMISSIONSTATUS2 = ''D19'' THEN ''Case Mgmt - Customer Service''
          WHEN CA.ADMISSIONSTATUS2 = ''D20'' THEN ''Field Staff - Payrate''
          WHEN CA.ADMISSIONSTATUS2 = ''D21'' THEN ''Operations - SOPs''
          WHEN CA.ADMISSIONSTATUS2 = ''D22'' THEN ''Authorization Voided''
        ELSE CA.ADMISSIONSTATUS2 END  AS DISCHARGE_REASON																		 
	,IFF(hold_status.STATUS_CODE =''03'',true,false) AS On_Hold_Flag
    ,CAST( NULL AS DATE) AS On_Hold_Start_Date
    ,CAST( NULL AS DATE) AS On_Hold_End_Date
	,NULL ACQUIRED_FROM_COMPANY_KEY       
	,NULL ACQUIRED_FROM_COMPANY_ID
	,NULL ACQUIRED_FROM_COMPANY_FULL_NAME
	,NULL ACQUISITION_DATE  
	,NULL ACQUISITION_FLAG                
	,NULL ADMISSION_DATE                  
	,NULL ADMISSION_FLAG     
	,CASE WHEN DAYS_TO_SERVICE <= 60 THEN 1 ELSE 0 END AS CLIENT_CONVERTED_FLAG   
	,NULL PRIMARY_SUPERVISOR_KEY          
	,NULL PRIMARY_SUPERVISOR_CODE         
	,NULL PRIMARY_SUPERVISOR_NAME         
	,NULL SECONDARY_SUPERVISOR_KEY        
	,NULL SECONDARY_SUPERVISOR_CODE
	,NULL SECONDARY_SUPERVISOR_NAME
	,NULL PRIMARY_BRANCH_KEY              
	,NULL PRIMARY_BRANCH_NAME             
	,NULL PRIMARY_BRANCH_STATE     
	,NULL GUARANTOR_NAME           
	,NULL NOTES 
	,REFER.REFERRER_KEY
--, 	  serv.MRN AS MEDICAID_ID       
    ,TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
    ,TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE	    
   -- ,coord.CURRENT_SUPERVISOR_CODE AS CURRENT_SUPERVISOR_CODE
   -- ,coord.CURRENT_SUPERVISOR_NAME AS CURRENT_SUPERVISOR_NAME 
    --- ETL FIELDS ---
     ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY                   
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
    ,CURRENT_USER as ETL_INSERTED_BY 
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
    ,CURRENT_USER as ETL_LAST_UPDATED_BY
    ,0 as ETL_DELETED_FLAG
    ,0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.SANDATAIMPORT.CLIENT_MASTER_LIST C 
LEFT JOIN VISIT
    ON VISIT.AGENCYID = C.AGENCYID
    AND VISIT.CLIENTID = C.CLIENTID
LEFT JOIN serv serv
    ON serv.AGENCYID = C.AGENCYID
    AND serv.CLIENTID = C.CLIENTID
LEFT JOIN coord coord
        ON coord.AGENCYID = C.AGENCYID
    AND coord.CLIENTID = C.CLIENTID
LEFT JOIN hold_status
    ON hold_status.AGENCYID = C.AGENCYID
    AND hold_status.CLIENTID = C.CLIENTID
LEFT JOIN HAH.DIM_STATE S ON S.STATE_ISO_CODE=UPPER(TRIM(C.STATE))
LEFT JOIN CLIENT_REFERRALS REFER ON REFER.CLIENTID::string = C.CLIENTID
LEFT JOIN CLIENT_STATUS CA ON TRIM(C.CLIENTID) = TRIM(CA.CLIENTID)																						 
WHERE C.AGENCYID = 8485
AND (C.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz 
OR hold_status.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz 
OR VISIT.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz)
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}


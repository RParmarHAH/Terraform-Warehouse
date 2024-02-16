CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_HCFA1500RPT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_HCFA1500rpt 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO GENERATIONSALLIANCE.HCFA1500rpt FROM (SELECT t.$1 AS PageNumber, t.$2 AS ClientID, t.$3 AS Gender, t.$4 AS ClaimType_1, t.$5 AS InsuredID_1a, t.$6 AS PatientName_2, t.$7 AS PatientDob_3, t.$8 AS address_5, t.$9 AS city_5, t.$10 AS state_5, t.$11 AS zip_5, t.$12 AS relationshipToInsured_6, t.$13 AS signatureOnFile_12, t.$14 AS referralSource_17, t.$15 AS reservedLocalUse_19, t.$16 AS Diagnosis_21, t.$17 AS PriorAuthNumber_23, t.$18 AS From_24a1, t.$19 AS Thru_24a1, t.$20 AS POS_24b1, t.$21 AS CPT_24d1, t.$22 AS Charges_24f1, t.$23 AS Units_24g1, t.$24 AS From_24a2, t.$25 AS Thru_24a2, t.$26 AS POS_24b2, t.$27 AS CPT_24d2, t.$28 AS Charges_24f2, t.$29 AS Units_24g2, t.$30 AS From_24a3, t.$31 AS Thru_24a3, t.$32 AS POS_24b3, t.$33 AS CPT_24d3, t.$34 AS Charges_24f3, t.$35 AS Units_24g3, t.$36 AS From_24a4, t.$37 AS Thru_24a4, t.$38 AS POS_24b4, t.$39 AS CPT_24d4, t.$40 AS Charges_24f4, t.$41 AS Units_24g4, t.$42 AS From_24a5, t.$43 AS Thru_24a5, t.$44 AS POS_24b5, t.$45 AS CPT_24d5, t.$46 AS Charges_24f5, t.$47 AS Units_24g5, t.$48 AS From_24a6, t.$49 AS Thru_24a6, t.$50 AS POS_24b6, t.$51 AS CPT_24d6, t.$52 AS Charges_24f6, t.$53 AS Units_24g6, t.$54 AS fedId_25, t.$55 AS coName_33, t.$56 AS coAddress, t.$57 AS coCity, t.$58 AS coState, t.$59 AS coZip, t.$60 AS coPHone, t.$61 AS clientTypeID, t.$62 AS clientPhone, t.$63 AS groupNo_9a, t.$64 AS _11_Policy_FECA_no, t.$65 AS GrpNo_33, t.$66 AS locationID, t.$67 AS diagRef_24e1, t.$68 AS diagRef_24e2, t.$69 AS diagRef_24e3, t.$70 AS diagRef_24e4, t.$71 AS diagRef_24e5, t.$72 AS diagRef_24e6, t.$73 AS mod_241, t.$74 AS mod_242, t.$75 AS mod_243, t.$76 AS mod_244, t.$77 AS mod_245, t.$78 AS mod_246, t.$79 AS tos_1, t.$80 AS tos_2, t.$81 AS tos_3, t.$82 AS tos_4, t.$83 AS tos_5, t.$84 AS tos_6, t.$85 AS ReservedLocalUse_24K, t.$86 AS mod2_241, t.$87 AS mod2_242, t.$88 AS mod2_243, t.$89 AS mod2_244, t.$90 AS mod2_245, t.$91 AS mod2_246, t.$92 AS NPI1, t.$93 AS NPI2, t.$94 AS NPI3, t.$95 AS NPI4, t.$96 AS NPI5, t.$97 AS NPI6, t.$98 AS SYS_CHANGE_VERSION, t.$99 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$99,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_HCFA1500rpt.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.HCFA1500rpt AS WITH curr_v AS (SELECT PageNumber, ClientID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.HCFA1500rpt GROUP BY PageNumber, ClientID) SELECT t.* FROM GENERATIONSALLIANCE.HCFA1500rpt t INNER JOIN curr_v v ON t.PageNumber = v.PageNumber AND t.ClientID = v.ClientID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';
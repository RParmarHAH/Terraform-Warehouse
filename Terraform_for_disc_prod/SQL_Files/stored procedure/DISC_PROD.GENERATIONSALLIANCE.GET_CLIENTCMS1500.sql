CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_CLIENTCMS1500("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_ClientCMS1500 
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
    COPY INTO GENERATIONSALLIANCE.ClientCMS1500 FROM (SELECT t.$1 AS clientID, t.$2 AS hcfaID, t.$3 AS InsuranceType_1, t.$4 AS InsuredIdNo_1a, t.$5 AS InsuredName_4, t.$6 AS PatientRel_6, t.$7 AS InsuredAddress_7, t.$8 AS InsuredCity_7, t.$9 AS InsuredState_7, t.$10 AS InsuredZip_7, t.$11 AS InsuredPhoneNo_7, t.$12 AS PatientMarriedStatus_8, t.$13 AS PatientEmploymentStatus_8, t.$14 AS OtherInsuredName_9, t.$15 AS OtherPolicyNo_9a, t.$16 AS OtherDOB_9b, t.$17 AS OtherSex_9b, t.$18 AS OtherEmployerName, t.$19 AS OtherPlanName_9d, t.$20 AS RelatedToState_10, t.$21 AS InsuredGroupNo_11, t.$22 AS InsuredDOB_11a, t.$23 AS InsuredSex_11a, t.$24 AS InsuredEmployerName_11b, t.$25 AS InsuredPlanName_11c, t.$26 AS InsuredOtherHealthPlan_11d, t.$27 AS PatientSigOnFile_12, t.$28 AS InsuredSigOnFile_13, t.$29 AS CurrentIllnessDate_14, t.$30 AS SimilarIllnessDate_15, t.$31 AS unableToWorkFrom_16, t.$32 AS unableToWorkThru_16, t.$33 AS referringPhysician_17, t.$34 AS referringPhysicianID_17a, t.$35 AS hospitalizedFrom_18, t.$36 AS hospitalizedThru_18, t.$37 AS reservedForLocalUse_19, t.$38 AS outsideLab_20, t.$39 AS outsideLabCharges_20, t.$40 AS medicaidResubmissionCode_22, t.$41 AS OriginalReferenceNum_22, t.$42 AS priorAuthNumber_23, t.$43 AS reservedLocalUse_10d, t.$44 AS grrpNo_33, t.$45 AS pinNo_33, t.$46 AS diagnosis1, t.$47 AS diagnosis2, t.$48 AS diagnosis3, t.$49 AS diagnosis4, t.$50 AS patientsAcctNo, t.$51 AS AcceptAssignment, t.$52 AS servicesRenderedAddresss, t.$53 AS carrier, t.$54 AS RelatedToEmployment_10, t.$55 AS RelatedToAuto_10, t.$56 AS RelatedToOther_10, t.$57 AS physicianSign_31, t.$58 AS ReservedLocalUse_24, t.$59 AS PIN33, t.$60 AS referringPhysicianID_17aQualifier, t.$61 AS referringPhysicianNPI_17b, t.$62 AS renderingProviderIdQualifier24i, t.$63 AS npiNumber_24j, t.$64 AS npiNo_32a, t.$65 AS otherIdQualifier32b, t.$66 AS otherID32b, t.$67 AS AmountPaid_29, t.$68 AS POS_24b, t.$69 AS PhysicianSupplierName_33, t.$70 AS EPSDT_24h, t.$71 AS ProviderNo24j_Type, t.$72 AS Phone33, t.$73 AS EMG_24c, t.$74 AS CurrentIllness14_Qual, t.$75 AS OtherClaim11b_Qual, t.$76 AS OtherClaim11b_Description, t.$77 AS OtherDate15_Qual, t.$78 AS ReferringPhysician17_Qual, t.$79 AS AdditionalClaim19, t.$80 AS diagnosis6, t.$81 AS diagnosis5, t.$82 AS diagnosis7, t.$83 AS diagnosis9, t.$84 AS diagnosis8, t.$85 AS diagnosis10, t.$86 AS diagnosis11, t.$87 AS diagnosis12, t.$88 AS InsuredMiddleName_4, t.$89 AS InsuredFirstName_4, t.$90 AS OtherInsuredFirstName_9, t.$91 AS OtherInsuredMiddleName_9, t.$92 AS diagnosisA, t.$93 AS diagnosisB, t.$94 AS diagnosisC, t.$95 AS diagnosisD, t.$96 AS InsuredLastName_4, t.$97 AS OtherInsuredLastName_9, t.$98 AS grpNo_33_qual, t.$99 AS lastupdated, t.$100 AS UpdatedBy, t.$101 AS diagnosisIcd10A, t.$102 AS diagnosisIcd10B, t.$103 AS diagnosisIcd10C, t.$104 AS diagnosisIcd10D, t.$105 AS diagnosisIcd10E, t.$106 AS diagnosisIcd10F, t.$107 AS diagnosisIcd10G, t.$108 AS diagnosisIcd10H, t.$109 AS diagnosisIcd10I, t.$110 AS diagnosisIcd10J, t.$111 AS diagnosisIcd10K, t.$112 AS diagnosisIcd10L, t.$113 AS FederalTaxIDType_25, t.$114 AS SYS_CHANGE_VERSION, t.$115 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$115,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ClientCMS1500.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ClientCMS1500 AS WITH curr_v AS (SELECT clientID, hcfaID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ClientCMS1500 GROUP BY clientID, hcfaID) SELECT t.* FROM GENERATIONSALLIANCE.ClientCMS1500 t INNER JOIN curr_v v ON t.clientID = v.clientID AND t.hcfaID = v.hcfaID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';
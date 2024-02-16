CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CLINICALOTHER485("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_ClinicalOther485 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.ClinicalOther485 (SELECT t.$1 AS AgencyID, t.$2 AS Other485ID, t.$3 AS Master485ID, t.$4 AS PatientID, t.$5 AS FLAmbulation, t.$6 AS FLBowel, t.$7 AS FLContracsture, t.$8 AS FLHearing, t.$9 AS FLParalysis, t.$10 AS FLEndurance, t.$11 AS FLAmputation, t.$12 AS FLSpeech, t.$13 AS FLLegalyBlind, t.$14 AS FLDyspnea, t.$15 AS FLOther, t.$16 AS ACTCompleteBedRest, t.$17 AS ACTBedRestWithBRP, t.$18 AS ACTUpAsTolerated, t.$19 AS ACTTransfer, t.$20 AS ACTExcercise, t.$21 AS ACTPartialWeightBearing, t.$22 AS ACTIndependentAtHome, t.$23 AS ACTCrutches, t.$24 AS ACTCane, t.$25 AS ACTWeelChair, t.$26 AS ACTWalker, t.$27 AS ACTNoRestrictions, t.$28 AS ACTOther, t.$29 AS MENOriented, t.$30 AS MENComatose, t.$31 AS MENForgetful, t.$32 AS MENDepressed, t.$33 AS MENDisoriented, t.$34 AS MENLethargic, t.$35 AS MENAgitated, t.$36 AS MENOther, t.$37 AS Others, t.$38 AS CreatedBy, t.$39 AS CreatedDate, t.$40 AS UpdatedBy, t.$41 AS UpdatedDate, t.$42 AS PROGPoor, t.$43 AS PROGGuarded, t.$44 AS PROGFair, t.$45 AS PROGGood, t.$46 AS PROGExcellent, t.$47 AS FLOtherText, t.$48 AS ACTOtherText, t.$49 AS MENOtherText, t.$50 AS DMEOtherText, t.$51 AS SafetyOtherText, t.$52 AS NutOtherText, t.$53 AS SYS_CHANGE_VERSION, t.$54 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$54,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ClinicalOther485.*[.]csv.gz'') T);

    return ''Success'';
END;
';
resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_EPAYENTRY" {
	name ="GET_EPAYENTRY"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_EPayEntry 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.EPayEntry (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS Trans, t.$4 AS voidedTrans, t.$5 AS checkDate, t.$6 AS beginDate, t.$7 AS endDate, t.$8 AS calendarId, t.$9 AS batch, t.$10 AS process, t.$11 AS tcode1, t.$12 AS tcode2, t.$13 AS tcode3, t.$14 AS tcode4, t.$15 AS cc, t.$16 AS cc1, t.$17 AS cc2, t.$18 AS cc3, t.$19 AS cc4, t.$20 AS cc5, t.$21 AS jobCode, t.$22 AS checkNumber, t.$23 AS voucherNumber, t.$24 AS documentNumber, t.$25 AS checkAttributes, t.$26 AS net, t.$27 AS dirDepAmount, t.$28 AS netCheck, t.$29 AS accountId, t.$30 AS dirDepAccountId, t.$31 AS calcFlag, t.$32 AS specialCheck, t.$33 AS taxFrequency, t.$34 AS deductionMultiplier, t.$35 AS dedBlocks, t.$36 AS earnBlocks, t.$37 AS taxBlocks, t.$38 AS dirDepBlocked, t.$39 AS accrualsBlocked, t.$40 AS distributionsBlocked, t.$41 AS checkstubMemo, t.$42 AS userMemo, t.$43 AS useOverrideOptions, t.$44 AS calcOrder, t.$45 AS cleared, t.$46 AS hours, t.$47 AS regHours, t.$48 AS autoPay, t.$49 AS otHours, t.$50 AS gross, t.$51 AS regDollars, t.$52 AS otDollars, t.$53 AS wcc, t.$54 AS dirDepBlocks, t.$55 AS checkAttributeID, t.$56 AS lastChange, t.$57 AS ovFITWPercent, t.$58 AS ovSITWPercent, t.$59 AS lastChangeUser, t.$60 AS inytd, t.$61 AS ww, t.$62 AS wwType, t.$63 AS IsNocalc, t.$64 AS IsVoid, t.$65 AS IsManual, t.$66 AS ImportGuid, t.$67 AS extraWithholdingBlocked, t.$68 AS replacedCheckDate, t.$69 AS replacedCheckNumber, t.$70 AS IsReissue, t.$71 AS reissuedTrans, t.$72 AS voidReason, t.$73 AS SYS_CHANGE_VERSION, t.$74 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$74,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EPayEntry.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}


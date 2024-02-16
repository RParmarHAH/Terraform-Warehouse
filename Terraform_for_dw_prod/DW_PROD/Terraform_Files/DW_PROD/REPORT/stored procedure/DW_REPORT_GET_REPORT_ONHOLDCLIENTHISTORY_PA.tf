resource "snowflake_procedure" "DW_REPORT_GET_REPORT_ONHOLDCLIENTHISTORY_PA" {
	name ="GET_REPORT_ONHOLDCLIENTHISTORY_PA"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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
    return_result_temp VARCHAR;
BEGIN
	MERGE INTO REPORT.OnHoldClientHistory_PA TARGET
	USING REPORT.VW_NEXTONHOLDDATA_SANDATA SRC
	ON TARGET.clientid = SRC.clientid
	AND TARGET.OnHoldEndDate is NULL
	AND SRC.ADMISSIONSTATUS = ''02''
	WHEN MATCHED THEN UPDATE SET TARGET.OnHOLDENDDATE = SRC.ETL_INSERTED_DATE,
	TARGET.ETL_INSERTED_DATE = SRC.ETL_INSERTED_DATE;

	SELECT CONCAT(''Message : '',"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
	
	
	INSERT INTO REPORT.OnHoldClientHistory_PA 
	SELECT TARGET.clIENTID,TARGET.CLIENT_KEY,TARGET.SOURCE_SYSTEM_ID,
	TARGET.SYSTEM_CODE,TARGET.ETL_INSERTED_DATE,NULL,TRUE,
	TARGET.ETL_INSERTED_DATE,-1 FROM REPORT.VW_NEXTONHOLDDATA_SANDATA TARGET
	INNER JOIN REPORT.OnHoldClientHistory_pa SRC
	ON TARGET.clientid = SRC.clientid
	AND SRC.ACTIVE = TRUE
	AND SRC.OnHoldEndDate is NOT NULL
	AND TARGET.ADMISSIONSTATUS = ''03'';

	SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
	return_result:=CONCAT(return_result,'' & '',return_result_temp);
	
	INSERT INTO REPORT.OnHoldClientHistory_PA 
	SELECT TARGET.clIENTID,TARGET.CLIENT_KEY,TARGET.SOURCE_SYSTEM_ID,
	TARGET.SYSTEM_CODE,TARGET.ETL_INSERTED_DATE,NULL,TRUE,
	TARGET.ETL_INSERTED_DATE,-1
	FROM REPORT.VW_NEXTONHOLDDATA_SANDATA TARGET
	WHERE TARGET.clientid NOT IN (SELECT CLIENTID FROM REPORT.OnHoldClientHistory_PA)
	AND TARGET.ADMISSIONSTATUS = ''03'';

	SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
	return_result:=CONCAT(return_result,'' & '',return_result_temp);
	
	UPDATE REPORT.OnHoldClientHistory_pA clienthistory
	SET ACTIVE = FALSE
	FROM
	(
	SELECT clienthistory.CLIENTID,clienthistory.Source_System_Id,clienthistory.SYSTEM_CODE,
	clienthistory.ETL_INSERTED_DATE
	FROM REPORT.OnHoldClientHistory_PA clienthistory
	INNER JOIN
	(
	SELECT * FROM   
	(
	SELECT CLIENTID,Source_System_Id,SYSTEM_CODE,ONHOLDSTARTDATE,
	ONHOLDENDDATE,ETL_INSERTED_DATE,
	RANK() OVER (PARTITION  BY CLIENTID,Source_System_Id,
	SYSTEM_CODE ORDER BY ETL_INSERTED_DATE DESC) AS LATESTRECORD
	FROM REPORT.OnHoldClientHistory_PA
	) WHERE LATESTRECORD = 1)LatestData
	on clienthistory.CLIENTID = latestdata.CLIENTID
	and clienthistory.Source_System_Id = latestdata.Source_System_Id    
	and clienthistory.SYSTEM_CODE = latestdata.SYSTEM_CODE
	and clienthistory.ETL_INSERTED_DATE != latestdata.ETL_INSERTED_DATE
	and clienthistory.active = TRUE
	)t1
	where clienthistory.CLIENTID = t1.CLIENTID
	and clienthistory.Source_System_Id = t1.Source_System_Id    
	and clienthistory.SYSTEM_CODE = t1.SYSTEM_CODE
	and clienthistory.ETL_INSERTED_DATE = t1.ETL_INSERTED_DATE
	and clienthistory.active = TRUE; 

SELECT CONCAT('' '',"number of rows updated",'' Rows Updated.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return concat(return_result,'' & '',return_result_temp);
END;


 EOT
}


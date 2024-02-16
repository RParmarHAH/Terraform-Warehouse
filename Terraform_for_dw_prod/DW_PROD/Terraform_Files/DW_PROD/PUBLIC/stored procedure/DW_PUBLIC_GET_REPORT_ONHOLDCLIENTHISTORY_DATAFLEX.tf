resource "snowflake_procedure" "DW_PUBLIC_GET_REPORT_ONHOLDCLIENTHISTORY_DATAFLEX" {
	name ="GET_REPORT_ONHOLDCLIENTHISTORY_DATAFLEX"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

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

  var rs = snowflake.execute( { sqlText: `MERGE INTO REPORT.OnHoldClientHistory_dataflex TARGET
                                          USING REPORT.VW_NEXTONHOLDDATA_DATAFLEX SRC
                                          ON TARGET.NUMBER = SRC.NUMBER
                                          AND TARGET.SourceSystemID = SRC.SourceSystemID
                                          AND TARGET.DBNAME = SRC.DBNAME
										  AND TARGET.ACTIVE = TRUE
                                          AND TARGET.ONHOLDSTARTDATE IS NOT NULL
                                          AND (
                                                TARGET.ONHOLDENDDATE IS NULL
                                                OR 
                                                TARGET.ONHOLDENDDATE > 
                                                DATEADD(DAY,-1,NVL(src.ONHOLDSTARTDATE,SRC.ETL_INSERTED_DATE))
                                               )
                                          WHEN MATCHED THEN UPDATE SET TARGET.ONHOLDENDDATE = 
                                          DATEADD(DAY,-1,NVL(src.ONHOLDSTARTDATE,SRC.ETL_INSERTED_DATE))
                                          ,TARGET.ETL_INSERTED_DATE = SRC.ETL_INSERTED_DATE
                                          `} );
  
  var rs = snowflake.execute( { sqlText: `MERGE INTO REPORT.OnHoldClientHistory_dataflex TARGET
                                          USING REPORT.VW_NEXTONHOLDDATA_DATAFLEX SRC
                                          ON TARGET.NUMBER = SRC.NUMBER
                                          AND TARGET.SourceSystemID = SRC.SourceSystemID
                                          AND TARGET.DBNAME = SRC.DBNAME
										  AND TARGET.ACTIVE = TRUE
                                          AND NVL(TARGET.ONHOLDSTARTDATE,''1900-01-01'') = NVL(SRC.ONHOLDSTARTDATE,''1900-01-01'')
                                          AND NVL(TARGET.ONHOLDENDDATE,''1900-01-01'') != NVL(SRC.ONHOLDENDDATE,''1900-01-01'')
                                          WHEN MATCHED THEN UPDATE SET TARGET.ONHOLDENDDATE = SRC.ONHOLDENDDATE
                                          ,TARGET.ETL_INSERTED_DATE = SRC.ETL_INSERTED_DATE`} );
  var rs = snowflake.execute({  sqlText: `INSERT INTO REPORT.OnHoldClientHistory_dataflex(CLIENT_KEY,NUMBER,SOURCESYSTEMID,DBNAME,ONHOLDSTARTDATE,ONHOLDENDDATE,
										  ACTIVE,ETL_INSERTED_DATE)
										  SELECT CLIENT_KEY,NUMBER,SOURCESYSTEMID,DBNAME,ONHOLDSTARTDATE,
										  ONHOLDENDDATE,STATUS,ETL_INSERTED_DATE FROM REPORT.VW_NEXTONHOLDDATA_DATAFLEX
										  WHERE NVL(ONHOLDSTARTDATE,''1900-01-01'') != ''1900-01-01''
										  AND NUMBER || SOURCESYSTEMID || DBNAME 
										  NOT IN (SELECT NUMBER || SOURCESYSTEMID || DBNAME FROM REPORT.OnHoldClientHistory_dataflex
										  WHERE ACTIVE  =TRUE);`});
  var rs = snowflake.execute({  sqlText: `INSERT INTO REPORT.OnHoldClientHistory_dataflex
                                          SELECT SRC.CLIENT_KEY,SRC.NUMBER,SRC.SOURCESYSTEMID,SRC.DBNAME,SRC.ONHOLDSTARTDATE,
                                          SRC.ONHOLDENDDATE,SRC.STATUS,SRC.ETL_INSERTED_DATE,-1 FROM REPORT.OnHoldClientHistory_dataflex TARGET
                                          INNER JOIN REPORT.VW_NEXTONHOLDDATA_DATAFLEX SRC
                                          ON TARGET.NUMBER = SRC.NUMBER
                                          AND TARGET.SourceSystemID = SRC.SourceSystemID
                                          AND TARGET.DBNAME = SRC.DBNAME
                                          AND TARGET.ACTIVE = TRUE
										  AND NVL(SRC.ONHOLDSTARTDATE,''1900-01-01'') != ''1900-01-01''
                                          AND NVL(TARGET.ONHOLDSTARTDATE,''1900-01-01'') != NVL(SRC.ONHOLDSTARTDATE,''1900-01-01'')`});
                                          
  var rs = snowflake.execute({  sqlText:  `UPDATE REPORT.OnHoldClientHistory_dataflex clienthistory
											SET ACTIVE = FALSE
											FROM
											(
											  SELECT clienthistory.NUMBER,clienthistory.SourceSystemId,clienthistory.dbname,
											  clienthistory.ETL_INSERTED_DATE
											  FROM REPORT.OnHoldClientHistory_dataflex clienthistory
											  INNER JOIN
											  (
												SELECT * FROM   
												(
													SELECT NUMBER,SourceSystemId,DBNAME,ONHOLDSTARTDATE,ONHOLDENDDATE,ETL_INSERTED_DATE,
													RANK() OVER (PARTITION  BY NUMBER,SourceSystemId,DBNAME ORDER BY ETL_INSERTED_DATE DESC) AS LATESTRECORD
													FROM REPORT.OnHoldClientHistory_dataflex
												) WHERE LATESTRECORD = 1)LatestData
												on clienthistory.NUMBER = latestdata.NUMBER
												and clienthistory.SourceSystemId = latestdata.SourceSystemId    
												and clienthistory.dbname = latestdata.dbname
												and clienthistory.ETL_INSERTED_DATE != latestdata.ETL_INSERTED_DATE
												and clienthistory.active = TRUE
											)t1
											where clienthistory.NUMBER = t1.NUMBER
												and clienthistory.SourceSystemId = t1.SourceSystemId    
												and clienthistory.dbname = t1.dbname
												and clienthistory.ETL_INSERTED_DATE = t1.ETL_INSERTED_DATE
												and clienthistory.active = TRUE;`});
  var rs = snowflake.execute({ sqlText: `MERGE INTO REPORT.OnHoldClientHistory_DATAFLEX TARGET
                                         USING REPORT.VW_NEXTONHOLDDATA_DATAFLEX SRC
                                         ON TARGET.NUMBER = SRC.NUMBER
                                         AND TARGET.SourceSystemID = SRC.SourceSystemID
                                         AND TARGET.DBNAME = SRC.DBNAME
                                         AND TARGET.ACTIVE = TRUE
                                          AND SRC.ONHOLDSTARTDATE IS NULL
                                          AND TARGET.ONHOLDENDDATE IS NULL
                                          WHEN MATCHED THEN UPDATE SET TARGET.ONHOLDENDDATE = SRC.ETL_INSERTED_DATE
                                          ,TARGET.ETL_INSERTED_DATE = SRC.ETL_INSERTED_DATE;`});
  var rs = snowflake.execute({  sqlText:  `update REPORT.OnHoldClientHistory_dataflex t1
                                           set t1.onholdenddate = t2.onholdenddate
                                           from
                                           (
                                                select distinct OnHold.client_key,OnHold.number,OnHold.sourcesystemid,
                                                OnHold.dbname,OnHold.onholdstartdate,
                                                min(service_Date) over (partition by OnHold.client_key,OnHold.number,
                                                OnHold.sourcesystemid,OnHold.dbname,OnHold.onholdstartdate) as onholdenddate
                                                from REPORT.OnHoldClientHistory_dataflex OnHold
                                            inner join 
                                            (
                                                select distinct SYSTEM_CODE,client_key,service_Date
                                                from
                                                hah.fact_visit 
                                                where source_system_id = 3
                                             )v 
                                             on v.client_key = OnHold.client_key
                                             and v.SYSTEM_CODE = onhold.dbname
                                             and v.service_date > onhold.onholdstartdate
                                             where active = false and onholdenddate is null
                                            )t2
                                            where t1.client_key = t2.client_key 
                                            and t1.dbname = t2.dbname and 
                                            t1.sourcesystemid = t2.sourcesystemid 
                                            and t1.number = t2.number
                                            and t1.onholdstartdate = t2.onholdstartdate
                                            and t1.active=false and t1.onholdenddate is null;`});
  return ''Done.'';
  
 EOT
}


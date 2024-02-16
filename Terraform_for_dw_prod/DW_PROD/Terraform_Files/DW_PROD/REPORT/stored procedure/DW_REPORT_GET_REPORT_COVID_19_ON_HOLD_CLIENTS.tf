resource "snowflake_procedure" "DW_REPORT_GET_REPORT_COVID_19_ON_HOLD_CLIENTS" {
	name ="GET_REPORT_COVID_19_ON_HOLD_CLIENTS"
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
BEGIN
    INSERT OVERWRITE INTO REPORT.COVID_19_ON_HOLD_CLIENTS
WITH QUERY AS (
	SELECT C.DbName AS "State",
	        CAST(o.OfficeNumber AS VARCHAR) AS "Office Number",
	        o.OfficeName AS "Office Name",
	        C.OnHoldStartDate AS "On Hold Start Date",
	        COUNT(DISTINCT C.Number) AS "Client Count",
            nvl(b2.BRANCH_KEY, md5(T.DBNAME || ''-'' || COALESCE(O.OfficeName, ''Unknown'') || ''-'' ||  ''DATAFLEXSYNCDATA'')) AS BRANCH_KEY	 
          FROM "DISC_${var.SF_ENVIRONMENT}"."DATAFLEXSYNCDATA"."DFTIMESHEETS" T
	     JOIN "DISC_${var.SF_ENVIRONMENT}"."DATAFLEXSYNCDATA"."DFTIMESHEETHOURS" TH
	         ON TH.DbName = T.DbName
	            AND TH.ReferenceNo = T.ReferenceNo
	            AND TH.WeekendDate = T.WeekendDate
	     JOIN "DISC_${var.SF_ENVIRONMENT}"."DATAFLEXSYNCDATA"."DFCLIENTS" C
	         ON C.DbName = T.DbName
	            AND C.Number = T.ClientNumber
	     JOIN "DISC_${var.SF_ENVIRONMENT}"."DATAFLEXSYNCDATA"."DFCLIENTCONTRACTS" cc
	         ON cc.DbName = T.DbName
	            AND cc.ClientNumber = T.ClientNumber
	            AND cc.ContractCode = T.ContractCode
	     JOIN "DISC_${var.SF_ENVIRONMENT}"."DATAFLEXSYNCDATA"."DFCONTRACTS" co
	         ON co.DbName = T.DbName
	            AND co.ContractCode = T.ContractCode
	            AND co.ContractCode = cc.ContractCode
	     JOIN "DISC_${var.SF_ENVIRONMENT}"."DATAFLEXSYNCDATA"."DFOFFICES" o
	         ON o.DbName = C.DbName
	            AND o.OfficeNumber = C.OfficeNumber
         LEFT JOIN HAH.DIM_BRANCH b2
            ON b2.BRANCH_NAME = COALESCE(o.OfficeName, ''Unknown'')
             AND b2.SYSTEM_CODE = o.DBNAME
	 WHERE C.OnHoldStartDate
	       BETWEEN ''1/1/2020'' AND CURRENT_DATE()
	       AND co.RevenueCategory <> ''cls''
	       AND co.RevenueCategory IN ( ''HC'', ''HH'' )
	       AND co.Billable = 1
	       AND co.Payable = 1
	 GROUP BY C.DbName,
	          o.OfficeNumber,
	          o.OfficeName,
	          C.OnHoldStartDate,
              nvl(b2.BRANCH_KEY, md5(T.DBNAME || ''-'' || COALESCE(O.OfficeName, ''Unknown'') || ''-'' ||  ''DATAFLEXSYNCDATA''))
	 UNION ALL
	 (SELECT ''PA'' AS "State",
	         CA.LocationID AS "Office Number",
	         CA.LocationName AS "Office Name",
	         S.ScheduleDate AS "On Hold Start Date",
	         COUNT(DISTINCT CA.clientID) AS "Client Count",
              md5(nvl(s.agencyID,''S'') || ''-'' || nvl(eid.LstNam,f.LocationId) || ''-'' ||  ''SANDATAIMPORT'') AS BRANCH_KEY
	  FROM "DISC_${var.SF_ENVIRONMENT}"."SANDATAIMPORT"."SANDATA_SCHEDULES" S
	      JOIN
	      (
	          SELECT SC.*
	          FROM
	          (
	              SELECT agencyID,
	                     ScheduleID,
	                     MAX(ClientSchedDtlID) ClientSchedDtlId,
	                     MAX(ClientSchedHdrID) ClientSchedHdrId
	              FROM "DISC_${var.SF_ENVIRONMENT}"."SANDATAIMPORT"."SANDATA_SCHEDULESCLIENTS"
	              GROUP BY agencyID,
	                       ScheduleID
	          ) L
	              JOIN "DISC_${var.SF_ENVIRONMENT}"."SANDATAIMPORT"."SANDATA_SCHEDULESCLIENTS" SC
	                  ON SC.agencyID = L.agencyID
	                     AND SC.ScheduleID = L.ScheduleID
	                     AND SC.ClientSchedHdrID = L.ClientSchedHdrId
	                     AND SC.ClientSchedDtlID = L.ClientSchedDtlId
	      ) SC
	          ON SC.agencyID = S.agencyID
	             AND SC.ScheduleID = S.ScheduleID
	      JOIN "DISC_${var.SF_ENVIRONMENT}"."SANDATAIMPORT"."SANDATA_CLIENTADMISSIONS" CA
	          ON CA.agencyID = SC.agencyID
	             AND CA.admissionID = SC.AdmissionID
           JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_VISITS f
                ON F.AGENCYID = s.AGENCYID AND f.SCHEDULEID = s.SCHEDULEID
           JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
                   ON F.LocationId = eid.ExtID
                   AND eid.Typ = ''L''
	  WHERE CA.AdmissionStatus = ''03''
	        AND CA.agencyID = ''8485''
	  GROUP BY CA.LocationID,
	           CA.LocationName,
	           S.ScheduleDate,
                BRANCH_KEY
	  HAVING MAX(S.ScheduleDate)
	  BETWEEN ''1/1/2020'' AND CURRENT_DATE())
)
	SELECT *,
	    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	FROM QUERY;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}


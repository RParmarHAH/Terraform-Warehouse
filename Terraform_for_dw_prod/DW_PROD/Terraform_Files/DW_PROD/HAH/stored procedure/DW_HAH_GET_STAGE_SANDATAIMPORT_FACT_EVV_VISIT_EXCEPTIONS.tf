resource "snowflake_procedure" "DW_HAH_GET_STAGE_SANDATAIMPORT_FACT_EVV_VISIT_EXCEPTIONS" {
	name ="GET_STAGE_SANDATAIMPORT_FACT_EVV_VISIT_EXCEPTIONS"
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
    INSERT OVERWRITE INTO STAGE.SANDATAIMPORT_FACT_EVV_VISIT_EXCEPTIONS
WITH CTE AS (WITH clu as (
    select
           (CASE WHEN try_to_numeric(OTHERID) is null AND try_to_numeric(CUSTOMID) is null THEN -1
                WHEN try_to_numeric(OTHERID) is not null AND try_to_numeric(CUSTOMID) is null THEN OTHERID
                WHEN try_to_numeric(CUSTOMID) is not null AND try_to_numeric(OTHERID) is null THEN CUSTOMID
                ELSE coalesce(OTHERID, CUSTOMID)
            END)::INTEGER as DF_CLIENT_NUMBER,
           AGENCYID,
           max(CLIENTID) AS CLIENTID
    from DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTS
    group by 1,2
),
max_client as (
    select DF_CLIENT_NUMBER,
            max(CLIENTID) AS CLIENTID
    from clu
    GROUP BY 1
    )
SELECT
	MD5(f.agencyID || ''-'' || f.scheduleid || ''-'' || ''SANDATAIMPORT'') AS VISIT_KEY,
	cs.VALUE::STRING AS EXCEPTION_REASON_CODE,
	--sch.EXCEPTIONCODE AS EXCEPTION_REASON_CODE,
    f."DATE" AS REPORT_DATE,  
    CASE WHEN S.state_iso_code = ''PA'' THEN 
     md5(nvl(f.agencyID,''S'') || ''-'' || nvl(f.LocationId,'''') || ''-'' ||  ''SANDATAIMPORT'') ELSE
    MD5(NVL(OFFICE.DBNAME,'''') || ''-'' || COALESCE(OFFICE.OFFICENUMBER, -1) || ''-'' || IFF(OFFICE.OFFICENUMBER = 0, ''GPSYNCDATA'', ''DATAFLEXSYNCDATA'')) END
    AS BRANCH_KEY,
    CASE WHEN S.state_iso_code = ''PA'' THEN 
    md5(nvl(f.agencyID,''S'')|| ''-'' ||  coalesce(ClientAdmissions.CLIENTID,clu.CLIENTID,mc.CLIENTID) || ''-''  || ''SANDATAIMPORT'' ) ELSE
    md5(s.state_iso_code || ''-'' || nvl(DFCLIENT."NUMBER",-1) || ''-''  ||  ''DATAFLEXSYNCDATA'')END AS CLIENT_KEY,
    CASE WHEN S.state_iso_code = ''PA'' THEN 
    md5(nvl(f.agencyID,''S'') || ''-'' || f.ClientAdmitType || ''-''  ||  ''SANDATAIMPORT'') ELSE
    md5(s.state_iso_code || ''-'' || NVL(CONTRACT.CONTRACTCODE,''Unknown'') || ''-''  ||  ''DATAFLEXSYNCDATA'') END AS CONTRACT_KEY,
    CASE WHEN S.state_iso_code = ''PA'' THEN 
    nvl(e.EMPLOYEE_KEY, md5(nvl(f.agencyID,''S'') || ''-'' || upper(NVL(TRIM(f.STAFFAGENCYID), '''')) || ''-'' || ''1900-01-01'' || ''-'' || ''SANDATAIMPORT'')) else
    nvl(e.EMPLOYEE_KEY, md5(COALESCE(s.state_iso_code,'''') || ''-'' || UPPER(NVL(TRIM(EMPLOYEE.NUMBER), '''')) || ''-''  ||  ''1900-01-01'' || ''-'' || ''DATAFLEXSYNCDATA''))
    end AS EMPLOYEE_KEY, 
    CASE WHEN S.state_iso_code = ''PA'' THEN 
    md5(nvl(f.agencyID,''S'') || ''-''  || nvl(ClientAdmissions.CoordinatorID::string, ''Unknown-'' || nvl(f.agencyID,''S'')) || ''-''  || ''SANDATAIMPORT'') 
    ELSE md5(s.state_iso_code || ''-''  || nvl(COALESCE(DFCLIENTSUPERVISOR.SUPERVISORCODE, DFCLIENT.SUPERVISORCODE),''Unknown-'' || s.state_iso_code) || ''-''  || ''DATAFLEXSYNCDATA'') END 
    AS SUPERVISOR_KEY,
    f."DATE" AS SERVICE_DATE,
	case when s.state_iso_code = ''PA'' THEN coalesce(ClientAdmissions.CLIENTID,clu.CLIENTID,mc.CLIENTID) 
    ELSE DFCLIENT."NUMBER" END AS CLIENT_NUMBER,
	case when s.state_iso_code = ''PA'' THEN f.ClientAdmitType ELSE CONTRACT.CONTRACTCODE END
    AS CONTRACT_CODE,
	case when s.state_iso_code = ''PA'' THEN NVL(f.STAFFAGENCYID, ''-1'') ELSE CAST(EMPLOYEE.NUMBER AS VARCHAR) END AS EMPLOYEE_ID,
    s.state_iso_code AS SYSTEM_CODE,
    sch.agencyid
   -- excep.DESCRIPTION AS EXCEPTION_REASON_DESCRIPTION
	
FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_VISITS f
left join clu clu
    on (CASE WHEN try_to_numeric(F.CLIENTOTHERID) is null THEN -1
            ELSE f.CLIENTOTHERID
        END)::INTEGER = clu.DF_CLIENT_NUMBER
    and f.AGENCYID = clu.AGENCYID
left join max_client mc
    on (CASE WHEN try_to_numeric(f.CLIENTOTHERID) is null THEN -1
            ELSE f.CLIENTOTHERID
        END)::INTEGER = mc.DF_CLIENT_NUMBER
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS ClientAdmissions
    ON ClientAdmissions.agencyID = f.AgencyId
    AND ClientAdmissions.admissionID = f.AdmissionId
--LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
 --   ON f.LocationId = eid.ExtID
  --  AND eid.Typ = ''L''
LEFT JOIN HAH.DIM_BRANCH AS BRANCH ON BRANCH.SYSTEM_CODE::STRING = F.AGENCYID AND BRANCH.OFFICE_CODE = F.LOCATIONID
LEFT JOIN HAH.DIM_STATE s 
    on f.agencyid = s.sandata_agency_id
-----Employee_Key-----
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFEMPLOYEES AS EMPLOYEE
    ON EMPLOYEE.DBNAME = S.STATE_ISO_CODE AND EMPLOYEE.PAYROLLIDINDEXNO = try_cast(F.STAFFAGENCYID as integer)
LEFT JOIN HAH.DIM_EMPLOYEE e
	ON f.STAFFAGENCYID = e.EMPLOYEE_ID
	AND (case when s.state_iso_code =''PA'' then e.system_code = f.agencyid
        else e.SYSTEM_CODE = S.STATE_ISO_CODE end)
    AND f.Date >= e.EFFECTIVE_FROM_DATE
    AND f.Date < e.EFFECTIVE_TO_DATE
-----Contract_Key-----
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAEXCHANGE.OPENSAM_CLIENTADMISSIONTYPES CAT
    ON CAT.HAHDFDB = S.STATE_ISO_CODE AND CAT.ADMISSIONTYPEID = F.CLIENTADMITTYPE AND CAT.DEFAULTSERVICE = F.SERVICEID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS AS CONTRACT
    ON CONTRACT.DBNAME = CAT.HAHDFDB AND CONTRACT.CONTRACTCODE = CAT.CONTRACTCODE
-----Client_Key-------
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTS C
    ON C.AGENCYID = ClientAdmissions.AGENCYID AND C.CLIENTID = ClientAdmissions.CLIENTID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTS AS DFCLIENT
    ON DFCLIENT.DBNAME = S.STATE_ISO_CODE AND DFCLIENT."NUMBER" = CLU.DF_CLIENT_NUMBER --TRY_CAST(C.OTHERID AS INTEGER)
-----Supervisor_Key----
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTSUPERVISORS DFCLIENTSUPERVISOR
    ON DFCLIENTSUPERVISOR.DBNAME = DFCLIENT.DBNAME AND DFCLIENTSUPERVISOR.CLIENTNUMBER = DFCLIENT."NUMBER"  
    AND DFCLIENTSUPERVISOR.BUSINESSLINE = CONTRACT.REVENUECATEGORY
-----Branch_Key-----
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES AS OFFICE
    ON OFFICE.DBNAME = DFCLIENT.DBNAME AND OFFICE.OFFICENUMBER = DFCLIENT.OFFICENUMBER
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_SCHEDULES sch ON f.AGENCYID = sch.AGENCYID AND f.SCHEDULEID = sch.SCHEDULEID,
LATERAL FLATTEN(INPUT=>SPLIT(nvl(exceptioncode,''''''''), ''|'')) cs
WHERE  
(f.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
	OR sch.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz)
AND f.STAFFAGENCYID <> '''' AND f.ADJUSTEDDURATION>0 
--AND sch.SCHEDULEID=''3504078''
)
SELECT CTE.VISIT_KEY,
CTE.EXCEPTION_REASON_CODE,
CTE.REPORT_DATE,  
CTE.BRANCH_KEY,
CTE.CLIENT_KEY,
CTE.CONTRACT_KEY,
CTE.EMPLOYEE_KEY, 
CTE.SUPERVISOR_KEY,
CTE.SERVICE_DATE,
CTE.CLIENT_NUMBER,
CTE.CONTRACT_CODE,
CTE.EMPLOYEE_ID,
CTE.SYSTEM_CODE,
EXCEP.DESCRIPTION,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG FROM CTE 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_EXCEPTIONCODES excep 
ON CTE.EXCEPTION_REASON_CODE = excep.code AND CTE.agencyid = excep.AGENCYID ;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}


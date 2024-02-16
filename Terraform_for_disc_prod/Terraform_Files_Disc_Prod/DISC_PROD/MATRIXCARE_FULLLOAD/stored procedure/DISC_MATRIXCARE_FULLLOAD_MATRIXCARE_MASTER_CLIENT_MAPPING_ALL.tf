resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_MATRIXCARE_MASTER_CLIENT_MAPPING_ALL" {
	name ="MATRIXCARE_MASTER_CLIENT_MAPPING_ALL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
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
  RETURN_RESULT VARCHAR(1000);
BEGIN
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.MATRIXCARE_MASTER_CLIENT_MAPPING_ALL
WITH DATA AS ( WITH CLIENT_PHONENUMBER AS
(
SELECT DISTINCT CLPH_CLIENTID
,CASE WHEN CLPH_ID =2 THEN CLPH_PHONE ELSE NULL END AS CLIENT_HOME_PHONE
,CASE WHEN CLPH_ID =4 THEN CLPH_PHONE ELSE NULL END AS CLIENT_CELL_PHONE
,CASE WHEN CLPH_ID =3 THEN CLPH_PHONE ELSE NULL END AS CLIENT_WORK_PHONE
,MAX(COALESCE(T.ETL_LAST_UPDATED_DATE, ''1/1/1900'')) OVER (PARTITION BY CLPH_CLIENTID) AS ETL_LAST_UPDATED_DATE
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CLIENTPHONES T
)
SELECT DISTINCT
MD5(''MATRIXCARE'' || ''-'' || CLI_ID || ''-'' || ''MATRIXCARE'') AS CLIENT_KEY
,CLI_ID AS CLIENT_NUMBER
,UPPER(TRIM(CLI_FIRSTNAME)) AS CLIENT_FIRST_NAME
,SUBSTRING(UPPER(TRIM(CLI_MIDDLENAME)),1,10) AS CLIENT_MIDDLE_NAME
,UPPER(TRIM(CLI_LASTNAME)) AS CLIENT_LAST_NAME
,TO_DATE(CLI_BIRTHDATE) AS CLIENT_DOB
,UPPER(CLI_ADDRESS1) AS CLIENT_ADDRESS1
,UPPER(CLI_ADDRESS2) AS CLIENT_ADDRESS2
,UPPER(TRIM(CLI_CITY)) AS CLIENT_CITY
,TRIM(CLI_POSTALCODE) AS CLIENT_ZIP
,UPPER(TRIM(COALESCE(ST1.STATE_ISO_CODE, ST2.STATE_ISO_CODE, Z.STATE_ISO_CODE))) AS CLIENT_STATE_CODE
,CPH.CLIENT_HOME_PHONE
,CPH.CLIENT_CELL_PHONE
,CPH.CLIENT_WORK_PHONE
,UPPER(TRIM(COALESCE(CLI_EMAIL,CLI_EMAIL2))) AS CLIENT_PERSONAL_EMAIL
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CLIENT CLI
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_STATE ST1 ON ST1.STATE_ISO_CODE = CLI.CLI_STATEORPROVINCE
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_STATE ST2 ON ST1.STATE_ISO_CODE IS NULL AND UPPER(ST2.STATE_NAME) = UPPER(CLI.CLI_STATEORPROVINCE)
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_ZIP_CODE Z ON ST1.STATE_ISO_CODE IS NULL AND ST2.STATE_ISO_CODE IS NULL AND Z.ZIP_CODE = LEFT(TRIM(CLI.CLI_POSTALCODE), 5)
LEFT JOIN CLIENT_PHONENUMBER CPH ON CLI.CLI_ID = CPH.CLPH_CLIENTID
)
SELECT DISTINCT CLIENT_KEY,
    CLIENT_NUMBER ,
    CLIENT_FIRST_NAME ,
    CLIENT_MIDDLE_NAME ,
    CLIENT_LAST_NAME ,
    CLIENT_DOB  ,
    CLIENT_ADDRESS1,
    CLIENT_ADDRESS2,
    CLIENT_CITY,
    CLIENT_ZIP,
    CLIENT_STATE_CODE,
    CLIENT_WORK_PHONE,
    CLIENT_CELL_PHONE,
    CLIENT_HOME_PHONE,
    CLIENT_PERSONAL_EMAIL,
    MD5( ''MATRIXCARE'' || ''-'' || (MASTER_CLIENT_KEY::STRING) || ''-'' || ''MATRIXCARE'')  MASTER_CLIENT_KEY,
    MASTER_CLIENT_NUMBER,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG
    FROM (   
SELECT DISTINCT
    MC.CLIENT_KEY,
    MC.CLIENT_NUMBER ,
    MC.CLIENT_FIRST_NAME ,
    MC.CLIENT_MIDDLE_NAME ,
    MC.CLIENT_LAST_NAME ,
    MC.CLIENT_DOB  ,
    MC.CLIENT_ADDRESS1,
    MC.CLIENT_ADDRESS2,
    MC.CLIENT_CITY,
    MC.CLIENT_ZIP,
    MC.CLIENT_STATE_CODE,
    MC.CLIENT_WORK_PHONE,
    MC.CLIENT_CELL_PHONE,
    MC.CLIENT_HOME_PHONE,
    MC.CLIENT_PERSONAL_EMAIL
    ,CASE  
        WHEN (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5) AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) =
            SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND NVL(MC.CLIENT_DOB,''1800-01-01'') = NVL(DC.CLIENT_DOB,''1800-02-01'')) THEN
        MIN(MC.CLIENT_NUMBER) OVER (PARTITION BY SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5),SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5),MC.CLIENT_DOB)
        ELSE CASE
        WHEN (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5)
                AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND SUBSTRING(MC.CLIENT_ZIP,1,3)=SUBSTRING(DC.CLIENT_ZIP,1,3)
                    AND SUBSTRING(UPPER(TRIM(MC.CLIENT_ADDRESS1)),1,3) = SUBSTRING(UPPER(TRIM(DC.CLIENT_ADDRESS1)),1,3)) THEN
        MIN(MC.CLIENT_NUMBER) OVER (PARTITION BY SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5),SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5),
            SUBSTRING(MC.CLIENT_ZIP,1,3),SUBSTRING(UPPER(TRIM(MC.CLIENT_ADDRESS1)),1,3))   
        ELSE CASE
        WHEN (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5)
            AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND (MC.CLIENT_HOME_PHONE = DC.CLIENT_HOME_PHONE )) THEN
        MIN(MC.CLIENT_NUMBER) OVER (PARTITION BY SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5),SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5),
            MC.CLIENT_HOME_PHONE)
        ELSE CASE
        WHEN (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5)
            AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND (MC.CLIENT_WORK_PHONE = DC.CLIENT_WORK_PHONE)) THEN
        MIN(MC.CLIENT_NUMBER) OVER (PARTITION BY SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5),SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5),
            MC.CLIENT_WORK_PHONE)
        ELSE CASE
        WHEN (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5)
            AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND (MC.CLIENT_CELL_PHONE = DC.CLIENT_CELL_PHONE )) THEN
        MIN(MC.CLIENT_NUMBER) OVER (PARTITION BY SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5),SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5),
            MC.CLIENT_CELL_PHONE)
        ELSE CASE
        WHEN (SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND MC.CLIENT_PERSONAL_EMAIL = DC.CLIENT_PERSONAL_EMAIL ) THEN
        MIN(MC.CLIENT_NUMBER) OVER (PARTITION BY SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5), MC.CLIENT_PERSONAL_EMAIL)
        ELSE CASE
        WHEN (UPPER(TRIM(MC.CLIENT_FIRST_NAME)) = UPPER(TRIM(DC.CLIENT_FIRST_NAME)) AND UPPER(TRIM(MC.CLIENT_LAST_NAME)) = UPPER(TRIM(DC.CLIENT_LAST_NAME))
            AND TRIM(MC.CLIENT_ZIP) = TRIM(DC.CLIENT_ZIP) AND UPPER(TRIM(MC.CLIENT_ADDRESS1)) = UPPER(TRIM(DC.CLIENT_ADDRESS1)) AND MC.CLIENT_DOB = DC.CLIENT_DOB) THEN
        MIN(MC.CLIENT_NUMBER) OVER (PARTITION BY UPPER(TRIM(MC.CLIENT_FIRST_NAME)),UPPER(TRIM(MC.CLIENT_LAST_NAME)),TRIM(MC.CLIENT_ZIP),UPPER(TRIM(MC.CLIENT_ADDRESS1)), MC.CLIENT_DOB)
        ELSE NULL END
            END
                END
                    END
                        END
                            END
                                END PRE_MASTER_CLIENT_KEY,
CASE WHEN PRE_MASTER_CLIENT_KEY IN (''2707'',''3719'') THEN ''2062''
    WHEN PRE_MASTER_CLIENT_KEY IN (''7327'',''8152'') THEN ''3500''
    WHEN PRE_MASTER_CLIENT_KEY IN (''8055'',''7230'') THEN ''1566''
	WHEN PRE_MASTER_CLIENT_KEY IN (''3303'',''2885'') THEN ''2885''
	WHEN PRE_MASTER_CLIENT_KEY IN (''1566'',''7230'') THEN ''1566''
    WHEN PRE_MASTER_CLIENT_KEY IN (''19619'',''6223'') THEN ''19619''
    ELSE PRE_MASTER_CLIENT_KEY END MASTER_CLIENT_KEY,
CASE WHEN PRE_MASTER_CLIENT_KEY IN (''2707'',''3719'') THEN ''2062''
    WHEN PRE_MASTER_CLIENT_KEY IN (''7327'',''8152'') THEN ''3500''
	WHEN PRE_MASTER_CLIENT_KEY IN (''8055'',''7230'') THEN ''1566''
    WHEN PRE_MASTER_CLIENT_KEY IN (''3303'',''2885'') THEN ''2885''
	WHEN PRE_MASTER_CLIENT_KEY IN (''1566'',''7230'') THEN ''1566''
    WHEN PRE_MASTER_CLIENT_KEY IN (''19619'',''6223'') THEN ''19619''
    ELSE PRE_MASTER_CLIENT_KEY END MASTER_CLIENT_NUMBER
FROM DATA DC
JOIN (SELECT * FROM DATA) MC ON
    (UPPER(TRIM(MC.CLIENT_FIRST_NAME)) = UPPER(TRIM(DC.CLIENT_FIRST_NAME)) AND UPPER(TRIM(MC.CLIENT_LAST_NAME)) = UPPER(TRIM(DC.CLIENT_LAST_NAME))
        AND TRIM(MC.CLIENT_ZIP) = TRIM(DC.CLIENT_ZIP) AND UPPER(TRIM(MC.CLIENT_ADDRESS1)) = UPPER(TRIM(DC.CLIENT_ADDRESS1)) AND MC.CLIENT_DOB = DC.CLIENT_DOB)
OR
    (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5)
        AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND MC.CLIENT_DOB = DC.CLIENT_DOB)
OR
    (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5)
        AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5) AND SUBSTRING(MC.CLIENT_ZIP,1,5)=SUBSTRING(DC.CLIENT_ZIP,1,5)
            AND SUBSTRING(UPPER(TRIM(MC.CLIENT_ADDRESS1)),1,5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_ADDRESS1)),1,5))
OR
    (SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5)
        AND SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5)
            AND (MC.CLIENT_HOME_PHONE = DC.CLIENT_HOME_PHONE OR MC.CLIENT_WORK_PHONE = DC.CLIENT_WORK_PHONE OR MC.CLIENT_CELL_PHONE = DC.CLIENT_CELL_PHONE ))
OR
    (SUBSTRING(UPPER(TRIM(MC.CLIENT_LAST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_LAST_NAME)), 1, 5)
        AND SUBSTRING(UPPER(TRIM(MC.CLIENT_FIRST_NAME)), 1, 5) = SUBSTRING(UPPER(TRIM(DC.CLIENT_FIRST_NAME)), 1, 5) AND MC.CLIENT_PERSONAL_EMAIL = DC.CLIENT_PERSONAL_EMAIL )   
WHERE  DC.CLIENT_NUMBER <> MC.CLIENT_NUMBER
ORDER BY
    MC.CLIENT_FIRST_NAME ,
    MC.CLIENT_LAST_NAME ,
    MC.CLIENT_DOB  ,
    MC.CLIENT_NUMBER,
    MC.CLIENT_ZIP,
    MC.CLIENT_ADDRESS1
    );
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}


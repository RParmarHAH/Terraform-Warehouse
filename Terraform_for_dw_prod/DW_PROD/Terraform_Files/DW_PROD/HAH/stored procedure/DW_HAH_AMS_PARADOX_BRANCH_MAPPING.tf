resource "snowflake_procedure" "DW_HAH_AMS_PARADOX_BRANCH_MAPPING" {
	name ="AMS_PARADOX_BRANCH_MAPPING"
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

                BEGIN
    --*****************************************************************************************************************************
-- NAME:  AMS_PARADOX_BRANCH_MAPPING
--
-- PURPOSE: This table is created for mapping PARADOX branches with AMS branches
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                               NOTES:
-- --------    -------------------                  ---------------------------------------------------------------------------
-- 15/09/2022  Harshala Kadam      Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.HAH.AMS_PARADOX_BRANCH_MAPPING ( 
SELECT DISTINCT BR.BRANCH_KEY,BR.ORIGINAL_SOURCE_SYSTEM_ID,B.SYSTEM_CODE,BR.SYSTEM_CODE,UPPER(CANDIDATE_LOCATION__LEVEL_1)AS CANDIDATE_LOCATION__LEVEL_1,UPPER(CANDIDATE_LOCATION__LEVEL_2)AS CANDIDATE_LOCATION__LEVEL_2,CANDIDATE_LOCATION__LEVEL_3,ORIGINAL_BRANCH_NAME,BR.OFFICE_STATE_CODE  FROM 
DISC_${var.SF_ENVIRONMENT}.PARADOX.CANDIDATE_SPECIFIC CAND
INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_BRANCH_MERGED  BR 
  ON (
            (
                CANDIDATE_LOCATION__LEVEL_1 IN (''Illinois'',  ''Illinois - Northwest'', ''Illinois - Chicagoland'') 
                AND ORIGINAL_SOURCE_SYSTEM_ID = 3 
                AND UPPER( BR.ORIGINAL_BRANCH_NAME) = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)), ''ST. CHARLES'', ''ST CHARLES''), ''OAK PARK'', ''OAKPARK''), ''OAK LAWN'', ''OAKLAWN''), ''EAST SIDE CHICAGO'', ''EAST SIDE''),''GLEN ELLYN'',''WHEATON'')---OAKLAWN OAK LAWN
            )
            OR 
            (
                CANDIDATE_LOCATION__LEVEL_1 = ''Illinois - South'' --AND CANDIDATE_LOCATION__LEVEL_2 = ''Central'' 
                AND ORIGINAL_SOURCE_SYSTEM_ID = 3 
                AND UPPER( BR.ORIGINAL_BRANCH_NAME) = UPPER(REPLACE(REPLACE(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2), ''MT. VERNON'', ''Mt Vernon''), ''Danville, IL'', ''Danville''))
            )
            OR
            (
            CANDIDATE_LOCATION__LEVEL_1 = ''Illinois - South'' AND CANDIDATE_LOCATION__LEVEL_2 = ''Central'' 
                AND ORIGINAL_SOURCE_SYSTEM_ID = 3 
                AND UPPER( BR.ORIGINAL_BRANCH_NAME) = UPPER(REPLACE(REPLACE(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_3), ''MT. VERNON'', ''Mt Vernon''), ''Danville, IL'', ''Danville''))

            )
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 =''Pennsylvania''
            	AND ORIGINAL_SOURCE_SYSTEM_ID IN (4)
            	AND UPPER( BR.ORIGINAL_BRANCH_NAME) = UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2))
            )
             OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 =''Pennsylvania''
            	AND ORIGINAL_SOURCE_SYSTEM_ID IN (17)
            	AND UPPER( BR.ORIGINAL_BRANCH_NAME) = UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2))
            )
           OR 
          (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Georgia''
            	AND ORIGINAL_SOURCE_SYSTEM_ID IN(9)
                AND UPPER( BR.ORIGINAL_BRANCH_NAME) IN ( 
            	REPLACE(REGEXP_REPLACE(UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)), '' OFFICE'', ''''),''SAVANNAH SAV'',''SAVANNAH - SAV''),
            	REPLACE(REGEXP_REPLACE(UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)), '' OFFICE'', ''''),''SAVANNAH SCL'',''SAVANNAH - SCL''),
            	REPLACE(REGEXP_REPLACE(UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)), '' OFFICE'', ''''),''ATLANTA NORTH EAST'',''ATLANTA - NORTH EAST''),
            	REPLACE(REGEXP_REPLACE(UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)), '' OFFICE'', ''''),''ATLANTA'',''ATLANTA - CENTRAL''))
            )
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Georgia''
            	AND ORIGINAL_SOURCE_SYSTEM_ID IN(1)
                AND UPPER( BR.ORIGINAL_BRANCH_NAME) IN (REGEXP_REPLACE((UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2))), '' OFFICE'', ''''))
                AND ((UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)) IN (''WISTERIA GARDENS'',''WAVERLY GARDENS'',''WISTERIA GARDENS OFFICE'',''WAVERLY GARDENS OFFICE''))
                	OR (UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)) IN (''CAMDEN PLACE'',''CAMDEN PLACE OFFICE'') AND ORIGINAL_OFFICE_CODE=''CAM''))
            )
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Missouri'' 
            	AND ORIGINAL_SOURCE_SYSTEM_ID  = 3 AND OFFICE_STATE_CODE = ''MO'' 
            	AND UPPER( BR.ORIGINAL_BRANCH_NAME) IN (UPPER(TRIM(REPLACE(CAND.CANDIDATE_LOCATION__LEVEL_2, ''.'', ''''))), UPPER(TRIM(REPLACE(CAND.CANDIDATE_LOCATION__LEVEL_2, ''St.'', ''SAINT''))))
            )
            -- OR (CANDIDATE_LOCATION__LEVEL_1 = ''Ohio'' AND ORIGINAL_SOURCE_SYSTEM_ID  = 12 AND OFFICE_STATE_CODE = ''OH'' AND UPPER( BR.ORIGINAL_BRANCH_NAME) = UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)) AND CANDIDATE_LOCATION__LEVEL_2 NOT IN (''Columbus'', ''Toledo'', ''Dayton''))
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Ohio'' 
            	AND ORIGINAL_SOURCE_SYSTEM_ID  = 13
            	AND OFFICE_STATE_CODE = ''OH'' 
                AND UPPER( BR.ORIGINAL_BRANCH_NAME) = UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)) AND UPPER(CANDIDATE_LOCATION__LEVEL_2) IN (''DAYTON'')
             )
           OR 
           (
           		CANDIDATE_LOCATION__LEVEL_1 = ''Ohio'' AND ORIGINAL_SOURCE_SYSTEM_ID  = 16 
           		AND OFFICE_STATE_CODE = ''OH'' 
             AND (UPPER( REPLACE(BR.ORIGINAL_BRANCH_NAME, '' (GIRARD)'')) = UPPER(TRIM(CANDIDATE_LOCATION__LEVEL_2)) 
             AND CANDIDATE_LOCATION__LEVEL_2 IN (''Cleveland'',  ''Youngstown'',''YOUNGSTOWN''))
           )
		   OR 
           (
           		CANDIDATE_LOCATION__LEVEL_1 = ''Ohio'' AND ORIGINAL_SOURCE_SYSTEM_ID  = 14
 
           		AND OFFICE_STATE_CODE = ''OH'' 
 				AND(( UPPER(TRIM(CANDIDATE_LOCATION__LEVEL_2)) ILIKE ''CANTON%'' AND UPPER(TRIM(BR.ORIGINAL_BRANCH_NAME))=''HAH CANTON'')
           		OR (UPPER(TRIM(CANDIDATE_LOCATION__LEVEL_2))=''COLUMBUS'' AND UPPER(TRIM(BR.ORIGINAL_BRANCH_NAME))=''HAH COLUMBUS'')
                OR (UPPER(TRIM(CANDIDATE_LOCATION__LEVEL_2)) ILIKE ''TOLEDO%'' AND UPPER(TRIM(BR.ORIGINAL_BRANCH_NAME))=''HAH TOLEDO''))    
        )
           OR 
             (
             	CANDIDATE_LOCATION__LEVEL_1 = ''Adaptive Indiana'' 
             	AND ORIGINAL_SOURCE_SYSTEM_ID = 7 
                AND UPPER(REPLACE(BR.ORIGINAL_BRANCH_NAME, ''A_'', '''')) = UPPER(REPLACE(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2),''bedford, in'',''Bedford''))
             )
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Indiana'' 
            	AND ORIGINAL_SOURCE_SYSTEM_ID = 7 AND ORIGINAL_BRANCH_NAME LIKE ''H_%''
               AND REPLACE(UPPER( BR.ORIGINAL_BRANCH_NAME), ''H_'', '''') = UPPER(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2),''CROWN POINT (SHERERVILLE)'',''CROWN POINT''),''Schererville'',''CROWN POINT'' ),''INDIANAPOLIS (INDY AVON)'',''INDY AVON''),''INDIANAPOLIS AVON'',''INDY AVON''))
             )
             OR 
             (
             	CANDIDATE_LOCATION__LEVEL_1 = ''Alabama'' AND ORIGINAL_SOURCE_SYSTEM_ID = 9 AND BR.SYSTEM_CODE = ''ALABAMA (3554)''
                AND REPLACE(UPPER( BR.ORIGINAL_BRANCH_NAME), ''/HUNTSVILLE'') = UPPER(REPLACE(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2),''Birmingham Branch'',''Birmingham'')))
            OR (
            		CANDIDATE_LOCATION__LEVEL_1 IN (''Illinois - Chicago'',''Chicago'') AND ORIGINAL_SOURCE_SYSTEM_ID  = 3 AND OFFICE_STATE_CODE = ''IL'' 
                    AND UPPER( BR.ORIGINAL_BRANCH_NAME) IN (UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)), UPPER(TRIM(REPLACE(REPLACE(REPLACE(CAND.CANDIDATE_LOCATION__LEVEL_2,''St. Charles'', ''ST CHARLES''),''St.'', ''St. ''),''DOWNTOWN CHICAGO'',''CHICAGO''))))
                )
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Michigan'' AND ORIGINAL_SOURCE_SYSTEM_ID IN (3,7) AND ORIGINAL_BRANCH_NAME LIKE ''MI_%''
                AND REPLACE(UPPER( BR.ORIGINAL_BRANCH_NAME), ''MI_'', '''') = UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2))
             ) 
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Delaware'' AND ORIGINAL_SOURCE_SYSTEM_ID = 17
                AND UPPER(BR.ORIGINAL_BRANCH_NAME) = REPLACE(UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2)), '', DE'')
            )
            OR 
            (
            	CANDIDATE_LOCATION__LEVEL_1 = ''Mississippi'' AND ORIGINAL_SOURCE_SYSTEM_ID  = 3 AND OFFICE_STATE_CODE = ''MS''
            	AND UPPER( REPLACE(BR.ORIGINAL_BRANCH_NAME, ''JACKSON 2/'')) = UPPER(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2))
            )
            OR 
            (
                CANDIDATE_LOCATION__LEVEL_1 IN (''Prime HHA'', ''Prime Home Care, LLC'') AND ORIGINAL_SOURCE_SYSTEM_ID  = 13  
                AND UPPER(BR.ORIGINAL_BRANCH_NAME) = UPPER(TRIM(REPLACE(REPLACE(CAND.CANDIDATE_LOCATION__LEVEL_2, ''Court House'', ''CH''), ''Maineville'', ''CINCINNATI'')))
             )
            OR 
            (
                CANDIDATE_LOCATION__LEVEL_1 = ''Prime Homecare Midway'' AND ORIGINAL_SOURCE_SYSTEM_ID  = 14 
                AND BR.BRANCH_SERVICE_LINE = ''HC''
                AND UPPER(BR.ORIGINAL_BRANCH_NAME) = UPPER(REPLACE(TRIM(CAND.CANDIDATE_LOCATION__LEVEL_2),''Mansfield'',''PRIME MANSFIELD''))
                )
          )
 INNER JOIN  dw_prod.hah.dim_source_system b on BR.ORIGINAL_SOURCE_SYSTEM_ID=B.SOURCE_SYSTEM_ID);
 
 RETURN ''SUCCESS'';
    END;
    
 EOT
}


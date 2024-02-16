resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_HM_FACT_SURVEY_QUESTION" {
	name ="MERGE_STAGE_HM_FACT_SURVEY_QUESTION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT


    var sqlCmd = "";
    var sqlStmt = "";
    var result = "";

    try {
      var sqlCmd = `
    MERGE INTO HAH.FACT_SURVEY_QUESTION FSQ
USING STAGE.HM_FACT_SURVEY_QUESTION STAGE 
ON FSQ.SURVEY_QUESTION_KEY = STAGE.SURVEY_QUESTION_KEY
WHEN MATCHED THEN 
UPDATE SET 
	FSQ.SURVEY_KEY=	STAGE.SURVEY_KEY,
	FSQ.SURVEY_ID=	STAGE.SURVEY_ID,
	FSQ.SOURCE_SYSTEM_ID =STAGE.SOURCE_SYSTEM_ID,
	FSQ.SYSTEM_CODE=STAGE.SYSTEM_CODE, 
	FSQ.QUESTION_ID=	STAGE.QUESTION_ID,
	FSQ.QUESTION_TEXT=	STAGE.QUESTION_TEXT,
	FSQ.QUESTION_CATEGORY=	STAGE.QUESTION_CATEGORY,
	FSQ.IS_ACTIVE=	STAGE.IS_ACTIVE,
	FSQ.ETL_TASK_KEY=	STAGE.ETL_TASK_KEY,
	FSQ.ETL_INSERTED_TASK_KEY=	STAGE.ETL_INSERTED_TASK_KEY,
	FSQ.ETL_INSERTED_DATE=	STAGE.ETL_INSERTED_DATE,
	FSQ.ETL_INSERTED_BY=	STAGE.ETL_INSERTED_BY,
	FSQ.ETL_LAST_UPDATED_DATE=	STAGE.ETL_LAST_UPDATED_DATE,
	FSQ.ETL_LAST_UPDATED_BY=	STAGE.ETL_LAST_UPDATED_BY,
	FSQ.ETL_DELETED_FLAG=	STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    SURVEY_QUESTION_KEY,
	SURVEY_KEY,
	SURVEY_ID,
	QUESTION_ID,
	QUESTION_TEXT,
	QUESTION_CATEGORY,
	IS_ACTIVE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) 
VALUES (
	STAGE.SURVEY_QUESTION_KEY,
	STAGE.SURVEY_KEY,
	STAGE.SURVEY_ID,
	STAGE.QUESTION_ID,
	STAGE.QUESTION_TEXT,
	STAGE.QUESTION_CATEGORY,
	STAGE.IS_ACTIVE,
	STAGE.ETL_TASK_KEY,
	STAGE.ETL_INSERTED_TASK_KEY,
	STAGE.ETL_INSERTED_DATE,
	STAGE.ETL_INSERTED_BY,
	STAGE.ETL_LAST_UPDATED_DATE,
	STAGE.ETL_LAST_UPDATED_BY,
	STAGE.ETL_DELETED_FLAG
)

    `;
      sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
      rs = sqlStmt.execute();
      sqlCmd = 
            `SELECT "number of rows inserted", "number of rows updated"
              FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))`;
      sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
      rs = sqlStmt.execute();
          rs.next();
          result += ''{"Inserted": "'' + rs.getColumnValue(1) + ''", "Updated": "'' + rs.getColumnValue(2) +''", "ErrorCode":"NA", "ErrorState":"NA", "ErrorMessage":"NA", "ErrorStackTrace":"NA"}'';
    }
    catch (err) {
        result = ''{"Inserted": "0", "Updated": "0", "ErrorCode":"''+ err.code +''", "ErrorState":"''+ err.state +''", "ErrorMessage":"''+ err.message +''", "ErrorStackTrace":"''+ err.stackTraceTxt +''"}'';
    }
    return result;
    
 EOT
}


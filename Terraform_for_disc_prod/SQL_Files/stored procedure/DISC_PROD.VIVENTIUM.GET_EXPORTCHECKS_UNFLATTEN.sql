CREATE OR REPLACE PROCEDURE DISC_PROD.VIVENTIUM.GET_EXPORTCHECKS_UNFLATTEN("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
BEGIN 
    --TargetSQL
    insert  into disc_prod.viventium.hist_exportchecks_unflatten select  j.$1:employeeKey  as  employeeKey, j.$1:employeeNumber  as  employeeNumber, j.$1:divisionKey:companyCode  as  companyCode, j.$1:divisionKey:divisionCode  as  divisionCode, j.$1:checkKey  as  checkKey, j.$1:checkDate  as  checkDate, j.$1:runNumber  as  runNumber, j.$1:periodBeginDate  as  periodBeginDate, j.$1:periodEndDate  as  periodEndDate, j.$1:payMethod  as  payMethod, j.$1:checkNumber  as  checkNumber, j.$1:voucherNumber  as  voucherNumber, j.$1:checkOrVoucherNumber  as  checkOrVoucherNumber, j.$1:totalWorkedHours  as  totalWorkedHours, j.$1:totalHours  as  totalHours, j.$1:totalGross  as  totalGross, j.$1:totalDeductions  as  totalDeductions, j.$1:totalTaxes  as  totalTaxes, j.$1:netCheckAmount  as  netCheckAmount, j.$1:netDirectDepositAmount  as  netDirectDepositAmount, j.$1:totalNet  as  totalNet, j.$1:taxes as taxes, j.$1:earnings  as earnings, j.$1:deductions as  deductions, j.$1:costCenters as costCenters, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE, CURRENT_USER AS ETL_INSERTED_BY , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE, CURRENT_USER AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG, 0 AS ETL_INFERRED_MEMBER_FLAG from @disc_prod.STAGE.AWSAZSTAGEPROD/Viventium/Daily_Files/ExportChecks/ (file_format => disc_prod.PUBLIC.MY_JSON_FORMAT) j;

    --ViewSQL
    CREATE OR REPLACE TABLE disc_prod.VIVENTIUM.EXPORTCHECKS_unflatten AS  WITH curr_v AS ( SELECT employeekey,employeenumber , max(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE  FROM disc_prod.VIVENTIUM.HIST_EXPORTCHECKS_unflatten GROUP BY employeekey,employeenumber ) SELECT HE.* EXCLUDE ETL_DELETED_FLAG, CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE HE.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG   FROM disc_prod.VIVENTIUM.HIST_EXPORTCHECKS_unflatten HE   INNER JOIN curr_v v ON HE.employeekey = v.employeekey AND HE.employeenumber = v.employeenumber   AND HE.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';
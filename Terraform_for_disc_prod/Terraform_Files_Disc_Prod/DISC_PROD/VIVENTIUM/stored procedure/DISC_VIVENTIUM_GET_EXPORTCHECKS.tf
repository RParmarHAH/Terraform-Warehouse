resource "snowflake_procedure" "DISC_VIVENTIUM_GET_EXPORTCHECKS" {
	name ="GET_EXPORTCHECKS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN 
    --TargetSQL
    insert into disc_prod.viventium.hist_exportchecks select  j.$1:employeeKey  as  employeeKey, j.$1:employeeNumber  as  employeeNumber, j.$1:divisionKey:companyCode  as  companyCode, j.$1:divisionKey:divisionCode  as  divisionCode, j.$1:checkKey  as  checkKey, j.$1:checkDate  as  checkDate, j.$1:runNumber  as  runNumber, j.$1:periodBeginDate  as  periodBeginDate, j.$1:periodEndDate  as  periodEndDate, j.$1:payMethod  as  payMethod, j.$1:checkNumber  as  checkNumber, j.$1:voucherNumber  as  voucherNumber, j.$1:checkOrVoucherNumber  as  checkOrVoucherNumber, j.$1:totalWorkedHours  as  totalWorkedHours, j.$1:totalHours  as  totalHours, j.$1:totalGross  as  totalGross, j.$1:totalDeductions  as  totalDeductions, j.$1:totalTaxes  as  totalTaxes, j.$1:netCheckAmount  as  netCheckAmount, j.$1:netDirectDepositAmount  as  netDirectDepositAmount, j.$1:totalNet  as  totalNet, j.$1:taxes as taxes, j2.VALUE:grossWages  AS taxes_grossWages, j2.VALUE:taxAmount  as taxes_taxAmount, j2.VALUE:taxCode  as taxes_taxcode, j2.VALUE:taxableWages as taxes_taxableWages,  j.$1:earnings  as earnings, j3.value:earningCode  as  earnings_earningCode, j3.value:hours  as  earnings_hours, j3.value:rate  as  earnings_rate, j3.value:amount as  earnings_amount, j3.value:chargeDate  as  earnings_chargeDate, j3.value:jobCode  as  earnings_jobCode, j3.value:in1  as  earnings_in1, j3.value:out1  as  earnings_out1, j3.value:in2  as  earnings_in2, j3.value:out2  as  earnings_out2, j3.value:memo  as  earnings_memo, j3.value:internalMemo  as  earnings_internalMemo, j3.value:costCenters  as  earnings_costCenters, j.$1:deductions as  deductions, j4.value:amount as deductions_amount, j4.value:deductionCode as deductions_deductionCode, j4.value:memoOnly as deductions_memoOnly, j4.value:payeeCode as deductions_payeeCode, j4.value:payeeKey as deductions_payeeKey, j.$1:costCenters as costCenters, j5.value:level as costCenters_level, j5.value:levelCode as costCenters_levelcode, j5.value:costCenterCode as costCenters_costcentercode, j5.value:costCenterDescription as costCenters_costCenterDescription, j5.value:groupCode as costCenters_groupCode, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE, CURRENT_USER AS ETL_INSERTED_BY , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE, CURRENT_USER AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG, 0 AS ETL_INFERRED_MEMBER_FLAG from @disc_prod.STAGE.AWSAZSTAGEPROD/Viventium/Daily_Files/ExportChecks/ (file_format => disc_prod.PUBLIC.MY_JSON_FORMAT) j, LATERAL FLATTEN(input =>j.$1:taxes,OUTER => TRUE) j2, LATERAL FLATTEN(input =>j.$1:earnings,OUTER => TRUE) j3,  LATERAL FLATTEN(input =>j.$1:deductions,OUTER => TRUE) j4,  LATERAL FLATTEN(input =>j.$1:costCenters,OUTER => TRUE) j5;

    --ViewSQL
    CREATE OR REPLACE TABLE disc_prod.VIVENTIUM.EXPORTCHECKS AS  WITH curr_v AS ( SELECT employeekey,employeenumber , max(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE  FROM disc_prod.VIVENTIUM.HIST_EXPORTCHECKS GROUP BY employeekey,employeenumber ) SELECT HE.* EXCLUDE ETL_DELETED_FLAG, CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE HE.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG   FROM disc_prod.VIVENTIUM.HIST_EXPORTCHECKS HE   INNER JOIN curr_v v ON HE.employeekey = v.employeekey AND HE.employeenumber = v.employeenumber   AND HE.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}


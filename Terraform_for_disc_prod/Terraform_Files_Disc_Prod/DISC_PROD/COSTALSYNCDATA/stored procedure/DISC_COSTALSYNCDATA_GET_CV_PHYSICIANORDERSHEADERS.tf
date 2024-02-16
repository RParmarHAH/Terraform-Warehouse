resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_PHYSICIANORDERSHEADERS" {
	name ="GET_CV_PHYSICIANORDERSHEADERS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_PhysicianOrdersHeaders 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_PhysicianOrdersHeaders FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Patient_Number, t.$8 AS Admission_Number, t.$9 AS Order_Number, t.$10 AS Progress_Notes_Number, t.$11 AS Send_Date, t.$12 AS Send_Time, t.$13 AS Statrt_Date, t.$14 AS Start_Time, t.$15 AS End__Date, t.$16 AS End_Time, t.$17 AS Provider_Code, t.$18 AS Nurse_ID, t.$19 AS DDL_Physician_Order_Stat, t.$20 AS Discipline_Code, t.$21 AS Order_Type, t.$22 AS Medication_Code, t.$23 AS Route_Number, t.$24 AS Frequency_Code, t.$25 AS Frequency_Units_Arr2_1, t.$26 AS Frequency_Units_Arr2_2, t.$27 AS Frequency_Int, t.$28 AS DDL_Units_Freq_Type, t.$29 AS Format, t.$30 AS Time_Code, t.$31 AS Prescription_Number, t.$32 AS DDL_Order_Control_Codes, t.$33 AS Previous_Order_Number, t.$34 AS Interface_Unique_ID, t.$35 AS LengthValue, t.$36 AS DDL_Visits_Duration_Type, t.$37 AS DDL_Order_Type_Group, t.$38 AS Physician_Order_Code, t.$39 AS Dose, t.$40 AS CB_Ready_To_Print, t.$41 AS CB_Printed, t.$42 AS Last_Printed_Date, t.$43 AS Number_Of_Refills, t.$44 AS Refills_Completed, t.$45 AS Last_Refill_Date, t.$46 AS Order_Cycle_Code, t.$47 AS Inventory_Order_Cycle, t.$48 AS Quantity, t.$49 AS Pharmacy_Code, t.$50 AS Medication_Description, t.$51 AS Cert_Tran_Number, t.$52 AS FDB_NDC, t.$53 AS CB_RFB, t.$54 AS DDL_Portal_Order_Status, t.$55 AS CP_Purpose, t.$56 AS CB_Sign_By_Portal, t.$57 AS New_Date, t.$58 AS New_Time, t.$59 AS In_Process_Date, t.$60 AS In_Process_Time, t.$61 AS Completed_Date, t.$62 AS Completed_Time, t.$63 AS Sent_Date, t.$64 AS Sent_Time, t.$65 AS Receive_Date, t.$66 AS Receive_Time, t.$67 AS Signed_Date, t.$68 AS Signed_Time, t.$69 AS Approved_Date, t.$70 AS Approved_Time, t.$71 AS Denied_Date, t.$72 AS Denied_Time, t.$73 AS Discontinued_Date, t.$74 AS Discontinued_Time, t.$75 AS Closed_Date, t.$76 AS Closed_Time, t.$77 AS Changed_Date, t.$78 AS Changed_Time, t.$79 AS Clarify_Date, t.$80 AS Clarify_Time, t.$81 AS Corrected_Date, t.$82 AS Corrected_Time, t.$83 AS Modified_Date, t.$84 AS Modified_Time, t.$85 AS Inactivated_Date, t.$86 AS Inactivated_Time, t.$87 AS Last_Order_Date, t.$88 AS Last_Requirement_Created, t.$89 AS CB_SQL_Upgrade_01, t.$90 AS Duration_INT10_1, t.$91 AS Duration_INT10_2, t.$92 AS Duration_INT10_3, t.$93 AS Duration_INT10_4, t.$94 AS Duration_INT10_5, t.$95 AS Duration_INT10_6, t.$96 AS Duration_INT10_7, t.$97 AS Duration_INT10_8, t.$98 AS Duration_INT10_9, t.$99 AS Duration_INT10_10, t.$100 AS DDL_Duration_Type_Arr2_1, t.$101 AS DDL_Duration_Type_Arr2_2, t.$102 AS Take_Quantity, t.$103 AS CB_Dispense_as_Prescribe, t.$104 AS CB_Substitute, t.$105 AS Pharmacy_Code_From, t.$106 AS DDL_Transmit_Option, t.$107 AS CB_OTC, t.$108 AS CB_Covered, t.$109 AS CB_Other_Pres, t.$110 AS DDL_Medication_Status, t.$111 AS CP_Clinical_Note_Number, t.$112 AS Care_Plan_Number, t.$113 AS CP_Wound_Number, t.$114 AS Order_Number2, t.$115 AS Outside_Facility_Code, t.$116 AS Pres_Loc_ID, t.$117 AS Note30, t.$118 AS Last_EPresc_Status, t.$119 AS Pharmacy_Rx_Ref_No, t.$120 AS DDL_Quantity_Qualifier, t.$121 AS DDL_Refill_Qty_Qualifier, t.$122 AS CB_Reopen, t.$123 AS Reopen_User, t.$124 AS Reopen_Date, t.$125 AS Reopen_Time, t.$126 AS CB_Controlled_Drug, t.$127 AS DDL_Order_By, t.$128 AS Medication_Category, t.$129 AS CB_Stat_Order, t.$130 AS CB_Treatment, t.$131 AS Covered_Reason_Code, t.$132 AS CB_Start_of_Care, t.$133 AS CB_Resumption_of_Care, t.$134 AS CB_Hold, t.$135 AS Hold_From, t.$136 AS Hold_Until, t.$137 AS CB_Self_Administered, t.$138 AS CB_Order_Read_Back, t.$139 AS Order_Read_Back_To, t.$140 AS DEX_ROW_ID, t.$141 AS Discontinued_Note, t.$142 AS SYS_CHANGE_VERSION, t.$143 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$143,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PhysicianOrdersHeaders.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_PhysicianOrdersHeaders AS WITH curr_v AS (SELECT Db, Order_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PhysicianOrdersHeaders GROUP BY Db, Order_Number) SELECT t.* FROM CostalSyncData.HIST_CV_PhysicianOrdersHeaders t INNER JOIN curr_v v ON t.Db = v.Db AND t.Order_Number = v.Order_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}


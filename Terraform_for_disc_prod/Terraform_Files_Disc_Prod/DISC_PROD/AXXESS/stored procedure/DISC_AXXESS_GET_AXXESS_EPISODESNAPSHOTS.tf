resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_EPISODESNAPSHOTS" {
	name ="GET_AXXESS_EPISODESNAPSHOTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_EPISODESNAPSHOTS 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_EPISODESNAPSHOTS (SELECT A.$1 AS Branch_Id, A.$2 AS Episode_Id, A.$3 AS Patient_Id, A.$4 AS Account, A.$5 AS Branch, A.$6 AS Payor_Type, A.$7 AS Episode_Primary_Insurance_Name, A.$8 AS Date_Of_Birth, A.$9 AS Patient_Age, A.$10 AS Mrn, A.$11 AS Utn, A.$12 AS Referral_Date, A.$13 AS Episode_Discharge_Date, A.$14 AS Episode_Discharge_Reason, A.$15 AS Is_Pending, A.$16 AS Is_Admit, A.$17 AS Start_Of_Care_Date, A.$18 AS Episode_Start_Date, A.$19 AS Episode_End_Date, A.$20 AS Is_Recert, A.$21 AS Is_Lupa, A.$22 AS Is_Resumption_Of_Care, A.$23 AS Total_Supply_Cost, A.$24 AS Labor_Cost, A.$25 AS Non_Visit_Labor_Cost, A.$26 AS Mileage_Cost, A.$27 AS Non_Visit_Mileage_Cost, A.$28 AS Auto_Calculated_Mileage_Cost, A.$29 AS Auto_Calculated_Travel_Time_Cost, A.$30 AS Completed_Sn_Visit_Count, A.$31 AS Completed_Pt_Visit_Count, A.$32 AS Completed_Ot_Visit_Count, A.$33 AS Completed_St_Visit_Count, A.$34 AS Completed_Pta_Visit_Count, A.$35 AS Completed_Dietician_Visit_Count, A.$36 AS Completed_Hha_Visit_Count, A.$37 AS Completed_Cota_Visit_Count, A.$38 AS Completed_Msw_Visit_Count, A.$39 AS Completed_Lpn_Visit_Count, A.$40 AS Case_Manager_First_Name, A.$41 AS Case_Manager_Last_Name, A.$42 AS Patient_First_Name, A.$43 AS Patient_Last_Name, A.$44 AS Is_Discharged, A.$45 AS Patient_Status, A.$46 AS Episode_Timing, A.$47 AS Referral_Status, A.$48 AS Surcharge, A.$49 AS Payor_Class, A.$50 AS Admission_Discharge_Date, A.$51 AS Admission_Length_Of_Stay, A.$52 AS Is_Admission_Period_Discharged, A.$53 AS Admission_Status, A.$54 AS Is_Patient_Deleted, A.$55 AS Current_Primary_Insurance, A.$56 AS Missed_Msw_Visit_Count, A.$57 AS Missed_Sn_Visit_Count, A.$58 AS Missed_Therapy_Visit_Count, A.$59 AS CNA_HHA_Clinician_Visit_Count, A.$60 AS LPN_Clinician_Visit_Count, A.$61 AS RN_Clinician_Visit_Count, A.$62 AS Case_Manager_Name, A.$63 AS Email_Address, A.$64 AS Emergency_Contact_Address, A.$65 AS Emergency_Contact_Name, A.$66 AS Emergency_Contact_Phone, A.$67 AS Emergency_Contact_Relationship, A.$68 AS Gender, A.$69 AS HIC_Number, A.$70 AS MBI_Number, A.$71 AS Medicaid_Number, A.$72 AS NPI, A.$73 AS Phone, A.$74 AS Physician_Facsimile, A.$75 AS Physician_Name, A.$76 AS Physician_Phone, A.$77 AS Second_Utn, A.$78 AS Triage, A.$79 AS Is_Plan_Of_Care_Signed, A.$80 AS Evaluation_Therapy_POC_Other_Note_Orders_Signed, A.$81 AS Evaluation_Therapy_POC_Other_Note_Orders_UnSigned, A.$82 AS Face_To_Face_Orders_Signed, A.$83 AS Face_To_Face_Orders_UnSigned, A.$84 AS Medicaid_Plan_Of_Care_Orders_Signed, A.$85 AS Medicaid_Plan_Of_Care_Orders_UnSigned, A.$86 AS Physician_Orders_Signed, A.$87 AS Physician_Orders_UnSigned, A.$88 AS Plan_Of_Care_Orders_Signed, A.$89 AS Plan_Of_Care_Orders_UnSigned, A.$90 AS Plan_Of_Care_StandAlone_Orders_Signed, A.$91 AS Plan_Of_Care_StandAlone_Orders_UnSigned, A.$92 AS Total_Orders_Signed, A.$93 AS Total_Orders_UnSigned, A.$94 AS Plan_Of_Care_Order_Date, A.$95 AS Plan_Of_Care_Received_Date, A.$96 AS Death_Assessment_Date, A.$97 AS Death_Completed_By_Clinician_Date, A.$98 AS Death_Exported_Date, A.$99 AS Discharge_Assessment_Date, A.$100 AS Discharge_Completed_By_Clinician_Date, A.$101 AS Discharge_Exported_Date, A.$102 AS Discharge_Non_Visit_Assessment_Date, A.$103 AS Discharge_Non_Visit_Completed_By_Clinician_Date, A.$104 AS Discharge_Non_Visit_Exported_Date, A.$105 AS FollowUp_Assessment_Date, A.$106 AS FollowUp_Completed_By_Clinician_Date, A.$107 AS FollowUp_Exported_Date, A.$108 AS Recert_Assessment_Date, A.$109 AS Recert_Completed_By_Clinician_Date, A.$110 AS Recert_Exported_Date, A.$111 AS Resumption_Of_Care_Assessment_Date, A.$112 AS Resumption_Of_Care_Completed_By_Clinician_Date, A.$113 AS Resumption_Of_Care_Exported_Date, A.$114 AS Start_Of_Care_Assessment_Date, A.$115 AS Start_Of_Care_Completed_By_Clinician_Date, A.$116 AS Start_Of_Care_Exported_Date, A.$117 AS Transfer_Assessment_Date, A.$118 AS Transfer_Completed_By_Clinician_Date, A.$119 AS Transfer_Discharge_Assessment_Date, A.$120 AS Transfer_Discharge_Completed_By_Clinician_Date, A.$121 AS Transfer_Discharge_Exported_Date, A.$122 AS Transfer_Exported_Date, A.$123 AS Hospitalization_Reasons, A.$124 AS Policy_Number, A.$125 AS Is_Visit_Authorization_Required, A.$126 AS Clinical_Manager, A.$127 AS Primary_Clinician, A.$128 AS AddressLine_1, A.$129 AS AddressLine_2, A.$130 AS City, A.$131 AS County, A.$132 AS State, A.$133 AS ZipCode, A.$134 AS Primary_Group_Id, A.$135 AS Other_Physician_Name, A.$136 AS Certifying_Physician_Name, A.$137 AS Referring_Physician_Name, A.$138 AS PRIMARY_INSURANCE_ID, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/EpisodeSnapshots(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;

 EOT
}


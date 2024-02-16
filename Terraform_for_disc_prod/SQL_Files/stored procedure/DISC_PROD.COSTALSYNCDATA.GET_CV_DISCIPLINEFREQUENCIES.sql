CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_DISCIPLINEFREQUENCIES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_DisciplineFrequencies 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_DisciplineFrequencies FROM (SELECT t.$1 AS Db, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Patient_Number, t.$5 AS Admission_Number, t.$6 AS Sequence_Number, t.$7 AS Discipline_Sequence, t.$8 AS Service_Category_Code, t.$9 AS Line_Number, t.$10 AS Frequency_Units_Arr2_1, t.$11 AS Frequency_Units_Arr2_2, t.$12 AS Frequency_Int, t.$13 AS DDL_Units_Freq_Type, t.$14 AS LengthValue, t.$15 AS DDL_Visits_Duration_Type, t.$16 AS Format, t.$17 AS Order_Number, t.$18 AS Frequency_Code, t.$19 AS CB_Discrepancy, t.$20 AS DDL_Requirement_Status, t.$21 AS Treatment_Start_Date, t.$22 AS Treatment_End_Date, t.$23 AS Discipline_Order_Number, t.$24 AS Discharge_Reason_Code, t.$25 AS Reason_Date, t.$26 AS Weekly_Days_Array7_1, t.$27 AS Weekly_Days_Array7_2, t.$28 AS Weekly_Days_Array7_3, t.$29 AS Weekly_Days_Array7_4, t.$30 AS Weekly_Days_Array7_5, t.$31 AS Weekly_Days_Array7_6, t.$32 AS Weekly_Days_Array7_7, t.$33 AS Physician_Order_Number, t.$34 AS Cert_Tran_Number, t.$35 AS CB_Original, t.$36 AS Nurse_ID, t.$37 AS Actual_Frequency_End_Dt, t.$38 AS Freq_Start_Time1_Array_1, t.$39 AS Freq_Start_Time1_Array_2, t.$40 AS Freq_Start_Time1_Array_3, t.$41 AS Freq_Start_Time1_Array_4, t.$42 AS Freq_Start_Time1_Array_5, t.$43 AS Freq_Start_Time1_Array_6, t.$44 AS Freq_Start_Time1_Array_7, t.$45 AS Freq_End_Time1_Array_1, t.$46 AS Freq_End_Time1_Array_2, t.$47 AS Freq_End_Time1_Array_3, t.$48 AS Freq_End_Time1_Array_4, t.$49 AS Freq_End_Time1_Array_5, t.$50 AS Freq_End_Time1_Array_6, t.$51 AS Freq_End_Time1_Array_7, t.$52 AS Freq_Start_Time2_Array_1, t.$53 AS Freq_Start_Time2_Array_2, t.$54 AS Freq_Start_Time2_Array_3, t.$55 AS Freq_Start_Time2_Array_4, t.$56 AS Freq_Start_Time2_Array_5, t.$57 AS Freq_Start_Time2_Array_6, t.$58 AS Freq_Start_Time2_Array_7, t.$59 AS Freq_End_Time2_Array_1, t.$60 AS Freq_End_Time2_Array_2, t.$61 AS Freq_End_Time2_Array_3, t.$62 AS Freq_End_Time2_Array_4, t.$63 AS Freq_End_Time2_Array_5, t.$64 AS Freq_End_Time2_Array_6, t.$65 AS Freq_End_Time2_Array_7, t.$66 AS Freq_Start_Time3_Array_1, t.$67 AS Freq_Start_Time3_Array_2, t.$68 AS Freq_Start_Time3_Array_3, t.$69 AS Freq_Start_Time3_Array_4, t.$70 AS Freq_Start_Time3_Array_5, t.$71 AS Freq_Start_Time3_Array_6, t.$72 AS Freq_Start_Time3_Array_7, t.$73 AS Freq_End_Time3_Array_1, t.$74 AS Freq_End_Time3_Array_2, t.$75 AS Freq_End_Time3_Array_3, t.$76 AS Freq_End_Time3_Array_4, t.$77 AS Freq_End_Time3_Array_5, t.$78 AS Freq_End_Time3_Array_6, t.$79 AS Freq_End_Time3_Array_7, t.$80 AS Number_Array_1, t.$81 AS Number_Array_2, t.$82 AS Number_Array_3, t.$83 AS Number_Array_4, t.$84 AS Number_Array_5, t.$85 AS Number_Array_6, t.$86 AS Number_Array_7, t.$87 AS Service_Category1_Arr7_1, t.$88 AS Service_Category1_Arr7_2, t.$89 AS Service_Category1_Arr7_3, t.$90 AS Service_Category1_Arr7_4, t.$91 AS Service_Category1_Arr7_5, t.$92 AS Service_Category1_Arr7_6, t.$93 AS Service_Category1_Arr7_7, t.$94 AS Service_Category2_Arr7_1, t.$95 AS Service_Category2_Arr7_2, t.$96 AS Service_Category2_Arr7_3, t.$97 AS Service_Category2_Arr7_4, t.$98 AS Service_Category2_Arr7_5, t.$99 AS Service_Category2_Arr7_6, t.$100 AS Service_Category2_Arr7_7, t.$101 AS Service_Category3_Arr7_1, t.$102 AS Service_Category3_Arr7_2, t.$103 AS Service_Category3_Arr7_3, t.$104 AS Service_Category3_Arr7_4, t.$105 AS Service_Category3_Arr7_5, t.$106 AS Service_Category3_Arr7_6, t.$107 AS Service_Category3_Arr7_7, t.$108 AS Nurse_ID1_Arr7_1, t.$109 AS Nurse_ID1_Arr7_2, t.$110 AS Nurse_ID1_Arr7_3, t.$111 AS Nurse_ID1_Arr7_4, t.$112 AS Nurse_ID1_Arr7_5, t.$113 AS Nurse_ID1_Arr7_6, t.$114 AS Nurse_ID1_Arr7_7, t.$115 AS Nurse_ID2_Arr7_1, t.$116 AS Nurse_ID2_Arr7_2, t.$117 AS Nurse_ID2_Arr7_3, t.$118 AS Nurse_ID2_Arr7_4, t.$119 AS Nurse_ID2_Arr7_5, t.$120 AS Nurse_ID2_Arr7_6, t.$121 AS Nurse_ID2_Arr7_7, t.$122 AS Nurse_ID3_Arr7_1, t.$123 AS Nurse_ID3_Arr7_2, t.$124 AS Nurse_ID3_Arr7_3, t.$125 AS Nurse_ID3_Arr7_4, t.$126 AS Nurse_ID3_Arr7_5, t.$127 AS Nurse_ID3_Arr7_6, t.$128 AS Nurse_ID3_Arr7_7, t.$129 AS RB_Pattern_Type, t.$130 AS Service_Category_2, t.$131 AS Patient_Plan, t.$132 AS CB_POC, t.$133 AS CB_Discontinue, t.$134 AS DEX_ROW_ID, t.$135 AS SYS_CHANGE_VERSION, t.$136 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$136,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_DisciplineFrequencies.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_DisciplineFrequencies AS WITH curr_v AS (SELECT Db, Patient_Number, Admission_Number, Sequence_Number, Discipline_Sequence, Line_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_DisciplineFrequencies GROUP BY Db, Patient_Number, Admission_Number, Sequence_Number, Discipline_Sequence, Line_Number) SELECT t.* FROM CostalSyncData.HIST_CV_DisciplineFrequencies t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Admission_Number = v.Admission_Number AND t.Sequence_Number = v.Sequence_Number AND t.Discipline_Sequence = v.Discipline_Sequence AND t.Line_Number = v.Line_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';
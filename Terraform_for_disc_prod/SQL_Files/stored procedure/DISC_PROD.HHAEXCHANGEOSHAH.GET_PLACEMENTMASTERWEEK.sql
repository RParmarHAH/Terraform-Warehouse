CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PLACEMENTMASTERWEEK("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_PlacementMasterWeek 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.PlacementMasterWeek (SELECT t.$1 AS OfficeID, t.$2 AS AgencyID, t.$3 AS PatientID, t.$4 AS MasterWeekheaderID, t.$5 AS MasterWeekFromDate, t.$6 AS MasterWeekToDate, t.$7 AS SaturdayFromTime, t.$8 AS SaturdayToTime, t.$9 AS SaturdayAideID, t.$10 AS SaturdayAssignmentID, t.$11 AS SaturdayRate, t.$12 AS SatPayRateID, t.$13 AS SaturdayPOC, t.$14 AS SatContractID1, t.$15 AS SatHours1, t.$16 AS SatMinutes1, t.$17 AS SatPayRateID1, t.$18 AS SatContractID2, t.$19 AS SatHours2, t.$20 AS SatMinutes2, t.$21 AS SatPayRateID2, t.$22 AS SatIncludeMileageExpense, t.$23 AS SundayFromTime, t.$24 AS SundayToTime, t.$25 AS SundayAideID, t.$26 AS SundayAssignmentID, t.$27 AS SundayRate, t.$28 AS SunPayRateID, t.$29 AS SundayPOC, t.$30 AS SunContractID1, t.$31 AS SunHours1, t.$32 AS SunMinutes1, t.$33 AS SunPayRateID1, t.$34 AS SunContractID2, t.$35 AS SunHours2, t.$36 AS SunMinutes2, t.$37 AS SunPayRateID2, t.$38 AS SunIncludeMileageExpense, t.$39 AS MondayFromTime, t.$40 AS MondayToTime, t.$41 AS MondayAideID, t.$42 AS MondayAssignmentID, t.$43 AS MondayRate, t.$44 AS MonPayRateID, t.$45 AS MondayPOC, t.$46 AS MonContractID1, t.$47 AS MonHours1, t.$48 AS MonMinutes1, t.$49 AS MonPayRateID1, t.$50 AS MonContractID2, t.$51 AS MonHours2, t.$52 AS MonMinutes2, t.$53 AS MonPayRateID2, t.$54 AS MonIncludeMileageExpense, t.$55 AS TuesdayFromTime, t.$56 AS TuesdayToTime, t.$57 AS TuesdayAideID, t.$58 AS TuesdayAssignmentID, t.$59 AS TuesdayRate, t.$60 AS TuePayRateID, t.$61 AS TuesdayPOC, t.$62 AS TueBillTo, t.$63 AS TueHours, t.$64 AS TueMinutes, t.$65 AS TuePayRateID1, t.$66 AS TueContractID2, t.$67 AS TueHours2, t.$68 AS TueMinutes2, t.$69 AS TuePayRateID2, t.$70 AS TueIncludeMileageExpense, t.$71 AS WednesdayFromTime, t.$72 AS WednesdayToTime, t.$73 AS WednesdayAideID, t.$74 AS WednesdayAssignmentID, t.$75 AS WednesdayRate, t.$76 AS WedPayRateID, t.$77 AS WednesdayPOC, t.$78 AS WedContractID1, t.$79 AS WedHours1, t.$80 AS WedMinutes1, t.$81 AS WedPayRateID1, t.$82 AS WedContractID2, t.$83 AS WedHours2, t.$84 AS WedMinutes2, t.$85 AS WedPayRateID2, t.$86 AS WedIncludeMileageExpense, t.$87 AS ThursdayFromTime, t.$88 AS ThursdayToTime, t.$89 AS ThursdayAideID, t.$90 AS ThursdayAssignmentID, t.$91 AS ThursdayRate, t.$92 AS ThuPayRateID, t.$93 AS ThursdayPOC, t.$94 AS ThuContractID1, t.$95 AS ThuHours1, t.$96 AS ThuMinutes1, t.$97 AS ThuPayRateID1, t.$98 AS ThuContractID2, t.$99 AS ThuHours2, t.$100 AS ThuMinutes2, t.$101 AS ThuPayRateID2, t.$102 AS ThuIncludeMileageExpense, t.$103 AS FridayFromTime, t.$104 AS FridayToTime, t.$105 AS FridayAideID, t.$106 AS FridayAssignmentID, t.$107 AS FridayRate, t.$108 AS FriPayRateID, t.$109 AS FridayPOC, t.$110 AS FriContractID1, t.$111 AS FriHours1, t.$112 AS FriMinutes1, t.$113 AS FriPayRateID1, t.$114 AS FriContractID2, t.$115 AS FriHours2, t.$116 AS FriMinutes2, t.$117 AS FriPayRateID2, t.$118 AS FriIncludeMileageExpense, t.$119 AS ModifiedDate, t.$120 AS SYS_CHANGE_VERSION, t.$121 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$121,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_PlacementMasterWeek.*[.]csv.gz'') T);

    return ''Success'';
END;
';
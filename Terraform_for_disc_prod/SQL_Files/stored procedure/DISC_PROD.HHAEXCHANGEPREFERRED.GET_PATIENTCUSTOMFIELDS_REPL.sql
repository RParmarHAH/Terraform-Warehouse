CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_PATIENTCUSTOMFIELDS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_PatientCustomFields_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.PatientCustomFields_REPL (SELECT t.$1 AS AgencyID, t.$2 AS PatientCustomFieldID, t.$3 AS PatientID, t.$4 AS Text1, t.$5 AS Text2, t.$6 AS Text3, t.$7 AS Text4, t.$8 AS Text5, t.$9 AS Text6, t.$10 AS Text7, t.$11 AS Text8, t.$12 AS Text9, t.$13 AS Text10, t.$14 AS Checkbox1, t.$15 AS Checkbox2, t.$16 AS Checkbox3, t.$17 AS Checkbox4, t.$18 AS Checkbox5, t.$19 AS Checkbox6, t.$20 AS Checkbox7, t.$21 AS Checkbox8, t.$22 AS Checkbox9, t.$23 AS Checkbox10, t.$24 AS CreatedBy, t.$25 AS CreatedDate, t.$26 AS UpdatedBy, t.$27 AS UpdatedDate, t.$28 AS DropDownText1, t.$29 AS DropDownText2, t.$30 AS DropDownText3, t.$31 AS DropDownText4, t.$32 AS DropDownText5, t.$33 AS DropDownText6, t.$34 AS DropDownText7, t.$35 AS DropDownText8, t.$36 AS DropDownText9, t.$37 AS DropDownText10, t.$38 AS Text11, t.$39 AS Text12, t.$40 AS Text13, t.$41 AS Text14, t.$42 AS Text15, t.$43 AS Text16, t.$44 AS Text17, t.$45 AS Text18, t.$46 AS Text19, t.$47 AS Text20, t.$48 AS Checkbox11, t.$49 AS Checkbox12, t.$50 AS Checkbox13, t.$51 AS Checkbox14, t.$52 AS Checkbox15, t.$53 AS Checkbox16, t.$54 AS Checkbox17, t.$55 AS Checkbox18, t.$56 AS Checkbox19, t.$57 AS Checkbox20, t.$58 AS Checkbox21, t.$59 AS Checkbox22, t.$60 AS Checkbox23, t.$61 AS Checkbox24, t.$62 AS Checkbox25, t.$63 AS Checkbox26, t.$64 AS Checkbox27, t.$65 AS Checkbox28, t.$66 AS Checkbox29, t.$67 AS Checkbox30, t.$68 AS Checkbox31, t.$69 AS Checkbox32, t.$70 AS Checkbox33, t.$71 AS Checkbox34, t.$72 AS Checkbox35, t.$73 AS DropDownText11, t.$74 AS DropDownText12, t.$75 AS DropDownText13, t.$76 AS DropDownText14, t.$77 AS DropDownText15, t.$78 AS DropDownText16, t.$79 AS DropDownText17, t.$80 AS DropDownText18, t.$81 AS DropDownText19, t.$82 AS DropDownText20, t.$83 AS Text21, t.$84 AS Text22, t.$85 AS Text23, t.$86 AS Text24, t.$87 AS Text25, t.$88 AS Text26, t.$89 AS Text27, t.$90 AS Text28, t.$91 AS Text29, t.$92 AS Text30, t.$93 AS CreatedUTCDate, t.$94 AS UpdatedUTCDate, t.$95 AS SYS_CHANGE_VERSION, t.$96 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$96,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_PatientCustomFields_REPL.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';
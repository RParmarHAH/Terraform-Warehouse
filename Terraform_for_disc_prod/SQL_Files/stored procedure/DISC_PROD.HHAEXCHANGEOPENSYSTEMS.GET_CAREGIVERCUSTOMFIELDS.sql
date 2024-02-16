CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CAREGIVERCUSTOMFIELDS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverCustomFields 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CaregiverCustomFields (SELECT t.$1 AS CaregiverCustomFieldID, t.$2 AS AgencyID, t.$3 AS OfficeID, t.$4 AS CaregiverID, t.$5 AS Text1, t.$6 AS Text2, t.$7 AS Text3, t.$8 AS Text4, t.$9 AS Text5, t.$10 AS Text6, t.$11 AS Text7, t.$12 AS Text8, t.$13 AS Text9, t.$14 AS Text10, t.$15 AS Text11, t.$16 AS Text12, t.$17 AS Text13, t.$18 AS Text14, t.$19 AS Text15, t.$20 AS Text16, t.$21 AS Text17, t.$22 AS Text18, t.$23 AS Text19, t.$24 AS Text20, t.$25 AS Text21, t.$26 AS Text22, t.$27 AS Text23, t.$28 AS Text24, t.$29 AS Text25, t.$30 AS Text26, t.$31 AS Text27, t.$32 AS Text28, t.$33 AS Text29, t.$34 AS Text30, t.$35 AS Dropdown1, t.$36 AS Dropdown2, t.$37 AS Dropdown3, t.$38 AS Dropdown4, t.$39 AS Dropdown5, t.$40 AS Dropdown6, t.$41 AS Dropdown7, t.$42 AS Dropdown8, t.$43 AS Dropdown9, t.$44 AS Dropdown10, t.$45 AS Checkbox1, t.$46 AS Checkbox2, t.$47 AS Checkbox3, t.$48 AS Checkbox4, t.$49 AS Checkbox5, t.$50 AS Checkbox6, t.$51 AS Checkbox7, t.$52 AS Checkbox8, t.$53 AS Checkbox9, t.$54 AS Checkbox10, t.$55 AS Checkbox11, t.$56 AS Checkbox12, t.$57 AS Checkbox13, t.$58 AS Checkbox14, t.$59 AS Checkbox15, t.$60 AS Checkbox16, t.$61 AS Checkbox17, t.$62 AS Checkbox18, t.$63 AS Checkbox19, t.$64 AS Checkbox20, t.$65 AS DropDownValue1, t.$66 AS DropDownValue2, t.$67 AS DropDownValue3, t.$68 AS DropDownValue4, t.$69 AS DropDownValue5, t.$70 AS DropDownValue6, t.$71 AS DropDownValue7, t.$72 AS DropDownValue8, t.$73 AS DropDownValue9, t.$74 AS DropDownValue10, t.$75 AS DropDownText1, t.$76 AS DropDownText2, t.$77 AS DropDownText3, t.$78 AS DropDownText4, t.$79 AS DropDownText5, t.$80 AS DropDownText6, t.$81 AS DropDownText7, t.$82 AS DropDownText8, t.$83 AS DropDownText9, t.$84 AS DropDownText10, t.$85 AS Dropdown11, t.$86 AS DropDownValue11, t.$87 AS DropDownText11, t.$88 AS Dropdown12, t.$89 AS DropDownValue12, t.$90 AS DropDownText12, t.$91 AS Dropdown13, t.$92 AS DropDownValue13, t.$93 AS DropDownText13, t.$94 AS Dropdown14, t.$95 AS DropDownValue14, t.$96 AS DropDownText14, t.$97 AS Dropdown15, t.$98 AS DropDownValue15, t.$99 AS DropDownText15, t.$100 AS Dropdown16, t.$101 AS DropDownValue16, t.$102 AS DropDownText16, t.$103 AS Dropdown17, t.$104 AS DropDownValue17, t.$105 AS DropDownText17, t.$106 AS Dropdown18, t.$107 AS DropDownValue18, t.$108 AS DropDownText18, t.$109 AS Dropdown19, t.$110 AS DropDownValue19, t.$111 AS DropDownText19, t.$112 AS Dropdown20, t.$113 AS DropDownValue20, t.$114 AS DropDownText20, t.$115 AS CreatedBy, t.$116 AS CreatedDate, t.$117 AS UpdatedBy, t.$118 AS UpdatedDate, t.$119 AS CreatedUTCDate, t.$120 AS UpdatedUTCDate, t.$121 AS SYS_CHANGE_VERSION, t.$122 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$122,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverCustomFields.csv.gz (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;
';
CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_AIDECUSTOMFIELDS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_AideCustomFields 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.AideCustomFields (SELECT t.$1 AS AideCustomFieldID, t.$2 AS AideID, t.$3 AS AgencyID, t.$4 AS Text1, t.$5 AS Text2, t.$6 AS Text3, t.$7 AS Text4, t.$8 AS Text5, t.$9 AS Text6, t.$10 AS Text7, t.$11 AS Text8, t.$12 AS Text9, t.$13 AS Text10, t.$14 AS Dropdown1, t.$15 AS Dropdown2, t.$16 AS Dropdown3, t.$17 AS Dropdown4, t.$18 AS Dropdown5, t.$19 AS Dropdown6, t.$20 AS Dropdown7, t.$21 AS Dropdown8, t.$22 AS Dropdown9, t.$23 AS Dropdown10, t.$24 AS Checkbox1, t.$25 AS Checkbox2, t.$26 AS Checkbox3, t.$27 AS Checkbox4, t.$28 AS Checkbox5, t.$29 AS Checkbox6, t.$30 AS Checkbox7, t.$31 AS Checkbox8, t.$32 AS Checkbox9, t.$33 AS Checkbox10, t.$34 AS CreatedBy, t.$35 AS CreatedDate, t.$36 AS UpdatedBy, t.$37 AS UpdatedDate, t.$38 AS DropDownValue1, t.$39 AS DropDownValue2, t.$40 AS DropDownValue3, t.$41 AS DropDownValue4, t.$42 AS DropDownValue5, t.$43 AS DropDownValue6, t.$44 AS DropDownValue7, t.$45 AS DropDownValue8, t.$46 AS DropDownValue9, t.$47 AS DropDownValue10, t.$48 AS DropDownText1, t.$49 AS DropDownText2, t.$50 AS DropDownText3, t.$51 AS DropDownText4, t.$52 AS DropDownText5, t.$53 AS DropDownText6, t.$54 AS DropDownText7, t.$55 AS DropDownText8, t.$56 AS DropDownText9, t.$57 AS DropDownText10, t.$58 AS Text11, t.$59 AS Text12, t.$60 AS Text13, t.$61 AS Text14, t.$62 AS Text15, t.$63 AS Text16, t.$64 AS Text17, t.$65 AS Text18, t.$66 AS Text19, t.$67 AS Text20, t.$68 AS Checkbox11, t.$69 AS Checkbox12, t.$70 AS Checkbox13, t.$71 AS Checkbox14, t.$72 AS Checkbox15, t.$73 AS Checkbox16, t.$74 AS Checkbox17, t.$75 AS Checkbox18, t.$76 AS Checkbox19, t.$77 AS Checkbox20, t.$78 AS Dropdown11, t.$79 AS DropDownValue11, t.$80 AS DropDownText11, t.$81 AS Dropdown12, t.$82 AS DropDownValue12, t.$83 AS DropDownText12, t.$84 AS Dropdown13, t.$85 AS DropDownValue13, t.$86 AS DropDownText13, t.$87 AS Dropdown14, t.$88 AS DropDownValue14, t.$89 AS DropDownText14, t.$90 AS Dropdown15, t.$91 AS DropDownValue15, t.$92 AS DropDownText15, t.$93 AS Dropdown16, t.$94 AS DropDownValue16, t.$95 AS DropDownText16, t.$96 AS Dropdown17, t.$97 AS DropDownValue17, t.$98 AS DropDownText17, t.$99 AS Dropdown18, t.$100 AS DropDownValue18, t.$101 AS DropDownText18, t.$102 AS Dropdown19, t.$103 AS DropDownValue19, t.$104 AS DropDownText19, t.$105 AS Dropdown20, t.$106 AS DropDownValue20, t.$107 AS DropDownText20, t.$108 AS Text21, t.$109 AS Text22, t.$110 AS Text23, t.$111 AS Text24, t.$112 AS Text25, t.$113 AS Text26, t.$114 AS Text27, t.$115 AS Text28, t.$116 AS Text29, t.$117 AS Text30, t.$118 AS ProviderID, t.$119 AS OfficeID, t.$120 AS CreatedUTCDate, t.$121 AS UpdatedUTCDate, t.$122 AS SYS_CHANGE_VERSION, t.$123 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$123,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_AideCustomFields.*[.]csv.gz'')T);

    return ''Success'';
END;
';
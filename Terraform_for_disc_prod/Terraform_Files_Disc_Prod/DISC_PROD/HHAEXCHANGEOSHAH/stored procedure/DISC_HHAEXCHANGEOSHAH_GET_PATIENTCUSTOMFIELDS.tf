resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_PATIENTCUSTOMFIELDS" {
	name ="GET_PATIENTCUSTOMFIELDS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_PatientCustomFields 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PatientCustomFields (SELECT t.$1 AS PatientCustomFieldID, t.$2 AS PatientID, t.$3 AS Text1, t.$4 AS Text2, t.$5 AS Text3, t.$6 AS Text4, t.$7 AS Text5, t.$8 AS Text6, t.$9 AS Text7, t.$10 AS Text8, t.$11 AS Text9, t.$12 AS Text10, t.$13 AS Dropdown1, t.$14 AS Dropdown2, t.$15 AS Dropdown3, t.$16 AS Dropdown4, t.$17 AS Dropdown5, t.$18 AS Dropdown6, t.$19 AS Dropdown7, t.$20 AS Dropdown8, t.$21 AS Dropdown9, t.$22 AS Dropdown10, t.$23 AS Checkbox1, t.$24 AS Checkbox2, t.$25 AS Checkbox3, t.$26 AS Checkbox4, t.$27 AS Checkbox5, t.$28 AS Checkbox6, t.$29 AS Checkbox7, t.$30 AS Checkbox8, t.$31 AS Checkbox9, t.$32 AS Checkbox10, t.$33 AS CreatedBy, t.$34 AS CreatedDate, t.$35 AS UpdatedBy, t.$36 AS UpdatedDate, t.$37 AS DropDownText1, t.$38 AS DropDownText2, t.$39 AS DropDownText3, t.$40 AS DropDownText4, t.$41 AS DropDownText5, t.$42 AS DropDownText6, t.$43 AS DropDownText7, t.$44 AS DropDownText8, t.$45 AS DropDownText9, t.$46 AS DropDownText10, t.$47 AS Text11, t.$48 AS Text12, t.$49 AS Text13, t.$50 AS Text14, t.$51 AS Text15, t.$52 AS Text16, t.$53 AS Text17, t.$54 AS Text18, t.$55 AS Text19, t.$56 AS Text20, t.$57 AS AgencyID, t.$58 AS Checkbox11, t.$59 AS Checkbox12, t.$60 AS Checkbox13, t.$61 AS Checkbox14, t.$62 AS Checkbox15, t.$63 AS Checkbox16, t.$64 AS Checkbox17, t.$65 AS Checkbox18, t.$66 AS Checkbox19, t.$67 AS Checkbox20, t.$68 AS Checkbox21, t.$69 AS Checkbox22, t.$70 AS Checkbox23, t.$71 AS Checkbox24, t.$72 AS Checkbox25, t.$73 AS Checkbox26, t.$74 AS Checkbox27, t.$75 AS Checkbox28, t.$76 AS Checkbox29, t.$77 AS Checkbox30, t.$78 AS Checkbox31, t.$79 AS Checkbox32, t.$80 AS Checkbox33, t.$81 AS Checkbox34, t.$82 AS Checkbox35, t.$83 AS Dropdown11, t.$84 AS DropDownText11, t.$85 AS Dropdown12, t.$86 AS DropDownText12, t.$87 AS Dropdown13, t.$88 AS DropDownText13, t.$89 AS Dropdown14, t.$90 AS DropDownText14, t.$91 AS Dropdown15, t.$92 AS DropDownText15, t.$93 AS Dropdown16, t.$94 AS DropDownText16, t.$95 AS Dropdown17, t.$96 AS DropDownText17, t.$97 AS Dropdown18, t.$98 AS DropDownText18, t.$99 AS Dropdown19, t.$100 AS DropDownText19, t.$101 AS Dropdown20, t.$102 AS DropDownText20, t.$103 AS Text21, t.$104 AS Text22, t.$105 AS Text23, t.$106 AS Text24, t.$107 AS Text25, t.$108 AS Text26, t.$109 AS Text27, t.$110 AS Text28, t.$111 AS Text29, t.$112 AS Text30, t.$113 AS pcfOfficeID, t.$114 AS CreatedUTCDate, t.$115 AS UpdatedUTCDate, t.$116 AS SYS_CHANGE_VERSION, t.$117 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$117,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/HHAEXCHANGEOSHAH_dbo_PatientCustomFields.csv.gz (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;

 EOT
}


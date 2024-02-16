resource "snowflake_procedure" "DISC_MOLINA_GET_MOLINA_IP_CENSUS" {
	name ="GET_MOLINA_IP_CENSUS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MOLINA"
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
	INSERT INTO DISC_${var.SF_ENVIRONMENT}.MOLINA.HIST_MOLINA_IP_CENSUS SELECT A.$1,A.$2,A.$3,A.$4,A.$5,A.$6,A.$7,A.$8,A.$9,A.$10,A.$11,A.$12,A.$13,A.$14,A.$15,A.$16,A.$17,A.$18,A.$19,A.$20,A.$21,A.$22,A.$23,A.$24,A.$25,A.$26,A.$27,A.$28,A.$29,A.$30,A.$31,A.$32,A.$33 ,A.$34,A.$35,A.$36,A.$37,A.$38 ,A.$39 ,A.$40 ,A.$41 ,A.$42 ,A.$43 ,A.$44 ,A.$45 ,A.$46 ,A.$47 ,A.$48 ,A.$49 ,A.$50 ,A.$51 ,A.$52 ,A.$53 ,A.$54 ,A.$55 ,A.$56 ,A.$57 ,A.$58 ,A.$59 ,A.$60 ,A.$61 ,A.$62 ,A.$63 ,A.$64 ,A.$65 ,A.$66 ,A.$67 ,A.$68 ,A.$69 ,A.$70 ,A.$71 ,A.$72 ,A.$73 ,A.$74 ,A.$75 ,A.$76 ,A.$77 ,A.$78 ,A.$79 ,A.$80 ,A.$81 ,A.$82 ,A.$83 ,A.$84,CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) as LOADDATE,SPLIT_PART(metadata$filename,''/'',3) AS ACTUAL_FILENAME FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/Program_Clients/MOLINA_IP_CENSUS/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT,PATTERN =>''.*IP Census .*[.]csv'') A;
	
	return ''Success'';
END;

 EOT
}


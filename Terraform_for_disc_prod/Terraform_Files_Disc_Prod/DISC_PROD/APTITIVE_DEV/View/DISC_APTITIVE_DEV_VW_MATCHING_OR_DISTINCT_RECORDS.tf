resource "snowflake_view" "DISC_APTITIVE_DEV_VW_MATCHING_OR_DISTINCT_RECORDS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "APTITIVE_DEV"
	name = "VW_MATCHING_OR_DISTINCT_RECORDS"
	statement = <<-SQL
	 (
select
s1.key as match_or_distinct,
s2.INDEX as match_set,
s3.INDEX as record,
 s0.filename,
s3.value:"ADDRESS1"::string as ADDRESS1
, s3.value:"ADDRESS2" as ADDRESS2
, s3.value:"AGENCY" as AGENCY
, s3.value:"BEGINSERVICEDATE"::string as BEGINSERVICEDATE
, s3.value:"BILLHOLIDAY" as BILLHOLIDAY
, s3.value:"BILLOFFICE" as BILLOFFICE
, s3.value:"CITY"::string as CITY
, s3.value:"CREATEDDATE"::string as CREATEDDATE
, s3.value:"DATEADDED"::string as DATEADDED
, s3.value:"DATECHANGED"::string as DATECHANGED
, s3.value:"DBNAME"::string as DBNAME
, s3.value:"DCNNUMBER" as DCNNUMBER
, s3.value:"DOB"::string as DOB
, s3.value:"ENDSERVICEDATE"::string as ENDSERVICEDATE
, s3.value:"ETHICS"::string as ETHICS
, s3.value:"ETL_DELETED_FLAG" as ETL_DELETED_FLAG
, s3.value:"ETL_INSERTED_BY"::string as ETL_INSERTED_BY
, s3.value:"ETL_INSERTED_DATE"::string as ETL_INSERTED_DATE
, s3.value:"ETL_INSERTED_TASK_KEY"::string as ETL_INSERTED_TASK_KEY
, s3.value:"ETL_LAST_UPDATED_BY"::string as ETL_LAST_UPDATED_BY
, s3.value:"ETL_LAST_UPDATED_DATE"::string as ETL_LAST_UPDATED_DATE
, s3.value:"ETL_TASK_KEY"::string as ETL_TASK_KEY
, s3.value:"FIRSTNAME"::string as FIRSTNAME
, s3.value:"GENDER"::string as GENDER
, s3.value:"ICD10CODES"::string as ICD10CODES
, s3.value:"ICD9CODES"::string as ICD9CODES
, s3.value:"ID"::string as ID
, s3.value:"IDOAID"::string as IDOAID
, s3.value:"ISACTIVE"::string as ISACTIVE
, s3.value:"LASTNAME"::string as LASTNAME
, s3.value:"MEDICAIDNO"::string as MEDICAIDNO
, s3.value:"MIDDLENAME"::string as MIDDLENAME
, s3.value:"NUMBER"::string as NUMBER
, s3.value:"OFFICENUMBER"::string as OFFICENUMBER
, s3.value:"ONHOLDENDDATE"::string as ONHOLDENDDATE
, s3.value:"ONHOLDSTARTDATE"::string as ONHOLDSTARTDATE
, s3.value:"PHONENUMBER"::string as PHONENUMBER
, s3.value:"PHYSICANNAME"::string as PHYSICANNAME
, s3.value:"PHYSICANNO"::string as PHYSICANNO
, s3.value:"SERVICEAREA"::string as SERVICEAREA
, s3.value:"SSN"::string as SSN
, s3.value:"STATE"::string as STATE
, s3.value:"SUPERVISORCODE"::string as SUPERVISORCODE
, s3.value:"SYS_CHANGE_OPERATION"::string as SYS_CHANGE_OPERATION
, s3.value:"SYS_CHANGE_VERSION"::string as SYS_CHANGE_VERSION
, s3.value:"UPDATEBATCH"::string as UPDATEBATCH
, s3.value:"UPDATEDTIME"::string as UPDATEDTIME
, s3.value:"ZIP"::string as ZIP
from disc_prod.aptitive_dev.training_jsons s0
, LATERAL FLATTEN(INPUT => s0.json_file) s1
, LATERAL FLATTEN(INPUT => s1.VALUE) s2
, LATERAL FLATTEN(INPUT => s2.VALUE:"__value__") s3
  );
SQL
	or_replace = true 
	is_secure = false 
}


resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CLIENTCMS1500" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CLIENTCMS1500"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CLIENTCMS1500

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "HCFAID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "INSURANCETYPE_1"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INSUREDIDNO_1A"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INSUREDNAME_4"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENTREL_6"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INSUREDADDRESS_7"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INSUREDCITY_7"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "INSUREDSTATE_7"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INSUREDZIP_7"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INSUREDPHONENO_7"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PATIENTMARRIEDSTATUS_8"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PATIENTEMPLOYMENTSTATUS_8"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTHERINSUREDNAME_9"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERPOLICYNO_9A"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERDOB_9B"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OTHERSEX_9B"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OTHEREMPLOYERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERPLANNAME_9D"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RELATEDTOSTATE_10"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "INSUREDGROUPNO_11"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INSUREDDOB_11A"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSUREDSEX_11A"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INSUREDEMPLOYERNAME_11B"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INSUREDPLANNAME_11C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INSUREDOTHERHEALTHPLAN_11D"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PATIENTSIGONFILE_12"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INSUREDSIGONFILE_13"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CURRENTILLNESSDATE_14"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIMILARILLNESSDATE_15"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UNABLETOWORKFROM_16"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UNABLETOWORKTHRU_16"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFERRINGPHYSICIAN_17"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFERRINGPHYSICIANID_17A"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOSPITALIZEDFROM_18"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HOSPITALIZEDTHRU_18"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESERVEDFORLOCALUSE_19"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OUTSIDELAB_20"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OUTSIDELABCHARGES_20"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MEDICAIDRESUBMISSIONCODE_22"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINALREFERENCENUM_22"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIORAUTHNUMBER_23"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RESERVEDLOCALUSE_10D"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GRRPNO_33"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PINNO_33"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIAGNOSIS1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENTSACCTNO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCEPTASSIGNMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SERVICESRENDEREDADDRESSS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CARRIER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RELATEDTOEMPLOYMENT_10"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RELATEDTOAUTO_10"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RELATEDTOOTHER_10"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PHYSICIANSIGN_31"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RESERVEDLOCALUSE_24"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "PIN33"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFERRINGPHYSICIANID_17AQUALIFIER"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "REFERRINGPHYSICIANNPI_17B"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RENDERINGPROVIDERIDQUALIFIER24I"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "NPINUMBER_24J"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "NPINO_32A"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTHERIDQUALIFIER32B"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OTHERID32B"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "AMOUNTPAID_29"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "POS_24B"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYSICIANSUPPLIERNAME_33"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EPSDT_24H"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROVIDERNO24J_TYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHONE33"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "EMG_24C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CURRENTILLNESS14_QUAL"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "OTHERCLAIM11B_QUAL"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OTHERCLAIM11B_DESCRIPTION"
	type = "VARCHAR(28)"
	nullable = true
}


column {
	name = "OTHERDATE15_QUAL"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "REFERRINGPHYSICIAN17_QUAL"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ADDITIONALCLAIM19"
	type = "VARCHAR(71)"
	nullable = true
}


column {
	name = "DIAGNOSIS6"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS7"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS9"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS8"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS10"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS11"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSIS12"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INSUREDMIDDLENAME_4"
	type = "VARCHAR(24)"
	nullable = true
}


column {
	name = "INSUREDFIRSTNAME_4"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "OTHERINSUREDFIRSTNAME_9"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "OTHERINSUREDMIDDLENAME_9"
	type = "VARCHAR(24)"
	nullable = true
}


column {
	name = "DIAGNOSISA"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISB"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INSUREDLASTNAME_4"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OTHERINSUREDLASTNAME_9"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GRPNO_33_QUAL"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10A"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10B"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10D"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10E"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10F"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10G"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10H"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10I"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10J"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10K"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAGNOSISICD10L"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FEDERALTAXIDTYPE_25"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}


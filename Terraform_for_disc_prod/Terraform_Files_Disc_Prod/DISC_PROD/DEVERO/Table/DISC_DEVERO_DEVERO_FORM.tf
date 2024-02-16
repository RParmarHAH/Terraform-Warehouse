resource "snowflake_table" "DISC_DEVERO_DEVERO_FORM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_FORM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_FORM

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "FORM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVER_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_CREATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHART_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATION_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_FIRST_SENT_TO_OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_LAST_SENT_TO_OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REMOVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RFA_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OASIS_HIS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OASIS_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VENDOR_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDER_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TO_BE_SIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICALRECORDNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0064SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0064_SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASEMANAGERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYINSURANCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOH_LOCATIONAME_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONAME_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPCAGENCYNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHAPC_LOCATIONAME_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DSC_LOCATIONAME_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0016_BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGSYSTEMAGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPCAGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040_PAT_MI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040MIDDLEINIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0066BIRTHDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0066_PAT_BIRTH_DT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATEOFDEATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAS_MARITALSTATUS_RDO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RACEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RACECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0060_PAT_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0060ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0050_PAT_ST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0040PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CELLPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTEMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPC_INSURANCEEFFECTIVEFROM_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPC_INSURANCEEFFECTIVETO_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODESTARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATIONTODATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGSYSTEMPATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTVISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITDATEOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITFREQUENCIESRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISORYUSERTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONNUMBER_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONFAX_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONSTATE_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONADDRESS_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONCITY_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONZIP_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HDR_LOCATIONPHONE_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHAPC_LOCATIONNUMBER_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIANID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSLNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0104_PHYSN_RFRL_DT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANADDRESSCARECOO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANADDRESSRESPONSIBLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PCPHYSICIANZIPCODE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSDETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGE_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCHARGEREASONID2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRC_PATIENTAVAILABILITY_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRC_PRIMARYCARENAME_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DC_TRANSFERDATE_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VTSIG_TEMP_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INT_RESPONSEINTERV_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LBD_LASTBM_CHK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHN_TIMEIN1_TXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M1021CDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CP_PROGNOSIS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "M0150_CPAY_NONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_VALUES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}


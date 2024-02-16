resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_FDB_DISPENSABLES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_FDB_DISPENSABLES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_FDB_DISPENSABLES

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MEDID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DESCDISPLAY"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "DESCSEARCH"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "DESCALTSEARCH"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "MNID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DFID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STRENGTH"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "STRENGTHUNITS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "RMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RDFMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "GCNSEQNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RTGENID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HICL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "GENERICLINKINDICATOR"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NAMETYPECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "NAMESOURCECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "GENDERSPECIFICDRUGCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFFEDERALLEGENDCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFMULTISOURCECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFFEDERALDEACLASSCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFGENERICDRUGNAMECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFGENERICCOMPPRICECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFGENERICPRICESPREADCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFINNOVATORCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFGENERICTHERAEQUIVCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFDESICODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFDESI2CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SINGLEINGREDIENTIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "MEDICALDEVICEIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OBSOLETEDATE"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "REPLACEDINDICATOR"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SINGLEDOSEROUTEIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HASPACKAGEDDRUGSIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HASEQUIVPACKAGEDDRUGSIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HASIMAGESIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "GENERICMNID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "GENERICMEDID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFREPACKAGERCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFPRIVLABELEDPRODCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STATUSCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "NUMSTRENGTH"
	type = "NUMBER(16,6)"
	nullable = true
}


column {
	name = "NUMSTRENGTHUOM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NUMVOLUME"
	type = "NUMBER(16,6)"
	nullable = true
}


column {
	name = "NUMVOLUMEUOM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TM_DESCDISPLAY"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "TM_CONFUSIONGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TM_GROUPDESC"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TM_SOURCECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DRCSINGLEDOSEROUTEIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NEOSINGLEDOSEROUTEIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INACTIVEINGREDIENTREVIEWIND"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SAFENUMSTRENGTHUOM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SAFENUMVOLUMEUOM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SAFENUMSTRENGTH"
	type = "NUMBER(16,6)"
	nullable = true
}


column {
	name = "SAFENUMVOLUME"
	type = "NUMBER(16,6)"
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


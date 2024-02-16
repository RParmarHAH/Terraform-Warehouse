CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_FDB_DISPENSABLES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_FDB_Dispensables 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_FDB_Dispensables FROM (SELECT t.$1 AS medid, t.$2 AS descdisplay, t.$3 AS descsearch, t.$4 AS descaltsearch, t.$5 AS mnid, t.$6 AS rtid, t.$7 AS dfid, t.$8 AS strength, t.$9 AS strengthunits, t.$10 AS rmid, t.$11 AS rdfmid, t.$12 AS gcnseqno, t.$13 AS rtgenid, t.$14 AS hicl, t.$15 AS genericlinkindicator, t.$16 AS nametypecode, t.$17 AS namesourcecode, t.$18 AS genderspecificdrugcode, t.$19 AS reffederallegendcode, t.$20 AS refmultisourcecode, t.$21 AS reffederaldeaclasscode, t.$22 AS refgenericdrugnamecode, t.$23 AS refgenericcomppricecode, t.$24 AS refgenericpricespreadcode, t.$25 AS refinnovatorcode, t.$26 AS refgenerictheraequivcode, t.$27 AS refdesicode, t.$28 AS refdesi2code, t.$29 AS singleingredientind, t.$30 AS medicaldeviceind, t.$31 AS obsoletedate, t.$32 AS replacedindicator, t.$33 AS singledoserouteind, t.$34 AS haspackageddrugsind, t.$35 AS hasequivpackageddrugsind, t.$36 AS hasimagesind, t.$37 AS genericmnid, t.$38 AS genericmedid, t.$39 AS refrepackagercode, t.$40 AS refprivlabeledprodcode, t.$41 AS statuscode, t.$42 AS numstrength, t.$43 AS numstrengthuom, t.$44 AS numvolume, t.$45 AS numvolumeuom, t.$46 AS tm_descdisplay, t.$47 AS tm_confusiongroupid, t.$48 AS tm_groupdesc, t.$49 AS tm_sourcecode, t.$50 AS drcsingledoserouteind, t.$51 AS neosingledoserouteind, t.$52 AS inactiveingredientreviewind, t.$53 AS safenumstrengthuom, t.$54 AS safenumvolumeuom, t.$55 AS safenumstrength, t.$56 AS safenumvolume, t.$57 AS SYS_CHANGE_VERSION, t.$58 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$58,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_FDB_Dispensables.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.FDB_Dispensables AS WITH curr_v AS (SELECT medid, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_FDB_Dispensables GROUP BY medid) SELECT t.* FROM CostalSyncData.HIST_FDB_Dispensables t INNER JOIN curr_v v ON t.medid = v.medid AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';
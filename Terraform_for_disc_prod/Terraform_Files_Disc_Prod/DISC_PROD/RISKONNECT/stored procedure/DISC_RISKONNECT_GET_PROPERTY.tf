resource "snowflake_procedure" "DISC_RISKONNECT_GET_PROPERTY" {
	name ="GET_PROPERTY"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.RISKONNECT.GET_PROPERTY 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Property FROM (SELECT T.$1 AS Id, T.$2 AS OwnerId,  T.$3 AS IsDeleted,  T.$4 AS Name,  REPLACE(T.$5,''T'','' '')::TIMESTAMP_NTZ(9) AS CreatedDate,  T.$6 AS CreatedById,  REPLACE(T.$7,''T'','' '')::TIMESTAMP_NTZ(9) AS LastModifiedDate, T.$8 AS LastModifiedById,  REPLACE(T.$9,''T'','' '')::TIMESTAMP_NTZ(9) AS SystemModstamp, T.$10 AS LastActivityDate,  T.$11 AS LastViewedDate,  T.$12 AS LastReferencedDate,  T.$13 AS ConnectionReceivedId,  T.$14 AS ConnectionSentId,  T.$15 AS Address_Line1__c,  T.$16 AS Address_Line2__c, T.$17 AS Fire_Alarm__c,  T.$18 AS Area_Occupied__c,  T.$19 AS Building_Height__c,  T.$20 AS City__c,  T.$21 AS Coastal_Distance__c,  T.$22 AS Active__c,  T.$23 AS Construction_Risk__c, T.$24 AS Lessor_Landlord_Name_2__c,  T.$25 AS Construction_Type__c,  T.$26 AS Country__c,  T.$27 AS County__c,  T.$28 AS Lessor_Street_Address_2__c,  T.$29 AS Date_Inactive__c,  T.$30 AS Date_Active__c, T.$31 AS Date_Sold__c,  T.$32 AS Date_of_Initial_Lease__c,  T.$33 AS Earthquake_Zone__c,  T.$34 AS Elevation__c,  T.$35 AS Fire_Areas__c,  T.$36 AS Fire_Dept_Location__c, T.$37 AS Fire_Dept_Type__c,  T.$38 AS Fire_Hydrant_Distance__c,  T.$39 AS Lessor_Landlord__c,  T.$40 AS Flood_Zone__c,  T.$41 AS Floors_Occupied__c,  T.$42 AS Building_Square_Footage__c, T.$43 AS Lessor_Street_Address__c,  T.$44 AS Hierarchy_Node__c,  T.$45 AS ID_Prior__c,  T.$46 AS Interior_Columns__c,  T.$47 AS LEED_Certification_Level__c,  T.$48 AS LEED_Certified__c, T.$49 AS Latitude__c,  T.$50 AS Levels_Above_Grade__c,  T.$51 AS Levels_Below_Grade__c,  T.$52 AS Longitude__c,  T.$53 AS NAICS__c,  T.$54 AS Number_of_Fire_Hydrants__c,  T.$55 AS Signed_Lease__c,T.$56 AS Occupation__c,  T.$57 AS Perimeter_Wall_Construction__c,  T.$58 AS Photo__c,  T.$59 AS Lessor_City__c,  T.$60 AS Lessor_State__c,  T.$61 AS Property_ID__c,  T.$62 AS Property_Zoning__c, T.$63 AS Protection_Class__c,  T.$64 AS Renovation_Year__c,  T.$65 AS Lessor_Zip__c,  T.$66 AS Lessor_Contact_Number__c,  T.$67 AS Roof_Flashing__c,  T.$68 AS Roof_Type__c,  T.$69 AS SIC_Code__c, T.$70 AS Lease_Expiration_Date__c,  T.$71 AS Security__c,  T.$72 AS Lease_term_months__c,  T.$73 AS Total_Employees_Paid__c,  T.$74 AS Square_Footage__c,  T.$75 AS State__c,  T.$76 AS Telephone__c, T.$77 AS Total_Customers__c,  T.$78 AS Use__c,  T.$79 AS Water_Supply_Test_Date__c,  T.$80 AS Water_Supply_Test_Results__c,  T.$81 AS Water_Supply_Type__c,  T.$82 AS Wind_Storm_Zone__c, T.$83 AS Zip_Code__c,  T.$84 AS Date_of_Most_Current_Property_Values__c,  T.$85 AS Date_of_Most_Recent_Inspection__c,  T.$86 AS Property_Status__c,  T.$87 AS Renewal_Value_Update_Status__c, T.$88 AS Age_in_Months_of_Property_Values__c,  T.$89 AS District__c,  T.$90 AS External_Contacts_Email_List__c,  T.$91 AS Internal_Contacts_Email_List__c,  T.$92 AS Rent_Payment__c, T.$93 AS Personal_Property_Coverage__c,  T.$94 AS Equipment_Coverage__c,  T.$95 AS Building_Coverage__c,  T.$96 AS Improvements_Betterments_Coverage__c,  T.$97 AS Branch_Manager__c,T.$98 AS Branch_Phone__c,  T.$99 AS Branch_Fax__c,  T.$100 AS Branch_Email__c,  T.$101 AS Construction_Year__c,  T.$102 AS Business_Income_Coverage__c,  T.$103 AS Region__c,  T.$104 AS Triple_Net_Lease__c, T.$105 AS Annual_total_hours_worked__c,  T.$106 AS Primary_Location_Indicator__c,  T.$107 AS Sprinklers__c,  T.$108 AS Notes__c,  T.$109 AS Location_Number__c,  T.$110 AS Avg_of_Employees__c,T.$111 AS Avg_Month__c,  T.$112 AS Avg_Monthly_Admin_EEs__c,  T.$113 AS Clean_Up__c,  T.$114 AS Landlord__c,  T.$115 AS Change_Reason__c,  T.$116 AS Office_Type__c,  T.$117 AS OSHA_Year__c, T.$118 AS Purchase_Price__c,  T.$119 AS Property_Notes__c,  T.$120 AS Number_of_beds__c,  T.$121 AS Stories_Floors__c,  T.$122 AS Year_of_electrical__c,  T.$123 AS Year_of_plumbing__c,T.$124 AS Year_of_roof__c,  T.$125 AS Year_of_HVAC__c,  T.$126 AS of_baths__c,  T.$127 AS of_bedrooms__c,  T.$128 AS Facilities_Notes__c,  T.$129 AS Support_Lease__c,  T.$130 AS Extra_Expense_Coverage__c,T.$131 AS Lease_Query__c,  T.$132 AS Entity__c,  T.$133 AS Group_Home__c,  T.$134 AS Lease_Status__c,  T.$135 AS Occupancy_Status__c, -1 AS ETL_TASK_KEY, -1 AS ETL_INSERTED_TASK_KEY,CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY,0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Riskonnect/Daily_data (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT_UTF8_FALSE,PATTERN => ''.*Property_.*[.]csv'')T );

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.RISKONNECT.Property AS SELECT ID,  OWNERID,  ISDELETED,  NAME,  CREATEDDATE,  CREATEDBYID,  LASTMODIFIEDDATE,  LASTMODIFIEDBYID,  SYSTEMMODSTAMP,  LASTACTIVITYDATE,  LASTVIEWEDDATE,  LASTREFERENCEDDATE,  CONNECTIONRECEIVEDID,  CONNECTIONSENTID,  ADDRESS_LINE1__C,  ADDRESS_LINE2__C,  FIRE_ALARM__C,  AREA_OCCUPIED__C,  BUILDING_HEIGHT__C,  CITY__C,  COASTAL_DISTANCE__C,  ACTIVE__C,  CONSTRUCTION_RISK__C,  LESSOR_LANDLORD_NAME_2__C,  CONSTRUCTION_TYPE__C,  COUNTRY__C,  COUNTY__C,  LESSOR_STREET_ADDRESS_2__C,  DATE_INACTIVE__C,  DATE_ACTIVE__C,  DATE_SOLD__C,  DATE_OF_INITIAL_LEASE__C,  EARTHQUAKE_ZONE__C,  ELEVATION__C,  FIRE_AREAS__C,  FIRE_DEPT_LOCATION__C,  FIRE_DEPT_TYPE__C,  FIRE_HYDRANT_DISTANCE__C,  LESSOR_LANDLORD__C,  FLOOD_ZONE__C,  FLOORS_OCCUPIED__C,  BUILDING_SQUARE_FOOTAGE__C,  LESSOR_STREET_ADDRESS__C,  HIERARCHY_NODE__C,  ID_PRIOR__C,  INTERIOR_COLUMNS__C,  LEED_CERTIFICATION_LEVEL__C,  LEED_CERTIFIED__C,  LATITUDE__C,  LEVELS_ABOVE_GRADE__C,  LEVELS_BELOW_GRADE__C,  LONGITUDE__C,  NAICS__C,  NUMBER_OF_FIRE_HYDRANTS__C,  SIGNED_LEASE__C,  OCCUPATION__C,  PERIMETER_WALL_CONSTRUCTION__C,  PHOTO__C,  LESSOR_CITY__C,  LESSOR_STATE__C,  PROPERTY_ID__C,  PROPERTY_ZONING__C,  PROTECTION_CLASS__C,  RENOVATION_YEAR__C,  LESSOR_ZIP__C,  LESSOR_CONTACT_NUMBER__C,  ROOF_FLASHING__C,  ROOF_TYPE__C,  SIC_CODE__C,  LEASE_EXPIRATION_DATE__C,  SECURITY__C,  LEASE_TERM_MONTHS__C,  TOTAL_EMPLOYEES_PAID__C,  SQUARE_FOOTAGE__C,  STATE__C,  TELEPHONE__C,  TOTAL_CUSTOMERS__C,  USE__C,  WATER_SUPPLY_TEST_DATE__C,  WATER_SUPPLY_TEST_RESULTS__C,  WATER_SUPPLY_TYPE__C,  WIND_STORM_ZONE__C,  ZIP_CODE__C,  DATE_OF_MOST_CURRENT_PROPERTY_VALUES__C,  DATE_OF_MOST_RECENT_INSPECTION__C,  PROPERTY_STATUS__C,  RENEWAL_VALUE_UPDATE_STATUS__C,  AGE_IN_MONTHS_OF_PROPERTY_VALUES__C,  DISTRICT__C,  EXTERNAL_CONTACTS_EMAIL_LIST__C,  INTERNAL_CONTACTS_EMAIL_LIST__C,  RENT_PAYMENT__C,  PERSONAL_PROPERTY_COVERAGE__C,  EQUIPMENT_COVERAGE__C,  BUILDING_COVERAGE__C,  IMPROVEMENTS_BETTERMENTS_COVERAGE__C,  BRANCH_MANAGER__C,  BRANCH_PHONE__C,  BRANCH_FAX__C,  BRANCH_EMAIL__C,  CONSTRUCTION_YEAR__C,  BUSINESS_INCOME_COVERAGE__C,  REGION__C,  TRIPLE_NET_LEASE__C,  ANNUAL_TOTAL_HOURS_WORKED__C,  PRIMARY_LOCATION_INDICATOR__C,  SPRINKLERS__C,  NOTES__C,  LOCATION_NUMBER__C,  AVG_OF_EMPLOYEES__C,  AVG_MONTH__C,  AVG_MONTHLY_ADMIN_EES__C,  CLEAN_UP__C,  LANDLORD__C,  CHANGE_REASON__C,  OFFICE_TYPE__C,  OSHA_YEAR__C,  PURCHASE_PRICE__C,  PROPERTY_NOTES__C,  NUMBER_OF_BEDS__C,  STORIES_FLOORS__C,  YEAR_OF_ELECTRICAL__C,  YEAR_OF_PLUMBING__C,  YEAR_OF_ROOF__C,  YEAR_OF_HVAC__C,  OF_BATHS__C,  OF_BEDROOMS__C,  FACILITIES_NOTES__C,  SUPPORT_LEASE__C,  EXTRA_EXPENSE_COVERAGE__C,  LEASE_QUERY__C,  ENTITY__C,  GROUP_HOME__C,  LEASE_STATUS__C,  OCCUPANCY_STATUS__C, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Property WHERE (ID,ETL_LAST_UPDATED_DATE) IN (SELECT ID,MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Property GROUP BY ID);

    return ''Success'';
END;

 EOT
}


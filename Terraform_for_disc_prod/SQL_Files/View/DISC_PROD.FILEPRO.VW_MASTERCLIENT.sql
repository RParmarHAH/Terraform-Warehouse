create or replace view DISC_PROD.FILEPRO.VW_MASTERCLIENT(
	CCU_CONTRACT,
	CCU_AGREEMENT,
	CCU_PROGRAM_TYPE,
	CLIENT_IDOA,
	LAST_NAME,
	FIRST_NAME,
	RELOOK_EARLY_WARNING_FLAG,
	ADDRESS1,
	ADDRESS2,
	CITY,
	ZIP,
	DETERMINATION_DATE,
	ASSESSMENT_SCORE,
	INITIAL_SERVICE_DATE,
	AVAIL_INCOME,
	NUMBER_RECEIVING,
	SERVED_BY_FAMILY_MEMBER,
	FEE_SCHEDULE,
	TYPE_SERVICE,
	ACTION_TYPE,
	ACTION_DATE,
	VENDOR_MAX,
	VENDOR_FEIN_AG_PT,
	UNUSED_3,
	NSP_FLAG,
	UNUSED_6,
	UNUSED_4,
	UNUSED_14,
	USED_FOR_AREA,
	SERVU50_FLAG,
	UNUSED6,
	UNUSED4,
	UNUSED14,
	COMBINED_CLIENT_NAME,
	UPDATE_FLAG,
	SERVICE_1_UNITS,
	SERVICE_2_UNITS,
	SERVICE_3_UNITS,
	PHONE,
	COPAY_YNP,
	COPAY,
	EMPLOYEE,
	DESK_ASSIGNED_SERV_COORD,
	DOB,
	SEX,
	COPAY_RESPONSIBLE_PARTY,
	ADDRESS,
	PHONE14,
	RELATIONSHIP,
	CITY_20,
	STATE2,
	ZIP5,
	CASE_ACTION_DATE,
	AREA2,
	PRIVATE_PAY_RATE,
	CREATED_ON,
	CREATED_BY,
	UPDATED_ON,
	UPDATED_BY,
	FAMILY_REASON,
	MEDICAID_RECP_Y_N_P,
	CCU_LOOKUP_ID,
	COUNTY,
	CCU_FEIN,
	EMERGENCY_PHONE_CONTACT,
	EMERGENCY_NAME_CONTACT,
	PRIVATE_PAY_BILLING_CYCLE,
	LAST_BILLING_DATE,
	NEW_FIELD_OLD_SSN,
	HMKR_NAME,
	CASE_MGR,
	CPT_VET_MCO,
	DIAG_VET_MCO,
	MULTIPLE_CLIENT_FLAG,
	CHOPPED_COMBINED_NAME,
	MCO_AUTHORITY_ENDS_DATE,
	LANGUAGES,
	RACE,
	SHARED_CODE,
	CITY_OPTED_OUT,
	SCHED,
	CORP_FLAG,
	SERVU60,
	ACTION_BY_USER,
	REGIONAREA,
	CASE_MGR_PHONE
) as 
SELECT  
    t.$1 AS  CCU_Contract
   ,t.$2 AS CCU_Agreement
   ,t.$3 AS CCU_Program_Type
   ,t.$4 AS Client_IDoA
   ,t.$5 AS Last_Name
   ,t.$6 AS First_Name 
   ,t.$7 AS ReLook_Early_Warning_Flag
   ,t.$8 AS Address1
   ,t.$9 AS Address2
   ,t.$10 AS City
   ,t.$11 AS Zip
   ,SUBSTR(t.$12,1,4)||'-'|| SUBSTR(T.$12,5,2)||'-'||SUBSTR(T.$12,7,2) AS Determination_Date 
   ,t.$13 AS Assessment_Score
   ,SUBSTR(t.$14,1,4)||'-'|| SUBSTR(T.$14,5,2)||'-'||SUBSTR(T.$14,7,2) AS Initial_Service_Date
   ,t.$15 AS Avail_Income
   ,t.$16 AS Number_Receiving
   ,t.$17 AS Served_by_Family_Member  
   ,t.$18 AS Fee_Schedule
   ,t.$19 AS Type_Service
   ,t.$20 AS Action_Type
   ,SUBSTR(t.$21,1,4)||'-'|| SUBSTR(T.$21,5,2)||'-'||SUBSTR(T.$21,7,2) AS Action_Date
   ,t.$22 AS Vendor_Max
   ,t.$23 AS Vendor_FEIN_AG_PT
   ,t.$24 AS UNUSED_3
   ,t.$25 AS NSP_Flag
   ,t.$26 AS UNUSED_6 
   ,t.$27 AS UNUSED_4 
   ,t.$28 AS UNUSED_14
   ,t.$29 AS Used_for_AREA
   ,t.$30 AS ServU50_Flag
   ,t.$31 AS UNUSED6
   ,t.$32 AS UNUSED4
   ,t.$33 AS UNUSED14
   ,t.$34 AS Combined_Client_Name 
   ,t.$35 AS Update_Flag 
   ,t.$36 AS Service_1_Units
   ,t.$37 AS Service_2_Units
   ,t.$38 AS Service_3_Units
   ,t.$39 AS Phone
   ,t.$40 AS Copay_YNP
   ,t.$41 AS Copay
   ,t.$42 AS Employee
   ,t.$43 AS Desk_Assigned_Serv_Coord
   ,t.$44 AS DOB
   ,t.$45 AS SEX
   ,t.$46 AS Copay_Responsible_Party 
   ,t.$47 AS ADDRESS
   ,t.$48 AS Phone14
   ,t.$49 AS Relationship
   ,t.$50 AS City_20
   ,t.$51 AS State2
   ,t.$52 AS zip5
   ,SUBSTR(t.$53,1,4)||'-'|| SUBSTR(T.$53,5,2)||'-'||SUBSTR(T.$53,7,2) AS Case_Action_Date 
   ,t.$54 AS Area2
   ,t.$55 AS Private_Pay_Rate
   ,SUBSTR(t.$56,1,4)||'-'|| SUBSTR(T.$56,5,2)||'-'||SUBSTR(T.$56,7,2) AS Created_on
   ,t.$57 AS Created_By
   ,SUBSTR(t.$58,1,4)||'-'|| SUBSTR(T.$58,5,2)||'-'||SUBSTR(T.$58,7,2) AS Updated_On
   ,t.$59 AS Updated_By
   ,t.$60 AS Family_Reason
   ,t.$61 AS Medicaid_Recp_Y_N_P
   ,t.$62 AS CCU_Lookup_ID
   ,t.$63 AS County
   ,t.$64 AS CCU_Fein
   ,t.$65 AS Emergency_Phone_Contact
   ,t.$66 AS Emergency_Name_Contact
   ,t.$67 AS Private_Pay_Billing_Cycle
   ,SUBSTR(t.$68,1,4)||'-'|| SUBSTR(T.$68,5,2)||'-'||SUBSTR(T.$68,7,2) AS Last_Billing_Date
   ,t.$69 AS New_Field_Old_SSN
   ,t.$70 AS Hmkr_Name
   ,t.$71 AS Case_Mgr 
   ,t.$72 AS CPT_VET_MCO    
   ,t.$73 AS Diag_VET_MCO 
   ,t.$74 AS Multiple_Client_Flag 
   ,t.$75 AS chopped_combined_name
   ,t.$76 AS MCO_Authority_Ends_Date
   ,t.$77 AS Languages
   ,t.$78 AS Race
   ,t.$79 AS Shared_Code
   ,t.$80 AS City_Opted_Out
   ,t.$81 AS Sched
   ,t.$82 AS Corp_Flag
   ,t.$83 AS ServU60
   ,t.$84 AS Action_by_User
   ,t.$85 AS RegionArea
   ,t.$86 AS Case_Mgr_Phone  
FROM
@DISC_PROD.STAGE.AZSTAGEPROD/FilePro/masterclient (file_format => DISC_PROD.PUBLIC.CSV_FORMAT ) t;
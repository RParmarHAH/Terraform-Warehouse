create or replace view DISC_PROD.DEVERO.VIEW_DEVERO_FORM(
	FORM_ID,
	CAREGIVER_CODE,
	FORM_NAME,
	VISIT_DATE,
	DATE_CREATED,
	DATE_MODIFIED,
	PATIENT_CODE,
	CHART_NUMBER,
	CERTIFICATION_NUMBER,
	DATE_FIRST_SENT_TO_OFFICE,
	DATE_LAST_SENT_TO_OFFICE,
	BILLING_CODE,
	FORM_STATUS,
	REMOVED,
	RFA_CODE,
	OASIS_HIS,
	OASIS_VERSION,
	VENDOR_CODE,
	ORDER_TYPE,
	IS_VISIT,
	TO_BE_SIGNED,
	ADMISSION_ID,
	NOTE_ID,
	MEDICALRECORDNO,
	BILLINGCODE,
	M0064SSN,
	M0064_SSN,
	TIMEIN,
	TIMEOUT,
	VISITDATE,
	CASEMANAGERID,
	PRIMARYINSURANCEID,
	NOH_LOCATIONAME_TXT,
	HDR_LOCATIONAME_TXT,
	CPCAGENCYNAME,
	HHAPC_LOCATIONAME_TXT,
	DSC_LOCATIONAME_TXT,
	M0016_BRANCH_ID,
	BILLINGSYSTEMAGENCYID,
	CPCAGENCYID,
	M0040FIRSTNAME,
	M0040LASTNAME,
	M0040_PAT_MI,
	M0040MIDDLEINIT,
	M0066BIRTHDATE,
	M0066_PAT_BIRTH_DT,
	DATEOFDEATH,
	GENDER,
	MAS_MARITALSTATUS_RDO,
	MARITALSTATUS,
	RACEID,
	RACECODE,
	AGE,
	M0040ADDRESS,
	M0040ADDRESS2,
	M0040CITY,
	M0060_PAT_ZIP,
	M0060ZIPCODE,
	M0050_PAT_ST,
	M0040PHONE,
	CELLPHONE,
	PATIENTEMAIL,
	CPC_INSURANCEEFFECTIVEFROM_TXT,
	CPC_INSURANCEEFFECTIVETO_TXT,
	EPISODESTARTDATE,
	CERTIFICATIONTODATE,
	BILLINGSYSTEMPATIENTID,
	SERVICECODEID,
	SERVICECODE,
	FIRSTVISITDATE,
	VISITDATEOUT,
	VISITFREQUENCIESRN,
	SUPERVISORYUSERTYPE,
	HDR_LOCATIONNUMBER_TXT,
	HDR_LOCATIONFAX_TXT,
	HDR_LOCATIONSTATE_TXT,
	HDR_LOCATIONADDRESS_TXT,
	HDR_LOCATIONCITY_TXT,
	HDR_LOCATIONZIP_TXT,
	HDR_LOCATIONPHONE_TXT,
	HHAPC_LOCATIONNUMBER_TXT,
	PHYSICIANID,
	PCPHYSLNAME,
	M0104_PHYSN_RFRL_DT,
	PCPHYSICIANADDRESSCARECOO,
	PCPHYSICIANPHONE,
	PCPHYSICIANADDRESS,
	PCPHYSICIANADDRESS2,
	PCPHYSICIANADDRESS1,
	PCPHYSICIANADDRESSRESPONSIBLE,
	PCPHYSICIANZIPCODE,
	PCPHYSICIANZIPCODE1,
	ADDRESSDETAILS,
	DISCHARGE_REASON,
	DISCHARGEREASONID2,
	PRC_PATIENTAVAILABILITY_TXT,
	PRC_PRIMARYCARENAME_TXT,
	DC_TRANSFERDATE_TXT,
	VTSIG_TEMP_TXT,
	INT_RESPONSEINTERV_TXT,
	LBD_LASTBM_CHK,
	SHN_TIMEIN1_TXT,
	M1021CDATE,
	CP_PROGNOSIS,
	M0150_CPAY_NONE,
	FORM_VALUES,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) as (
WITH XML_DATA AS 
(
	SELECT FORM_ID,FORM_XML
        , ETL_TASK_KEY
		, ETL_INSERTED_TASK_KEY
		, ETL_INSERTED_DATE
		, ETL_INSERTED_BY
		, ETL_LAST_UPDATED_DATE
		, ETL_LAST_UPDATED_BY
		, ETL_DELETED_FLAG
		, ROW_NUMBER() OVER(PARTITION BY FORM_ID ORDER BY DATE_MODIFIED DESC) AS LATEST_MODIFIED FROM DISC_PROD.DEVERO.HIST_DEVERO_FORM 
	QUALIFY LATEST_MODIFIED = 1
)
, FORM_FIELDS AS -- Fetching each field values from FORM_VALUES node along with it's respective FORM_ID
(
    SELECT F.FORM_ID
            , GET(FIELD.VALUE, '@NAME')::STRING AS FIELD_NAME
            , GET(FIELD.VALUE, '$')::STRING AS FIELD_VALUE
    FROM XML_DATA F
            , LATERAL Flatten(XMLGET(PARSE_XML(F.FORM_XML), 'FORM_VALUES'):"$"::ARRAY) FIELD
)
, PVT_FORM_FIELDS AS -- Pivoting form values
(
    SELECT PVT.*
    FROM FORM_FIELDS
    PIVOT
    (
        MAX(FORM_FIELDS.FIELD_VALUE)
        FOR FORM_FIELDS.FIELD_NAME IN
        (
            'supervisoryUserType','TimeIn', 'TimeOut', 'VisitDate', 'hdr_LocationPhone_Txt', 'PrimaryInsuranceID',
            'hdr_LocationNumber_Txt','noh_Locationame_Txt', 'hdr_LocationFax_Txt', 'hdr_LocationState_Txt',
            'hdr_LocationAddress_Txt', 'hdr_LocationCity_Txt', 'hdr_LocationZip_Txt','hhapc_Locationame_Txt', 'hhapc_LocationNumber_Txt',
            'CaseManagerID', 'PhysicianID', 'VisitFrequenciesRN', 'prc_PatientAvailability_Txt', 'prc_PrimaryCareName_Txt',
            'FirstVisitDate','lbd_LastBm_Chk', 'EpisodeStartDate', 'MedicalRecordNo', 'int_ResponseInterv_Txt', 'PCPhysicianPhone',
        	'PCPhysicianAddress', 'shn_TimeIn1_Txt', 'M1021cDate', 'M0040FirstName', 'M0040LastName','M0066BirthDate',
        	'CertificationToDate', 'cp_prognosis', 'PCPhysLName', 'M0104_PHYSN_RFRL_DT', 'M0040Address', 'M0040Address2',
        	'PCPhysicianAddressCareCoo', 'PCPhysicianAddress2', 'PCPhysicianAddress1', 'PCPhysicianAddressResponsible',
        	'AddressDetails', 'Discharge_reason', 'DischargeReasonID2', 'dc_TransferDate_Txt', 'PCPhysicianZipCode',
        	'PCPhysicianZipCode1', 'ServiceCodeID', 'ServiceCode', 'VisitDateOut', 'vtsig_TEMP_Txt', 'BillingSystemPatientId',
        	'M0064_SSN_UK', 'M0064_SSN','Gender','mas_MaritalStatus_Rdo','M0040City', 'M0040Phone','CPCAgencyID','BillingSystemAgencyId',
        	'Age', 'RaceID', 'RaceCode', 'hdr_Locationame_Txt','M0060_PAT_ZIP','CPCAgencyName','dsc_Locationame_Txt',
        	'M0060ZipCode','M0050_PAT_ST','PatientEmail','CellPhone','MaritalStatus','BillingCode','M0016_BRANCH_ID',
        	'M0040_PAT_MI','M0040MiddleInit','M0064SSN','cpc_InsuranceEffectiveFrom_Txt','cpc_InsuranceEffectiveTo_Txt',
        	'DateOfDeath','M0066_PAT_BIRTH_DT', 'M0150_CPAY_NONE'
         )
    ) AS PVT
)
SELECT DISTINCT
		  FORM_DATA.FORM_ID
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'CAREGIVER_CODE'):"$"::STRING AS CAREGIVER_CODE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'FORM_NAME'):"$"::STRING AS FORM_NAME
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'VISIT_DATE'):"$"::STRING AS VISIT_DATE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_CREATED'):"$"::STRING AS DATE_CREATED
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_MODIFIED'):"$"::STRING AS DATE_MODIFIED
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'PATIENT_CODE'):"$"::STRING AS PATIENT_CODE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'CHART_NUMBER'):"$"::STRING AS CHART_NUMBER
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'CERTIFICATION_NUMBER'):"$"::STRING AS CERTIFICATION_NUMBER
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_FIRST_SENT_TO_OFFICE'):"$"::STRING AS DATE_FIRST_SENT_TO_OFFICE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_LAST_SENT_TO_OFFICE'):"$"::STRING AS DATE_LAST_SENT_TO_OFFICE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'BILLING_CODE'):"$"::STRING AS BILLING_CODE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'FORM_STATUS'):"$"::STRING AS FORM_STATUS
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'REMOVED'):"$"::STRING AS REMOVED
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'RFA_CODE'):"$"::STRING AS RFA_CODE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'OASIS_HIS'):"$"::STRING AS OASIS_HIS
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'OASIS_VERSION'):"$"::STRING AS OASIS_VERSION
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'VENDOR_CODE'):"$"::STRING AS VENDOR_CODE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'ORDER_TYPE'):"$"::STRING AS ORDER_TYPE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'IS_VISIT'):"$"::STRING AS IS_VISIT
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'TO_BE_SIGNED'):"$"::STRING AS TO_BE_SIGNED
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'ADMISSION_ID'):"$"::STRING AS ADMISSION_ID
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'NOTE_ID'):"$"::STRING AS NOTE_ID
        , PVT."'MedicalRecordNo'" AS MedicalRecordNo
        , PVT."'BillingCode'" AS BillingCode
        , PVT."'M0064SSN'" AS M0064SSN
        , PVT."'M0064_SSN'" AS M0064_SSN
        , PVT."'TimeIn'" AS TIMEIN
        , PVT."'TimeOut'" AS TIMEOUT
        , PVT."'VisitDate'" AS VISITDATE
        , PVT."'CaseManagerID'" AS CASEMANAGERID
        , PVT."'PrimaryInsuranceID'" AS PRIMARYINSURANCEID
        , PVT."'noh_Locationame_Txt'" AS NOH_LOCATIONAME_TXT
        , PVT."'hdr_Locationame_Txt'" AS hdr_Locationame_Txt
        , PVT."'CPCAgencyName'" AS CPCAgencyName
        , PVT."'hhapc_Locationame_Txt'" AS HHAPC_LOCATIONAME_TXT
        , PVT."'dsc_Locationame_Txt'" AS dsc_Locationame_Txt
        , PVT."'M0016_BRANCH_ID'" AS M0016_BRANCH_ID 
        , PVT."'BillingSystemAgencyId'" AS BillingSystemAgencyId
        , PVT."'CPCAgencyID'" AS CPCAgencyID
        , PVT."'M0040FirstName'" AS M0040FirstName
        , PVT."'M0040LastName'" AS M0040LastName     
        , PVT."'M0040_PAT_MI'" AS M0040_PAT_MI
        , PVT."'M0040MiddleInit'" AS M0040MiddleInit    
        , PVT."'M0066BirthDate'" AS M0066BirthDate
        , PVT."'M0066_PAT_BIRTH_DT'" AS M0066_PAT_BIRTH_DT
        , PVT."'DateOfDeath'" AS DateOfDeath
        , PVT."'Gender'" AS Gender
        , PVT."'mas_MaritalStatus_Rdo'" AS mas_MaritalStatus_Rdo
        , PVT."'MaritalStatus'" AS MaritalStatus
        , PVT."'RaceID'" AS RaceID
        , PVT."'RaceCode'" AS RaceCode
        , PVT."'Age'" AS Age
        , PVT."'M0040Address'" AS M0040Address
        , PVT."'M0040Address2'" AS M0040Address2
        , PVT."'M0040City'" AS M0040City
        , PVT."'M0060_PAT_ZIP'" AS M0060_PAT_ZIP
        , PVT."'M0060ZipCode'" AS M0060ZipCode
        , PVT."'M0050_PAT_ST'" AS M0050_PAT_ST
        , PVT."'M0040Phone'" AS M0040Phone
        , PVT."'CellPhone'" AS CellPhone
        , PVT."'PatientEmail'" AS PatientEmail
        , PVT."'cpc_InsuranceEffectiveFrom_Txt'" AS cpc_InsuranceEffectiveFrom_Txt
        , PVT."'cpc_InsuranceEffectiveTo_Txt'" AS cpc_InsuranceEffectiveTo_Txt
        , PVT."'EpisodeStartDate'" AS EpisodeStartDate
        , PVT."'CertificationToDate'" AS CertificationToDate
        , PVT."'BillingSystemPatientId'" AS BillingSystemPatientId
        , PVT."'ServiceCodeID'" AS ServiceCodeID
        , PVT."'ServiceCode'" AS ServiceCode
        , PVT."'FirstVisitDate'" AS FirstVisitDate
        , PVT."'VisitDateOut'" AS VisitDateOut
        , PVT."'VisitFrequenciesRN'" AS VisitFrequenciesRN
        , PVT."'supervisoryUserType'" AS SUPERVISORYUSERTYPE
        , PVT."'hdr_LocationNumber_Txt'" AS HDR_LOCATIONNUMBER_TXT
        , PVT."'hdr_LocationFax_Txt'" AS HDR_LOCATIONFAX_TXT
        , PVT."'hdr_LocationState_Txt'" AS HDR_LOCATIONSTATE_TXT
        , PVT."'hdr_LocationAddress_Txt'" AS HDR_LOCATIONADDRESS_TXT
        , PVT."'hdr_LocationCity_Txt'" AS HDR_LOCATIONCITY_TXT
        , PVT."'hdr_LocationZip_Txt'" AS HDR_LOCATIONZIP_TXT
        , PVT."'hdr_LocationPhone_Txt'" AS HDR_LOCATIONPHONE_TXT
        , PVT."'hhapc_LocationNumber_Txt'" AS HHAPC_LOCATIONNUMBER_TXT
        , PVT."'PhysicianID'" AS PHYSICIANID
        , PVT."'PCPhysLName'" AS PCPhysLName
        , PVT."'M0104_PHYSN_RFRL_DT'" AS M0104_PHYSN_RFRL_DT
        , PVT."'PCPhysicianAddressCareCoo'" AS PCPhysicianAddressCareCoo
        , PVT."'PCPhysicianPhone'" AS PCPhysicianPhone
        , PVT."'PCPhysicianAddress'" AS PCPhysicianAddress
        , PVT."'PCPhysicianAddress2'" AS PCPhysicianAddress2
        , PVT."'PCPhysicianAddress1'" AS PCPhysicianAddress1
        , PVT."'PCPhysicianAddressResponsible'" AS PCPhysicianAddressResponsible
        , PVT."'PCPhysicianZipCode'" AS PCPhysicianZipCode
        , PVT."'PCPhysicianZipCode1'" AS PCPhysicianZipCode1
        , PVT."'AddressDetails'" AS AddressDetails
        , PVT."'Discharge_reason'" AS Discharge_reason
        , PVT."'DischargeReasonID2'" AS DischargeReasonID2
        , PVT."'prc_PatientAvailability_Txt'" AS prc_PatientAvailability_Txt
        , PVT."'prc_PrimaryCareName_Txt'" AS prc_PrimaryCareName_Txt
        , PVT."'dc_TransferDate_Txt'" AS dc_TransferDate_Txt
        , PVT."'vtsig_TEMP_Txt'" AS vtsig_TEMP_Txt
        , PVT."'int_ResponseInterv_Txt'" AS int_ResponseInterv_Txt
        , PVT."'lbd_LastBm_Chk'" AS lbd_LastBm_Chk
        , PVT."'shn_TimeIn1_Txt'" AS shn_TimeIn1_Txt
        , PVT."'M1021cDate'" AS M1021cDate   
        , PVT."'cp_prognosis'" AS cp_prognosis
        , PVT."'M0150_CPAY_NONE'" AS M0150_CPAY_NONE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'FORM_VALUES'):"$"::VARIANT AS FORM_VALUES
        , FORM_DATA.ETL_TASK_KEY
		, FORM_DATA.ETL_INSERTED_TASK_KEY
		, FORM_DATA.ETL_INSERTED_DATE
		, FORM_DATA.ETL_INSERTED_BY
		, FORM_DATA.ETL_LAST_UPDATED_DATE
		, FORM_DATA.ETL_LAST_UPDATED_BY
		, FORM_DATA.ETL_DELETED_FLAG
FROM XML_DATA FORM_DATA(NODE)
LEFT JOIN PVT_FORM_FIELDS AS PVT -- Joining form file with pivot dataset to pull its field value by FORM_ID
    ON PVT.FORM_ID = FORM_DATA.FORM_ID
--WHERE DATE(FORM_DATA.ETL_LAST_UPDATED_DATE) = COALESCE((
--SELECT MAX(DATE(ETL_LAST_UPDATED_DATE)) FROM DISC_PROD.DEVERO.HIST_DEVERO_FORM),DATE(GETDATE()))
);
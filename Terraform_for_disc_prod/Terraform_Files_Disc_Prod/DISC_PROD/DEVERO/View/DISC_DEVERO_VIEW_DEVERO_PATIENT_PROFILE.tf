resource "snowflake_view" "DISC_DEVERO_VIEW_DEVERO_PATIENT_PROFILE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "VIEW_DEVERO_PATIENT_PROFILE"
	statement = <<-SQL
	 (
WITH XML_DATA AS 
(
	SELECT FORM_ID
	    , PATIENT_CODE
        , CHART_NUMBER
	    , FORM_XML
        , ETL_TASK_KEY
		, ETL_INSERTED_TASK_KEY
		, ETL_INSERTED_DATE
		, ETL_INSERTED_BY
		, ETL_LAST_UPDATED_DATE
		, ETL_LAST_UPDATED_BY
		, ETL_DELETED_FLAG
		, ROW_NUMBER() OVER(PARTITION BY PATIENT_CODE,CHART_NUMBER ORDER BY DATE_MODIFIED DESC) AS LATEST_MODIFIED 
		FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PATIENT_PROFILE 
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
        	 'PrimaryInsuranceID','PrimaryInsuranceName','SecondaryInsuranceID','SecondaryInsuranceName','Medicarenum',
        	 'M0064SSN','M0066BirthDate','DateOfDeath','Gender','RaceID', 'RaceCode',
        	 'MaritalStatus','M0040FirstName','M0040MiddleInit','M0040LastName','M0040Address',
        	 'M0040Address2','M0040City','M0050','M0060ZipCode','M0040Phone','CellPhone','PatientEmail','ReferralDate',
        	 'cpc_InsuranceEffectiveFrom_Txt','cpc_InsuranceEffectiveTo_Txt','CPCStatusID','CaseManagerID',
        	 'CPCAgencyID','CPCAgencyName','CPCAgencyState','MedicalRecordNo','BillingSystemPatientId',
        	 'StartOfCareDate','reflname','reffname','MajorCrossStreet','Age'      
         )
    ) AS PVT
)
SELECT DISTINCT
          XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'PATIENT_CODE'):"$"::STRING AS PATIENT_CODE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'CHART_NUMBER'):"$"::STRING AS CHART_NUMBER
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'CERTIFICATION_NUMBER'):"$"::STRING AS CERTIFICATION_NUMBER
		, FORM_DATA.FORM_ID
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_CREATED'):"$"::STRING AS DATE_CREATED
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_MODIFIED'):"$"::STRING AS DATE_MODIFIED
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_FIRST_SENT_TO_OFFICE'):"$"::STRING AS DATE_FIRST_SENT_TO_OFFICE
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'DATE_LAST_SENT_TO_OFFICE'):"$"::STRING AS DATE_LAST_SENT_TO_OFFICE
        , PVT."'PrimaryInsuranceID'" AS PrimaryInsuranceID
        , PVT."'PrimaryInsuranceName'" AS PrimaryInsuranceName
        , PVT."'SecondaryInsuranceID'" AS SecondaryInsuranceID
        , PVT."'SecondaryInsuranceName'" AS SecondaryInsuranceName
        , PVT."'Medicarenum'" AS Medicarenum
        , PVT."'M0064SSN'" AS M0064SSN
        , PVT."'M0066BirthDate'" AS M0066BirthDate
        , PVT."'DateOfDeath'" AS DateOfDeath
        , PVT."'Gender'" AS Gender
        , PVT."'RaceID'" AS RaceID
        , PVT."'RaceCode'" AS RaceCode
        , PVT."'MaritalStatus'" AS MaritalStatus
        , PVT."'M0040FirstName'" AS M0040FirstName
        , PVT."'M0040MiddleInit'" AS M0040MiddleInit
        , PVT."'M0040LastName'" AS M0040LastName 
        , PVT."'M0040Address'" AS M0040Address
        , PVT."'M0040Address2'" AS M0040Address2
        , PVT."'M0040City'" AS M0040City
        , PVT."'M0050'" AS M0050State
        , PVT."'M0060ZipCode'" AS M0060ZipCode
        , PVT."'M0040Phone'" AS M0040Phone
        , PVT."'CellPhone'" AS CellPhone
        , PVT."'PatientEmail'" AS PatientEmail
        , PVT."'ReferralDate'" AS ReferralDate
        , PVT."'cpc_InsuranceEffectiveFrom_Txt'" AS cpc_InsuranceEffectiveFrom_Txt
        , PVT."'cpc_InsuranceEffectiveTo_Txt'" AS cpc_InsuranceEffectiveTo_Txt
        , PVT."'CPCStatusID'" AS CPCStatusID
        , PVT."'CaseManagerID'" AS CASEMANAGERID
        , PVT."'CPCAgencyID'" AS CPCAgencyID
        , PVT."'CPCAgencyName'" AS CPCAgencyName
        , PVT."'CPCAgencyState'" AS CPCAgencyState
        , PVT."'MedicalRecordNo'" AS MedicalRecordNo
        , PVT."'BillingSystemPatientId'" AS BillingSystemPatientId
        , PVT."'StartOfCareDate'" AS StartOfCareDate
        , PVT."'reflname'" AS reflname
 		, PVT."'reffname'" AS reffname
 		, PVT."'MajorCrossStreet'" AS MajorCrossStreet
        , PVT."'Age'" AS Age
        , XMLGET(PARSE_XML(FORM_DATA.FORM_XML), 'FORM_VALUES'):"$"::VARIANT AS FORM_VALUES
        , FORM_DATA.ETL_TASK_KEY
		, FORM_DATA.ETL_INSERTED_TASK_KEY
		, FORM_DATA.ETL_INSERTED_DATE
		, FORM_DATA.ETL_INSERTED_BY
		, FORM_DATA.ETL_LAST_UPDATED_DATE
		, FORM_DATA.ETL_LAST_UPDATED_BY
		, FORM_DATA.ETL_DELETED_FLAG
FROM XML_DATA FORM_DATA
LEFT JOIN PVT_FORM_FIELDS AS PVT -- Joining form file with pivot dataset to pull its field value by FORM_ID
    ON PVT.FORM_ID = FORM_DATA.FORM_ID
--WHERE DATE(FORM_DATA.ETL_LAST_UPDATED_DATE) = (
--SELECT MAX(DATE(ETL_LAST_UPDATED_DATE)) FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_PATIENT_PROFILE)
);
SQL
	or_replace = true 
	is_secure = false 
}


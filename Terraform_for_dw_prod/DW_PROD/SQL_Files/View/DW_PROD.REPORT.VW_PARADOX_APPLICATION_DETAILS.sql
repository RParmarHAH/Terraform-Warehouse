create or replace view DW_PROD.REPORT.VW_PARADOX_APPLICATION_DETAILS(
	CANDIDATE_ID,
	"First Name",
	"Middle Name",
	"Last Name",
	"Social Security Number",
	"Date of Birth",
	"Email",
	"Time zone",
	"Address",
	"Address Line 2",
	"City",
	"County",
	"State",
	"Zip Code",
	COUNTRY,
	"Branch (Group)",
	"Branch STATE",
	"Phone",
	"Home Phone",
	"Gender",
	"AlayaCare Group ID",
	"AlayaCare Cost Center ID",
	"Position/Job",
	"AlayaCare Admin Role ID",
	"AlayaCare Field Role Portal ID",
	"HAH office number",
	CREATED_DATE,
	UPDATED_DATE
) as 
WITH CANDIDATES_WITH_PDR_STATUS AS (
    select distinct CANDIDATE_ID::varchar CANDIDATE_ID, REQUISITION_ID, STATUS, MAX(STATUS_CHANGE_DATE) STATUS_CHANGE_DATE  
    from disc_prod.paradox.candidate_journey_status_history
    WHERE STATUS = 'Orientation/ Hired: Pending Document Review'
    GROUP BY 1, 2, 3
)
SELECT
    distinct
    S.CANDIDATE_ID,
    A.FIRST_NAME "First Name",
    A.MIDDLE_NAME "Middle Name",
    A.LAST_NAME "Last Name",
    A.SSN "Social Security Number",
    A.DATE_OF_BIRTH "Date of Birth",
    A.EMAIL "Email",
    COALESCE(CS.CANDIDATE_TIMEZONE, Z.TIMEZONE) "Time zone",
    A.ADDRESS "Address",
    A.ADDRESS_LINE_2 "Address Line 2",
    A.CITY "City",
    G.STATE_ISO_CODE || ' ' || REPLACE(G.COUNTY_NAME, ' County', '') "County",
    CASE 
        WHEN TRIM(LOWER(A.STATE)) = 'pennsylvania'
            THEN 'PA'
        WHEN TRIM(LOWER(A.STATE)) = 'georgia'
            THEN 'GA'
        WHEN TRIM(LOWER(J.STATE)) = 'missouri'
            THEN 'MO'
        ELSE
            UPPER(A.STATE)
    END "State",
    A.POSTAL "Zip Code",
    CS.CANDIDATE_LOCATION_COUNTRY Country,
    J.LOCATION_NAME "Branch (Group)",
    CASE 
        WHEN TRIM(LOWER(J.STATE)) = 'pennsylvania'
            THEN 'PA'
        WHEN TRIM(LOWER(J.STATE)) = 'georgia'
            THEN 'GA'
        WHEN TRIM(LOWER(J.STATE)) = 'missouri'
            THEN 'MO'
        ELSE
            J.STATE
    END "Branch STATE", 
    A.MOBILE_PHONE "Phone",
    A.HOME_PHONE "Home Phone",
    A.EEO_SEX "Gender",
    
  CASE
	  WHEN  REGEXP_REPLACE(TRIM(UPPER(GL.PROPERTIES_DESCRIPTION)), '- ', '')IN (REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA','ATLANTA CENTRAL'),(REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA NORTH EAST','ATLANTA NORTH EAST')))
	  THEN GL.GROUP_ID 
	  WHEN TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2))ILIKE 'SAVANNAH%'
	  THEN '1018'
	  END "AlayaCare Group ID",
  
  CASE
	  WHEN  REGEXP_REPLACE(TRIM(UPPER(CCL.PROPERTIES_DESCRIPTION)), '- ', '')IN (REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA','ATLANTA CENTRAL'),(REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA NORTH EAST','ATLANTA NORTH EAST')))
	  THEN CCL.ID 
	  WHEN TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2))ILIKE 'SAVANNAH%'
	  THEN '13'
	  END "AlayaCare Cost Center ID",
    J.JOB_TITLE "Position/Job",
    ADMIN_ROLE.ID "AlayaCare Admin Role ID",
    FIELD_ROLE.ID "AlayaCare Field Role Portal ID",
    BR.OFFICE_NUMBER "HAH office number",
    CS.CAPTURE_START_DATE CREATED_DATE,
//    S.MOST_RECENT_STAGE_DATETIME UPDATED_DATE
    PDR.STATUS_CHANGE_DATE UPDATED_DATE
FROM DW_PROD.HAH.FACT_APPLICANT_STATUS S
    INNER JOIN DW_PROD.HAH.DIM_APPLICANT A ON S.APPLICANT_KEY = A.APPLICANT_KEY
    INNER JOIN DW_PROD.HAH.DIM_JOB J ON S.JOB_KEY = J.JOB_KEY
    INNER JOIN CANDIDATES_WITH_PDR_STATUS PDR ON S.CANDIDATE_ID = PDR.CANDIDATE_ID AND J.JOB_ID = PDR.REQUISITION_ID
    LEFT JOIN DISC_PROD.PARADOX.CANDIDATE_SPECIFIC CS ON S.CANDIDATE_ID = CS.CANDIDATE_ID
    LEFT JOIN DISC_PROD.ALAYACARE.TBL_COST_CENTRES_TIER_4 CCL ON REGEXP_REPLACE(TRIM(UPPER(CCL.PROPERTIES_DESCRIPTION)), '- ', '') IN (REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA','ATLANTA CENTRAL'),
                                                                                                                                       (REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA NORTH EAST','ATLANTA NORTH EAST')))
    LEFT JOIN DISC_PROD.ALAYACARE.GROUPS GL ON REGEXP_REPLACE(TRIM(UPPER(GL.PROPERTIES_DESCRIPTION)), '- ', '') IN (REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA','ATLANTA CENTRAL'),
                                                                                                                    (REPLACE(REPLACE(REPLACE(TRIM(UPPER(CANDIDATE_LOCATION__LEVEL_2)), ' OFFICE', ''),'- ',''),'ATLANTA NORTH EAST','ATLANTA NORTH EAST')))
    LEFT JOIN DISC_PROD.PARADOX.JOB_TITLE_TO_ALAYACARE_SECURITY_ROLE_MAPPING_GA ROLE_MAPPING ON UPPER(TRIM(ROLE_MAPPING.JOB_TITLE)) = UPPER(TRIM(J.JOB_TITLE))
    LEFT JOIN DISC_PROD.ALAYACARE.ROLES ADMIN_ROLE ON UPPER(TRIM(ROLE_MAPPING.ALAYACARE_ADMIN_PORTAL_ROLE)) = UPPER(TRIM(ADMIN_ROLE.DESCRIPTION)) AND ADMIN_ROLE.PORTAL = 'admin'
    LEFT JOIN DISC_PROD.ALAYACARE.ROLES FIELD_ROLE ON UPPER(TRIM(ROLE_MAPPING.ALAYACARE_FIELD_PORTAL_ROLE)) = UPPER(TRIM(FIELD_ROLE.DESCRIPTION)) AND FIELD_ROLE.PORTAL = 'staff'
    LEFT JOIN DW_PROD.HAH.DIM_GEOGRAPHY G ON A.POSTAL = G.ZIP_CODE
    LEFT JOIN DW_PROD.HAH.DIM_ZIP_CODE_DETAILED Z ON A.POSTAL = Z.ZIP
    LEFT JOIN DW_PROD.HAH.DIM_BRANCH BR ON LOWER(TRIM(J.STATE)) = 'missouri' and S.BRANCH_KEY = BR.BRANCH_KEY
WHERE
    S.SOURCE_SYSTEM_ID = 12
    and "Branch STATE" = 'GA';
resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_SANDATAIMPORT_DIM_EMPLOYEE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_SANDATAIMPORT_DIM_EMPLOYEE"
	statement = <<-SQL
	 WITH 
-- offbrnch AS
-- (
-- SELECT DISTINCT HomeLocation
--      , CASE WHEN HomeLocation = '' OR HomeLocation = 'HAH' THEN '-1' ELSE brnch.Office_Number END AS Employee_Office_Number
--      , CASE WHEN HomeLocation = '' THEN '2a3546e9ff960b04725a1f6823cd5b94' WHEN HomeLocation = 'HAH' THEN '26090ef061fef40345a2fd24d38353fc' ELSE brnch.Branch_Key END AS Primary_Branch_Key
--      , CASE WHEN HomeLocation = '' THEN 'Unknown-PA' WHEN HomeLocation = 'HAH' THEN 'HAH' ELSE brnch.Detailed_Office_Name END AS Primary_Branch_Name
--      , CASE WHEN HomeLocation = '' THEN '8485' WHEN HomeLocation = 'HAH' THEN '8485' ELSE brnch.System_Code END AS Primary_Branch_System_Code
--      , CASE WHEN HomeLocation = '' THEN 'PA' WHEN HomeLocation = 'HAH' THEN 'PA' ELSE brnch.Office_State_Code END AS Primary_Branch_State
-- FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Staffs AS stf
-- LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS AS eid ON stf.HomeLocation = eid.ExtID AND eid.Typ = 'L'
-- LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch ON LPAD( CAST( brnch.Office_Number AS VARCHAR), 3, '0') = LPAD( TRIM( eid.IntID), 3, '0') AND brnch.Source_System_ID = 4
-- WHERE AgencyID = '8485'
-- AND Person = 'TRUE'
-- ),
employee_service_dates
AS
(
SELECT ss.AgencyID, sst.StaffID AS Employee_Number, CAST( MIN( ss.ScheduleDate) AS DATE) AS First_Service_Date, CAST( MAX( ss.ScheduleDate) AS DATE) AS Last_Service_Date
FROM DISC_${var.SF_ENVIRONMENT}.SanDataImport.SanData_Schedules AS ss
INNER JOIN DISC_${var.SF_ENVIRONMENT}.SanDataImport.SanData_SchedulesStaffs AS sst ON ss.AgencyID = sst.AgencyID AND ss.ScheduleID = sst.ScheduleID AND sst.Status IN ( '05')
WHERE ss.AgencyID = '8485'
AND ss.Status NOT IN ( '01', '09', '10')
GROUP BY ss.AgencyID, sst.StaffID
)
SELECT
       MD5(NVL(stf.AGENCYID,'S') || '-' || UPPER(NVL(COALESCE(TRY_CAST(stf.STAFFAGENCYID AS INT)::STRING, TRIM(stf.STAFFAGENCYID)), '')) || '-' || '1900-01-01' || '-' || 'SANDATAIMPORT') AS Employee_key
FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_Staffs AS stf
-- INNER JOIN offbrnch ON offbrnch.HomeLocation = stf.HomeLocation
LEFT OUTER JOIN HAH.DIM_BRANCH AS BRANCH ON BRANCH.SYSTEM_CODE = stf.AGENCYID AND BRANCH.OFFICE_CODE = stf.HOMELOCATION
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.TrustPointData.Employees AS tp ON tp.COMPANY = 'EXCEL' AND stf.AGENCYID = '8485' AND TRY_CAST(tp.EMPLOYEE_NUMBER AS INT) = TRY_CAST(stf.STAFFAGENCYID AS INTEGER) --stf.ID = tp.ID
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = IFF( TRIM( UPPER( stf.State))='', UPPER( tp.Employee_State_Code), TRIM( UPPER( stf.State)))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = IFF( TRIM( UPPER( stf.Zip))='', UPPER( tp.Employee_Zip), TRIM( UPPER( stf.Zip)))
--LEFT OUTER JOIN employee_service_dates AS csd ON csd.AgencyID = stf.AgencyID AND csd.Employee_Number = stf.StaffID
WHERE stf.AgencyID = '8485'
AND stf.Person = 'TRUE'
AND stf.ETL_DELETED_FLAG = TRUE
AND CAST(stf.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_Staffs)
UNION
SELECT
       MD5(NVL(stf.AGENCYID,'S') || '-' || UPPER(NVL(COALESCE(TRY_CAST(tp.Employee_Number AS VARCHAR(100)), TRIM(tp.Employee_Number)), '')) || '-' || '1900-01-01' || '-' || 'TrustPointData') AS Employee_key
FROM DISC_${var.SF_ENVIRONMENT}.TrustPointData.HIST_Employees AS tp
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Staffs AS stf ON stf.AGENCYID = '8485' AND stf.Person = 'TRUE' AND TRY_CAST(tp.EMPLOYEE_NUMBER AS INT) = TRY_CAST(stf.STAFFAGENCYID AS INTEGER)
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON brnch.SOURCE_SYSTEM_ID = 4 AND brnch.OFFICE_NUMBER = tp.EMPLOYEE_OFFICE_NUMBER
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( tp.Employee_State_Code)
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = UPPER( tp.Employee_Zip)
--LEFT OUTER JOIN employee_service_dates AS csd ON csd.AgencyID = stf.AgencyID AND csd.Employee_Number = stf.StaffID
WHERE tp.COMPANY = 'EXCEL' AND tp.Employee_Number NOT IN (SELECT CAST( emp.STAFFAGENCYID AS INTEGER)
                                 FROM DISC_${var.SF_ENVIRONMENT}.SanDataImport.Sandata_Staffs AS emp
                                 WHERE AgencyID = 8485
                                 AND emp.Person = 'TRUE')
AND tp.ETL_DELETED_FLAG = TRUE
AND CAST(tp.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_${var.SF_ENVIRONMENT}.TrustPointData.HIST_Employees);
SQL
	or_replace = true 
	is_secure = false 
}


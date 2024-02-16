CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ROSTER_FACT_CLIENT_STATUS_HISTORY()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'BEGIN
--*****************************************************************************************************************************
-- NAME:  ROSTER_FACT_CLIENT_STATUS_HISTORY
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   ------------------------------------------------------------------------------------------
-- 03/10/23    POOJA DEOKATE          Initial development
--*****************************************************************************************************************************
-- This procedure is created w/o any logic. Because current ADF pipeline do not support business layer structure
-- without DELETE procedure. It should have three procedures GET, MERGE & DELETE
RETURN ''Message : Done'';
END';
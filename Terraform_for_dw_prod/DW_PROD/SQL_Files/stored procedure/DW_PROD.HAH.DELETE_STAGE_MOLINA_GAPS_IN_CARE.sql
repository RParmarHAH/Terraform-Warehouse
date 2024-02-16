CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_MOLINA_GAPS_IN_CARE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'BEGIN
--*****************************************************************************************************************************
-- NAME:  MOLINA_GAPS_IN_CARE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   ------------------------------------------------------------------------------------------
-- 08/07/23    ASHISH SHARMA          Initial development
--*****************************************************************************************************************************
-- This pocedure is created w/o any logic. Because current ADF pipeline do not support business layer structure
-- without DELETE procedure. It should have three procedures GET, MERGE & DELETE
RETURN ''Message : Done'';
END';
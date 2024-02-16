CREATE OR REPLACE PROCEDURE DISC_PROD.PUBLIC.TESTING_RETURN_STATEMENT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
    return_result_temp VARCHAR;
BEGIN
	
	return_result:='''';
--inset

SELECT ''5 ROW  INSERTED'' INTO :return_result_temp;

	return_result:= CONCAT(return_result,'' | '',return_result_temp);

--merge

	SELECT ''7 ROW  uPDATED'' INTO :return_result_temp;

	return_result:= CONCAT(return_result,'' | '',return_result_temp);
	
--delete

SELECT ''2 ROW  dELETE'' INTO :return_result_temp;

	return_result:= CONCAT(return_result,'' | '',return_result_temp);
	
	return concat(''Message : '',return_result);

END;

';
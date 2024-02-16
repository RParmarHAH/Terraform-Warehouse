CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.UPDATE_EMPLOYEE_KEYRING_BY_WORKDAY_ID("ENVIRONMENT" VARCHAR(16777216), "input_data" VARCHAR(16777216))
RETURNS VARIANT
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'update_employee_data'
EXECUTE AS OWNER
AS '
import pandas 
import json

# This is a stored procedure that updates employee data in the DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK table.
# The procedure takes one input parameter, which is a JSON string containing the employee data.

def update_employee_data(snowpark_session,ENVIRONMENT,input_data ):
  try:
    input_data = json.loads(input_data)
    input_data = input_data[0]
    column_values = {
      ''EMPLOYEE_ENTERPRISE_ID'': input_data.get("WORKDAY_ID"),
      ''AMS_EMPLOYEE_ID'': input_data.get("AMS_EMPLOYEE_ID"),
      ''LOCATION_HIERARCHY'': input_data.get("LOCATION_HIERARCHY"),
      ''AMS_COST_CENTER_HIERARCHY'': input_data.get("AMS_COST_CENTER_HIERARCHY")
    }


# Check to make sure that all of the mandatory columns are present in the input data.
    if any(Value is None for Value in column_values.values()):
      res = json.loads(''''''{ "Message": "Mandatory column(s) is/are missing from input data or column name is incorrectly spelled, refer below list : [ WORKDAY_ID, AMS_EMPLOYEE_ID, COST_CENTER_HIERARCHY, LOCATION_HIERARCHY, ENVIRONMENT, VERSION ]","ErrorCode": "2"}'''''')
      return res

    column_values["ENVIRONMENT"] = "DW_" + str(ENVIRONMENT)


# Check to make sure that WORKDAY_ID/EMPLOYEE_ENTERPRISE_ID of input data available in table and also active.
    select_sql1 = f''''''SELECT * FROM {column_values["ENVIRONMENT"]}.INTEGRATION.EMPLOYEE_CROSS_WALK
                    WHERE WORKDAY_INTERNAL_ID = ''{input_data.get("WORKDAY_ID")}'' AND NVL(INACTIVE,0) <> TRUE AND NVL(DUP_FLAG,0) <> TRUE
                    ''''''
    select_df1 = snowpark_session.sql(select_sql1)
    pandasDf1 = select_df1.toPandas()
    if not pandasDf1.shape[0]:
      res = json.loads(''''''{ "Message": "Data not available in keyring for mentioned Workday Id","ErrorCode": "3"}'''''')
      return res

# Check to make sure that COST_CENTER_HIERARCHY and LOCATION_HIERARCHY of input data available in table 
    select_sql = f''''''SELECT SOURCE_SYSTEM_ID,SYSTEM_CODE 
                        FROM {column_values["ENVIRONMENT"]}.INTEGRATION.SOURCE_SYSTEM_MAPPING_FOR_KEYRING
                        WHERE (AMS_COST_CENTER_HIERARCHY ILIKE ''{column_values["AMS_COST_CENTER_HIERARCHY"]}'' OR CONTAINS(SYSTEM_NAME, UPPER(''{column_values["AMS_COST_CENTER_HIERARCHY"]}''))) 
                            AND LOCATION_HIERARCHY ILIKE ''{column_values["LOCATION_HIERARCHY"]}'' AND STATE IS NOT NULL ORDER BY 1 ASC
                    ''''''
    select_df = snowpark_session.sql(select_sql)
    pandasDf = select_df.toPandas()
    if not pandasDf.shape[0]:
      res = json.loads(''''''{ "Message": "Given Value of LOCATION_HIERARCHY or AMS_COST_CENTER_HIERARCHY not found","ErrorCode": "3"}'''''')
      return "Given Value of LOCATION_HIERARCHY or AMS_COST_CENTER_HIERARCHY not found"

# Dictionary of the column which needed in Updating the table
    column_val = {''WORKDAY_INTERNAL_ID'': input_data.get("WORKDAY_ID"),''AMS_EMPLOYEE_ID'': input_data.get("AMS_EMPLOYEE_ID"),''AMS_SOURCE_SYSTEM_ID'':pandasDf[''SOURCE_SYSTEM_ID''][0],''AMS_SYSTEM_CODE'' : pandasDf[''SYSTEM_CODE''][0]}

# including the Optional Column in Dictionary if available in input data 
    if "AMS_PUBLIC_ID" in input_data:
      column_val["AMS_PUBLIC_ID"] = input_data.get("AMS_PUBLIC_ID")

    if "AMS_IVR_ID" in input_data:
      column_val["AMS_IVR_ID"] = input_data.get("AMS_IVR_ID")

# Update Query
    update_sql = f''''''
                    UPDATE {column_values["ENVIRONMENT"]}.INTEGRATION.EMPLOYEE_CROSS_WALK
                    SET {'', ''.join([f"{column} = ''{value}''" for column, value in column_val.items()])}
						, AMS_EMPLOYEE_KEY = NULL
						, ETL_LAST_UPDATED_DATE = CURRENT_TIMESTAMP
						, ETL_LAST_UPDATED_BY = CURRENT_USER
                    WHERE WORKDAY_INTERNAL_ID = ''{column_val["WORKDAY_INTERNAL_ID"]}'' and NVL(INACTIVE,0) <> TRUE and NVL(DUP_FLAG,0) <> TRUE
                    ''''''
# Running Update Statement
    snowpark_session.sql(update_sql).collect()
    res = json.loads(''''''{ "Message": "Update successful.","ErrorCode": "1"}'''''')
    return res    

  except Exception as ex:
    return f"An exception occurred: {str(ex)}"
';
CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.SP_WORKDAY_X_ATTRIBUTE_COMPARISION_TABLE_REFRESH()
RETURNS TABLE ()
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'main'
EXECUTE AS OWNER
AS '# The Snowpark package is required for Python Worksheets. 
# You can add more packages by selecting them using the Packages control and then importing them.
 
import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import col
 
def main(session: snowpark.Session): 
    # Your code goes here, inside the "main" handler
    query = f"SELECT  COLUMN_NAME  FROM DW_PROD.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ''DIM_EMPLOYEE_MERGED'' and TABLE_SCHEMA = ''INTEGRATION''  and COLUMN_NAME not in (''SYSTEM_CODE'',''PUBLIC_ID'',''ETL_INFERRED_MEMBER_FLAG'',''ETL_DELETED_FLAG'',''ETL_LAST_UPDATED_BY'',''ETL_LAST_UPDATED_DATE'',''ETL_INSERTED_BY'',''ETL_INSERTED_DATE'',''ETL_INSERTED_TASK_KEY'',''ETL_TASK_KEY'',''EFFECTIVE_TO_DATE'',''EFFECTIVE_FROM_DATE'')"
    df_sql = session.sql(query)
    base_columns = [row[''COLUMN_NAME''] for row in df_sql.collect()]
    # print(base_columns)
    table_name = "DIM_EMPLOYEE_MERGED"

 
    comparison_sql = generate_comparison_sql(session,base_columns, table_name)
    df_sql = session.sql(comparison_sql)
    print(comparison_sql)
    
    return df_sql
    
def get_datatype_sql(session,column_name):
    query = f"SELECT  upper(DATA_TYPE) AS  DATA_TYPE FROM DW_PROD.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ''DIM_EMPLOYEE_MERGED'' and TABLE_SCHEMA = ''INTEGRATION''  and COLUMN_NAME  in (''" + column_name + "'')"
    # print(query)
    df_sql = session.sql(query)
    data_type = [row[''DATA_TYPE''] for row in df_sql.collect()]
    return data_type
    
def generate_comparison_sql(session, base_columns, source_table):
    comparison_columns = []
    row_match_conditions = []
 
    for column in base_columns:
        
        #column_name = column.split("  ")[0]
        datatype = get_datatype_sql(session,column)
        # print(column  )
        # print(datatype)
        ams_column = f"{column}_ams"
        pay_column = f"{column}_pay"
        wd_column = f"{column}_wd"
        
        if (datatype[0]) == ''DATE'':
            
            # Using ''IS NOT DISTINCT FROM'' to treat two NULL values as a match pd.to_datetime(df[''date_column''])
              
            column_ams = f"TO_DATE({ams_column})"
            column_pay = f"TO_DATE ({pay_column})"               
            column_wd = f"TO_DATE ({wd_column})"
             
        elif  (datatype[0]) == ''BOOLEAN'':
            
            column_ams = f"TO_BOOLEAN({ams_column})"
            column_pay = f"TO_BOOLEAN({pay_column})"               
            column_wd =  f"TO_BOOLEAN({wd_column})"
    
        elif  (datatype[0]) == ''NUMBER'':
            
            column_ams = f"TO_NUMBER({ams_column})"
            column_pay = f"TO_NUMBER({pay_column})"               
            column_wd =  f"TO_NUMBER({wd_column})"

        else:
               
            column_ams = f"UPPER(TRIM({ams_column}))"
            column_pay = f"UPPER(TRIM({pay_column}))"               
            column_wd =  f"UPPER(TRIM({wd_column}))"
    
        ams_wd_comparison = f"({column_wd} IS NOT DISTINCT FROM {column_ams}) AS {column}_is_match_ams_wd"
        pay_wd_comparison = f"({column_wd} IS NOT DISTINCT FROM {column_pay}) AS {column}_is_match_pay_wd"
        full_match = f"({column_wd} IS NOT DISTINCT FROM {column_ams} AND {column_wd} IS NOT DISTINCT FROM {column_pay}) AS {column}_is_match_full"
        # ams_wd_comparison = f"({wdcolumn} IS NOT DISTINCT FROM {ams_column}) AS {column}_is_match_ams_wd"
        # pay_wd_comparison = f"({wd_column} IS NOT DISTINCT FROM {pay_column}) AS {column}_is_match_pay_wd"
        # full_match = f"({column_wd} IS NOT DISTINCT FROM {column_ams} AND {column_wd} IS NOT DISTINCT FROM {column_pay}) AS {column}_is_match_full"
             
        comparison_columns.extend([f"{column_wd} AS {wd_column}", f"{column_ams} AS {ams_column}", f"{column_pay} AS {pay_column}", ams_wd_comparison, pay_wd_comparison, full_match])
             
        row_match_conditions.append(f"({column_wd} IS NOT DISTINCT FROM {column_ams} AND {column_wd} IS NOT DISTINCT FROM {column_pay})")
     
        # This will check if all the columns'' match conditions are true
        row_match_condition = " AND ".join(row_match_conditions)
     
     
        comparison_template = """
        CREATE OR REPLACE TABLE  DW_PROD.INTEGRATION.WORKDAY_X_ATTRIBUTE_COMPARISION as
        SELECT 
            wd.employee_enterprise_id,
            {columns}  ,system_code_wd,system_code_ams,system_code_pay,
            CASE WHEN {row_match_condition} THEN TRUE ELSE FALSE END AS row_is_match
        FROM 
            (SELECT {wd_columns}  ,SS.SYSTEM_CODE as system_code_wd
            FROM DW_PROD.INTEGRATION.{source_table} SOURCE
            JOIN DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK C ON SOURCE.EMPLOYEE_ID = C.WORKDAY_INTERNAL_ID
            JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM SS ON SS.SOURCE_SYSTEM_ID = SOURCE.SOURCE_SYSTEM_ID
            WHERE SOURCE.SYSTEM_CODE = ''WORKDAY'' and SOURCE.EMPLOYEE_KEY = SOURCE.ORIGINAL_EMPLOYEE_KEY) wd
        LEFT JOIN 
            (SELECT {ams_columns} ,SS.SYSTEM_CODE as system_code_ams
            FROM DW_PROD.INTEGRATION.{source_table} SOURCE
            JOIN DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK C ON SOURCE.EMPLOYEE_KEY = C.AMS_EMPLOYEE_KEY
            JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM SS ON SS.SOURCE_SYSTEM_ID = SOURCE.SOURCE_SYSTEM_ID
            WHERE SOURCE_SYSTEM_TYPE = ''AMS'' and SOURCE.EMPLOYEE_KEY = SOURCE.ORIGINAL_EMPLOYEE_KEY) ams ON wd.employee_enterprise_id = ams.employee_enterprise_id
        LEFT JOIN 
            (SELECT {pay_columns} ,SS.SYSTEM_CODE as  system_code_pay
            FROM DW_PROD.INTEGRATION.{source_table} SOURCE
            JOIN DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK C ON SOURCE.EMPLOYEE_KEY = C.PAYROLL_EMPLOYEE_KEY
            JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM SS ON SS.SOURCE_SYSTEM_ID = SOURCE.SOURCE_SYSTEM_ID
            WHERE SOURCE_SYSTEM_TYPE = ''Payroll'' and SOURCE.EMPLOYEE_KEY = SOURCE.ORIGINAL_EMPLOYEE_KEY) pay ON wd.employee_enterprise_id = pay.employee_enterprise_id;
        """
     
        # This will generate column selections for each system type with the proper suffixes
        wd_columns = "employee_enterprise_id," + ", ".join([f"UPPER(SOURCE.{column}) AS {column}_wd" for column in  base_columns])
        ams_columns = "employee_enterprise_id," + ", ".join([f"UPPER(SOURCE.{column}) AS {column}_ams" for column in  base_columns])
        pay_columns = "employee_enterprise_id," + ", ".join([f"UPPER(SOURCE.{column}) AS {column}_pay" for column in base_columns])
     
        sql = comparison_template.format(
            columns=",\\n        ".join(comparison_columns),
            row_match_condition=row_match_condition,
            wd_columns=wd_columns,
            ams_columns=ams_columns,
            pay_columns=pay_columns,
            source_table=source_table
        )
        
    return sql
 ';
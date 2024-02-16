CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_DEDUPE("RULES" VARCHAR(16777216), "INPUT_QUERY" VARCHAR(16777216), "OUTPUT_QUERY" VARCHAR(16777216), "OUTPUT_TABLE" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('snowflake-snowpark-python','pandas')
HANDLER = 'MAIN'
EXECUTE AS OWNER
AS '
def MAIN(snowpark_session,RULES:str,INPUT_QUERY:str,OUTPUT_QUERY:str,OUTPUT_TABLE:str):
  import snowflake.snowpark as snowpark
  from snowflake.snowpark.types import IntegerType,TimestampType, StringType, StructType, StructField
  import pandas as pd
  import json
  try:
    RULES_S = snowpark_session.sql( f''''''SELECT RULES FROM DEDUPE_STAGE_LAYER.CONFIGURATION.RULES_CONFIG WHERE RULE_TYPE =''{RULES}''; '''''')
    RULES = RULES_S.collect()[0][0]
    RULES = json.loads(RULES)
  except Exception as e:
    return  ("ERROR at pulling rules",e)
    
  try:
    INPUT = snowpark_session.sql(f''''''SELECT * FROM {INPUT_QUERY}; '''''')
    df = INPUT.to_pandas()
    input_shape = df.shape[0]
  except Exception as e:
    return  ("ERROR at Input query",e)
  
  try:
    match = apply_rule(df,RULES)
  except Exception as e:
    return  ("ERROR at applying rule ",e)

    
  try:  
    Cluster_dict,max_cluster = cluster(match)
  except Exception as e:
    return  ("ERROR at clustering ",e)
    
  try:
    table_A = snowpark_session.sql(f''''''SELECT * FROM {OUTPUT_QUERY} ;'''''')
    OUTPUT = table_A.to_pandas()
    output_shape = OUTPUT.shape[0]
    OUTPUT.set_index("ID", drop=True, inplace=True)
  except Exception as e:
    return  ("ERROR at Output query",e)
    
  try:
    OUTPUT["CLUSTER_ID"] = OUTPUT.index.map(Cluster_dict)
    OUTPUT  = OUTPUT.sort_values(by=["CLUSTER_ID"])
    OUTPUT = OUTPUT.reset_index()
    OUTPUT.dropna(subset=["CLUSTER_ID"], inplace=True)
  except Exception as e:
    return  ("ERROR at Mapping cluster",e)
  try: 
    pandas_df = pd.DataFrame(OUTPUT,dtype =''str'',columns=["ID","CLUSTER_ID"])
    schema = StructType([StructField("ID", StringType()),StructField("ETL_INSERTED_DATE", TimestampType()),StructField("CLUSTER_ID", StringType())])
    snowpark_df = snowpark_session.create_dataframe(OUTPUT,schema = schema)
    snowpark_df.write.mode("overwrite").save_as_table({OUTPUT_TABLE})
  except Exception as e:
    return  ("ERROR at inserting Data",e)
  return ("success",max_cluster,input_shape,output_shape)
  
def apply_rule(features, rules):
    import pandas as pd
    matches = pd.DataFrame()
    for key_name, values_to_remove in rules.items():
      #print(key_name, values_to_remove)
      duplicate = features.query(values_to_remove)
      features = features[~features.index.isin(duplicate.index)]
      duplicate[''RULE''] = key_name
      if matches.empty:
        matches = duplicate
      else:
        matches = matches.append(duplicate)
      print(duplicate.shape[0])
    return matches
    
def cluster(df):
  from _snowflake import vectorized
  clusters_dict = dict()
  max_cluster = 0
  for idx, row in df[[''ID1'', ''ID2'']].iterrows():
    id1, id2 = row[''ID1''], row[''ID2'']
    if clusters_dict.get(id1):
      cluster = clusters_dict.get(id1)
    elif clusters_dict.get(id2):
      cluster = clusters_dict.get(id2)
    else:
      max_cluster += 1
      cluster = max_cluster
    clusters_dict[id1] = cluster
    clusters_dict[id2] = cluster
  return clusters_dict,max_cluster
';
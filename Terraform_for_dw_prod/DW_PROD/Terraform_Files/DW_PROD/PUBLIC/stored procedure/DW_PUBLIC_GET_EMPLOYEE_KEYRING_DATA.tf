resource "snowflake_procedure" "DW_PUBLIC_GET_EMPLOYEE_KEYRING_DATA" {
	name ="GET_EMPLOYEE_KEYRING_DATA"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

	arguments {
		name = "ENVIRONMENT"
		type = "VARCHAR(10)"
}	

	arguments {
		name = "JSON_STRING"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARIANT"
	execute_as = "OWNER"
	statement = <<-EOT

function parseJSON(jsonString) {
    try {
        return JSON.parse(jsonString);
    } catch (err) {
        throw ''Invalid JSON format: '' + err;
    }
}
if ((typeof ENVIRONMENT) === ''string'' && [''DEV'', ''PROD''].includes(ENVIRONMENT.toUpperCase())) {
    	var DB_NAME = ''DW_'' + ENVIRONMENT.toUpperCase();
    }
else {
	return [{''KEYRING_MSG_CODE'':''2'',''KEYRING_MSG_DESC'':''Please pass valid ENVIRONMENT name(DEV/PROD)''}]
}

try {
    var main_qry = '''';
    var in_qry = '''';
	var json_str = JSON_STRING;
    var jsonDataArr = parseJSON(JSON_STRING);
    var input_dict = {};
    var output_dict = {};
    var error_dict = {};
    var nodata_dict = {};
    var data_dict = {};
    var conditions = [];
    

    //making dictionary FROM INPUT DATA

    var AMS_KEYS = [''AMS_SOURCE_SYSTEM_ID'', ''AMS_SYSTEM_CODE'', ''AMS_SOURCE_SYSTEM'', ''AMS_SYSTEM''];
    var PAYROLL_KEYS = [''PAYROLL_SOURCE_SYSTEM_ID'', ''PAYROLL_SYSTEM_CODE'', ''PAYROLL_SOURCE_SYSTEM'', ''PAYROLL_SYSTEM''];
    var COL_NAMES = [''EMPLOYEE_ENTERPRISE_ID'',''INACTIVE'', ''EMPLOYEE_FIRST_NAME'', ''EMPLOYEE_LAST_NAME'', ''AMS_EMPLOYEE_ID'', ''AMS_SOURCE_SYSTEM'', ''PAYROLL_EMPLOYEE_ID'', ''PAYROLL_SOURCE_SYSTEM'', ''GATOR_EMPLOYEE_ACCOUNT_ID'', ''COACHUPCARE_ID'', ''CARIBOU_ID_SENT'', ''SERVICENOW_ID'', ''DERIVED_WORKDAY_ID'', ''WORKDAY_USERNAME'', ''WORKDAY_INTERNAL_ID'', ''BROADSPIRE_ID'', ''OKTA_ID'', ''OKTA_USERNAME'', ''ACTIVE_DIRECTORY_SID'', ''EMPLOYEE_RISKONNECT_ID'', ''PAYROLL_ID'', ''FIRST_NAME'', ''LAST_NAME'', ''STATE_CODE'', ''AMS_EMPLOYEE_KEY'', ''AMS_SOURCE_SYSTEM_ID'', ''AMS_SYSTEM_CODE'', ''PAYROLL_EMPLOYEE_KEY'', ''PAYROLL_SOURCE_SYSTEM_ID'', ''PAYROLL_SYSTEM_CODE'', ''APPLICANT_EMPLOYEE_KEY'', ''APPLICANT_SOURCE_SYSTEM_ID'', ''APPLICANT_SYSTEM_CODE'', ''APPLICANT_EMPLOYEE_ID'', ''AMS_IVR_ID'', ''GATOR_EMPLOYEE_KEY'', ''ACTIVE_DIRECTORY_EMAIL'', ''MOST_RECENT_SERVICE_DATE'', ''MOST_RECENT_PAYROLL_DATE'', ''AMS_PUBLIC_ID'', ''EXCEPTION_FLAG''];
    var QUAL_COL_NAMES = [''CW.EMPLOYEE_ENTERPRISE_ID'',''CW.INACTIVE'', ''CW.EMPLOYEE_FIRST_NAME'', ''CW.EMPLOYEE_LAST_NAME'', ''CW.AMS_EMPLOYEE_ID'', ''CW.AMS_SOURCE_SYSTEM'', ''CW.PAYROLL_EMPLOYEE_ID'', ''CW.PAYROLL_SOURCE_SYSTEM'', ''CW.GATOR_EMPLOYEE_ACCOUNT_ID'', ''CW.COACHUPCARE_ID'', ''CW.CARIBOU_ID_SENT'', ''CW.SERVICENOW_ID'', ''CW.DERIVED_WORKDAY_ID'', ''CW.WORKDAY_USERNAME'', ''CW.WORKDAY_INTERNAL_ID'', ''CW.BROADSPIRE_ID'', ''CW.OKTA_ID'', ''CW.OKTA_USERNAME'', ''CW.ACTIVE_DIRECTORY_SID'', ''CW.EMPLOYEE_RISKONNECT_ID'', ''CW.PAYROLL_ID'', ''CW.FIRST_NAME'', ''CW.LAST_NAME'', ''CW.STATE_CODE'', ''CW.AMS_EMPLOYEE_KEY'', ''CW.AMS_SOURCE_SYSTEM_ID'', ''CW.AMS_SYSTEM_CODE'', ''CW.PAYROLL_EMPLOYEE_KEY'', ''CW.PAYROLL_SOURCE_SYSTEM_ID'', ''CW.PAYROLL_SYSTEM_CODE'', ''CW.APPLICANT_EMPLOYEE_KEY'', ''CW.APPLICANT_SOURCE_SYSTEM_ID'', ''CW.APPLICANT_SYSTEM_CODE'', ''CW.APPLICANT_EMPLOYEE_ID'', ''CW.AMS_IVR_ID'', ''CW.GATOR_EMPLOYEE_KEY'', ''CW.ACTIVE_DIRECTORY_EMAIL'', ''CW.MOST_RECENT_SERVICE_DATE'', ''CW.MOST_RECENT_PAYROLL_DATE'', ''CW.AMS_PUBLIC_ID'',''CW.EXCEPTION_FLAG''];

    for (var i = 0; i < jsonDataArr.length; i++) {
        var errorObj = {}
        var jsonData = jsonDataArr[i]
        var AMS_KEYS_VALIDATION = false;
        var PAYROLL_KEYS_VALIDATION = false;
        var COLUMNCHECK_VALIDATION = false;
        var AMS_EMPLOYEE_KEY = false;
        var PAYROLL_EMPLOYEE_KEY = false;
        var EMPLOYEE_ENTERPRISE_ID = false;
        var EMPLOYEE_ENTERPRISE_ID_NOT_INT = false;
        var AMS_EMPLOYEE_ID = false;
        var PAYROLL_EMPLOYEE_ID = false;
        var AMS_PUBLIC_ID = false;
        var resultString = '''';
        var keyValuePairs = [];
        for (var key in jsonData) {

            if (jsonData.hasOwnProperty(key)) {
				if (typeof jsonData[key] === ''string''){
				    var value = jsonData[key].toUpperCase();
				}
				else{
					var value = jsonData[key];
				}
				jsonData[key] = value;
                if (value === null) {
                    keyValuePairs.push(key + '' IS NULL'');
                } else if ((key.toUpperCase().startsWith(''AMS_SOURCE'') || key.toUpperCase().startsWith(''AMS_SYSTEM'')) && key.toUpperCase() != ''AMS_SOURCE_SYSTEM_ID'') {
                    if (value.startsWith(''SANDATA'')) {
                        key = ''AMS_SOURCE_SYSTEM_ID'';
                        value = ''4'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else if (value.startsWith(''DATAFLEX'')) {
                        key = ''AMS_SOURCE_SYSTEM_ID'';
                        value = ''3'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else if (value.startsWith(''CLEAR'')) {
                        key = ''AMS_SOURCE_SYSTEM_ID'';
                        value = ''16'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else if (value.startsWith(''ALLIANCE'', ''GENERATIONS'')) {
                        key = ''AMS_SOURCE_SYSTEM_ID'';
                        value = ''19'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else if (value.startsWith(''ALAYACARE'')) {
                        key = ''AMS_SOURCE_SYSTEM_ID'';
                        value = ''9'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else {
                        //delete jsonData[key];
                        keyValuePairs.push(''('' + ''AMS_SOURCE_SYSTEM_ID::string'' + '' = '' + ''"'' + value + ''"'' + '' OR '' + ''UPPER(AMS_SYSTEM_CODE)'' + '' = '' + ''"'' + value + ''"'' + '' OR '' + ''UPPER(AMS_SOURCE_SYSTEM)'' + '' = '' + ''"'' + value + ''"'' + '')'');
                    }
                } else if ((key.toUpperCase().startsWith(''PAYROLL_SOURCE'') || key.toUpperCase().startsWith(''PAYROLL_SYSTEM'')) && key.toUpperCase() != ''PAYROLL_SOURCE_SYSTEM_ID'') {
                    if (value.startsWith(''UKG'') || value.startsWith(''TRUSTPOINT'') || value.startsWith(''KRONOS'')) {
                        key = ''PAYROLL_SOURCE_SYSTEM_ID'';
                        value = ''6'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else if (value.startsWith(''GREATPLAINS'') || value.startsWith(''GP'') || value.startsWith(''GREAT'')) {
                        key = ''PAYROLL_SOURCE_SYSTEM_ID'';
                        value = ''5'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else if (value.startsWith(''PAYLOCITY'') || value.startsWith(''ADAPTIVE'')) {
                        key = ''PAYROLL_SOURCE_SYSTEM_ID'';
                        value = ''10'';
						jsonData[key] = value;
                        keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                    } else {
                        //delete jsonData[key];
                        keyValuePairs.push(''('' + ''PAYROLL_SOURCE_SYSTEM_ID::string'' + '' = '' + ''"'' + value + ''"'' + '' OR '' + ''UPPER(PAYROLL_SYSTEM_CODE)'' + '' = '' + ''"'' + value + ''"'' + '' OR '' + ''UPPER(PAYROLL_SOURCE_SYSTEM)'' + '' = '' + ''"'' + value + ''"'' + '')'');
                    }
                } else {
                    keyValuePairs.push(key + '' = '' + JSON.stringify(value));
                }
            }
            if (AMS_KEYS.some(val => val.toUpperCase() === key.toUpperCase())) {
                AMS_KEYS_VALIDATION = true;
            }
            if (PAYROLL_KEYS.some(val => val.toUpperCase() === key.toUpperCase())) {
                PAYROLL_KEYS_VALIDATION = true;
            }
            if (key.toUpperCase() === ''AMS_EMPLOYEE_KEY'') {
                AMS_EMPLOYEE_KEY = true;
            }
            if (key.toUpperCase() === ''PAYROLL_EMPLOYEE_KEY'') {
                PAYROLL_EMPLOYEE_KEY = true;
            }
            if (key.toUpperCase() === ''EMPLOYEE_ENTERPRISE_ID'') {
                EMPLOYEE_ENTERPRISE_ID = true;
            }
            if (key.toUpperCase() === ''EMPLOYEE_ENTERPRISE_ID'') {
                EMPLOYEE_ENTERPRISE_ID_NOT_INT = isNaN(value)
            }
            if (key.toUpperCase() === ''AMS_EMPLOYEE_ID'') {
                AMS_EMPLOYEE_ID = true;
            }
            if (key.toUpperCase() === ''PAYROLL_EMPLOYEE_ID'') {
                PAYROLL_EMPLOYEE_ID = true;
            }
            if (key.toUpperCase() === ''AMS_PUBLIC_ID'') {
                AMS_PUBLIC_ID = true;
            }
            if (!COL_NAMES.some(val => val.toUpperCase() === key.toUpperCase()) && !PAYROLL_KEYS.some(val => val.toUpperCase() === key.toUpperCase()) && AMS_KEYS_VALIDATION === false && PAYROLL_KEYS_VALIDATION === false && AMS_EMPLOYEE_KEY === false && PAYROLL_EMPLOYEE_KEY === false && EMPLOYEE_ENTERPRISE_ID === false && AMS_EMPLOYEE_ID === false && PAYROLL_EMPLOYEE_ID === false && AMS_PUBLIC_ID === false) {
                COLUMNCHECK_VALIDATION = true;
            }
        }
        if ((AMS_KEYS_VALIDATION === true || PAYROLL_KEYS_VALIDATION === true) && AMS_EMPLOYEE_KEY === false && PAYROLL_EMPLOYEE_KEY === false && EMPLOYEE_ENTERPRISE_ID === false && AMS_EMPLOYEE_ID === false && PAYROLL_EMPLOYEE_ID === false && AMS_PUBLIC_ID === false) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''EMPLOYEE_ID or PUBLIC_ID IS mandatory along with AMS_SOURCE_SYSTEM or PAYROLL_SOURCE_SYSTEM.''
            };
        } else if (AMS_EMPLOYEE_KEY === false && PAYROLL_EMPLOYEE_KEY === false && EMPLOYEE_ENTERPRISE_ID === false && AMS_EMPLOYEE_ID === false && PAYROLL_EMPLOYEE_ID === false && AMS_PUBLIC_ID === false) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''AMS_EMPLOYEE_KEY,PAYROLL_EMPLOYEE_KEY or EMPLOYEE_ENTERPRISE_ID is mandatory.''
            };
        } else if (AMS_KEYS_VALIDATION === false && PAYROLL_KEYS_VALIDATION === true && AMS_EMPLOYEE_KEY === false && PAYROLL_EMPLOYEE_KEY === false && EMPLOYEE_ENTERPRISE_ID === false && AMS_EMPLOYEE_ID === false && PAYROLL_EMPLOYEE_ID === false && AMS_PUBLIC_ID === false) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''Please provide a valid value for PAYROLL_SOURCE_SYSTEM.''
            };
        } else if (AMS_KEYS_VALIDATION === true && PAYROLL_KEYS_VALIDATION === false && AMS_EMPLOYEE_KEY === false && PAYROLL_EMPLOYEE_KEY === false && EMPLOYEE_ENTERPRISE_ID === false && AMS_EMPLOYEE_ID === false && PAYROLL_EMPLOYEE_ID === false && AMS_PUBLIC_ID === false) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''Please provide a valid value for AMS_SOURCE_SYSTEM.''
            };
        } else if (EMPLOYEE_ENTERPRISE_ID_NOT_INT === true) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''EMPLOYEE_ENTERPRISE_ID must be integer value.''
            };
        } else if (COLUMNCHECK_VALIDATION === true) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''Please check column name.''
            };
        }
		 else if (AMS_KEYS_VALIDATION === false && PAYROLL_KEYS_VALIDATION === false && AMS_EMPLOYEE_KEY === false && PAYROLL_EMPLOYEE_KEY === false && EMPLOYEE_ENTERPRISE_ID === false && (AMS_EMPLOYEE_ID === true || AMS_PUBLIC_ID === true) && PAYROLL_EMPLOYEE_ID === false) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''Please provide a valid value for AMS_SOURCE_SYSTEM.''
            };
          }
        else if (AMS_KEYS_VALIDATION === false && PAYROLL_KEYS_VALIDATION === false && AMS_EMPLOYEE_KEY === false && PAYROLL_EMPLOYEE_KEY === false && EMPLOYEE_ENTERPRISE_ID === false && AMS_EMPLOYEE_ID === false && PAYROLL_EMPLOYEE_ID === true && AMS_PUBLIC_ID === false) {
            errorObj = {
                KEYRING_MSG_CODE: ''2'',
                KEYRING_MSG_DESC: ''Please provide a valid value for PAYROLL_SOURCE_SYSTEM.''
            };
          }
        if (!Object.keys(errorObj).length > 0) {
            conditions.push(keyValuePairs.join('' AND ''));
            input_dict[i] = jsonData;
        } else {
            error_dict[i] = errorObj;
        }
    }
    if (conditions.length > 0) {

        main_qry = '' SELECT '';
        for (i = 0; i < COL_NAMES.length; i++) {
            main_qry += QUAL_COL_NAMES[i] + '' AS '' + COL_NAMES[i];
            if (i < COL_NAMES.length - 1) {
                main_qry += '','';
            }
        }
        var row_as_json = {};
        var result_arr = [];

        //IN query FROM WHERE condition
        in_qry = '' FROM '' + DB_NAME +''.INTEGRATION.GET_CROSSWALK_DATA CW WHERE ''
            for (i = 0; i < conditions.length; i++) {
                in_qry += '' ( '' + conditions[i].replace(/"/g, "''") + '' ) OR '';
            }
            in_qry = in_qry.slice(0, -3);
        main_qry += in_qry;
        var cmd1_dict = {
            sqlText: main_qry
        };
        var stmt = snowflake.createStatement(cmd1_dict);
        var rs = stmt.execute();
        while (rs.next()) {
            row_as_json = {};
            for (var col_num = 0; col_num < COL_NAMES.length; col_num++) {
                col_name = COL_NAMES[col_num];
                col_value = rs.getColumnValue(col_num + 1);
                row_as_json[col_name] = col_value;
            }
            row_as_json[''KEYRING_MSG_CODE''] = ''1'';
            row_as_json[''KEYRING_MSG_DESC''] = ''Success'';
            result_arr.push(row_as_json);
        }
        for (key in input_dict) {
			var res = [];
            for (var i = 0; i < result_arr.length; i++) {
                if (parseInt(result_arr[i][''EMPLOYEE_ENTERPRISE_ID'']) === parseInt(input_dict[key][''EMPLOYEE_ENTERPRISE_ID''])) {
                    res.push(result_arr[i]);
                } else if (String(result_arr[i][''AMS_EMPLOYEE_KEY'']) === String(input_dict[key][''AMS_EMPLOYEE_KEY''])) {
                    res.push(result_arr[i]);
                } else if (String(result_arr[i][''PAYROLL_EMPLOYEE_KEY'']) === String(input_dict[key][''PAYROLL_EMPLOYEE_KEY''])) {
                    res.push(result_arr[i]);
                } else if (
						(String(result_arr[i][''AMS_EMPLOYEE_ID'']) === String(input_dict[key][''AMS_EMPLOYEE_ID''])) && (
                        (String(result_arr[i][''AMS_SOURCE_SYSTEM_ID'']) === String(input_dict[key][''AMS_SOURCE_SYSTEM_ID''])) ||
						([String(result_arr[i][''AMS_SYSTEM_CODE'']),String(result_arr[i][''AMS_SOURCE_SYSTEM''])].includes(String(input_dict[key][''AMS_SOURCE_SYSTEM'']).toUpperCase())) ||
						([String(result_arr[i][''AMS_SYSTEM_CODE'']),String(result_arr[i][''AMS_SOURCE_SYSTEM''])].includes(String(input_dict[key][''AMS_SYSTEM_CODE'']).toUpperCase())))) {
                    res.push(result_arr[i]);           
                } else if (
						(String(result_arr[i][''PAYROLL_EMPLOYEE_ID'']) === String(input_dict[key][''PAYROLL_EMPLOYEE_ID''])) && (
                        (String(result_arr[i][''PAYROLL_SOURCE_SYSTEM_ID'']) === String(input_dict[key][''PAYROLL_SOURCE_SYSTEM_ID''])) ||
						([String(result_arr[i][''PAYROLL_SYSTEM_CODE'']),String(result_arr[i][''PAYROLL_SOURCE_SYSTEM''])].includes(String(input_dict[key][''PAYROLL_SOURCE_SYSTEM'']).toUpperCase())) ||
						([String(result_arr[i][''PAYROLL_SYSTEM_CODE'']),String(result_arr[i][''PAYROLL_SOURCE_SYSTEM''])].includes(String(input_dict[key][''PAYROLL_SYSTEM_CODE'']).toUpperCase())))) {
                    res.push(result_arr[i]);                
                }
				else if (
						(String(result_arr[i][''AMS_PUBLIC_ID'']) === String(input_dict[key][''AMS_PUBLIC_ID''])) && (
                        (String(result_arr[i][''AMS_SOURCE_SYSTEM_ID'']) === String(input_dict[key][''AMS_SOURCE_SYSTEM_ID''])) ||
						([String(result_arr[i][''AMS_SYSTEM_CODE'']),String(result_arr[i][''AMS_SOURCE_SYSTEM''])].includes(String(input_dict[key][''AMS_SOURCE_SYSTEM'']).toUpperCase())) ||
						([String(result_arr[i][''AMS_SYSTEM_CODE'']),String(result_arr[i][''AMS_SOURCE_SYSTEM''])].includes(String(input_dict[key][''AMS_SYSTEM_CODE'']).toUpperCase())) ||
						(String(result_arr[i][''PAYROLL_SOURCE_SYSTEM_ID'']) === String(input_dict[key][''PAYROLL_SOURCE_SYSTEM_ID''])) ||
						([String(result_arr[i][''PAYROLL_SYSTEM_CODE'']),String(result_arr[i][''PAYROLL_SOURCE_SYSTEM''])].includes(String(input_dict[key][''PAYROLL_SOURCE_SYSTEM'']).toUpperCase())) ||
						([String(result_arr[i][''PAYROLL_SYSTEM_CODE'']),String(result_arr[i][''PAYROLL_SOURCE_SYSTEM''])].includes(String(input_dict[key][''PAYROLL_SYSTEM_CODE'']).toUpperCase())))) {          
					res.push(result_arr[i]);                   
                }
			}
			if (res.length === 1) {
				data_dict[key] = res[0];
			}
			else if (res.length > 1) {
				error_dict[key] = {''KEYRING_MSG_CODE'':''3'',''KEYRING_MSG_DESC'':''Multiple Data found''}
			}	
        }
        row_as_json = {};
        row_as_json[''KEYRING_MSG_CODE''] = ''3'';
        row_as_json[''KEYRING_MSG_DESC''] = ''No data found'';
		var ar1 = Object.keys(data_dict);
        var ar2 = Object.keys(error_dict);
        for (var i = 0; i < jsonDataArr.length; i++) {
            if (!((ar1.includes(i.toString())) || (ar2.includes(i.toString())))) {
                nodata_dict[parseInt(i)] = row_as_json;
            }
        }

	    var ar3 = Object.keys(nodata_dict);
	    for (var i = 0; i < jsonDataArr.length; i++) {
	        if (ar1.includes(i.toString())) {
	            output_dict[i] = data_dict[i.toString()];
	        } else if (ar2.includes(i.toString())) {
	            output_dict[i] = error_dict[i.toString()];
	        } else if (ar3.includes(i.toString())) {
	            output_dict[i] = nodata_dict[i.toString()];
	        }
	    }
    }
	else {
		output_dict = error_dict;
	}
    return Object.values(output_dict);
    //return [main_qry];  //main_qry
	//return input_dict[0][''AMS_SYSTEM_CODE''];
	//return data_dict;
    //return input_dict;
} catch (err) {
    throw ''Error processing JSON: '' + err;
}

 EOT
}


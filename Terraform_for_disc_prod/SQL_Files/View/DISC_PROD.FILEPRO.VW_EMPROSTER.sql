create or replace view DISC_PROD.FILEPRO.VW_EMPROSTER(
	EMPLOYEE_NUMBER,
	EMPLOYEE_NAME,
	ADDRESS,
	EMP_CITY,
	DESK,
	PHONE_NUMBER,
	CELL_PHONE,
	COMBINEDCLIENTNAME,
	B1PHONENUMBER,
	C1ADDRESS1,
	DCITY,
	WKMAXHRS,
	SUN_AM1,
	SUN_PM1,
	MON_AM1,
	MON_PM1,
	TUE_AM1,
	TUE_PM1,
	WED_AM1,
	WED_PM1,
	THU_AM1,
	THU_PM1,
	FRI_AM1,
	FRI_PM1,
	SAT_AM1,
	SAT_PM1,
	COMBINED_CLIENT_NAME1,
	B1_PHONE_NUMBER1,
	C1_ADDRESS1,
	D_CITY1,
	WKMAXHRS1,
	SUN1AM2,
	SUN2PM2,
	MON3AM2,
	MON4PM2,
	TUE5AM2,
	TUE6PM2,
	WED7AM2,
	WED8PM2,
	THU9AM2,
	THU10PM2,
	FRI11AM2,
	FRI12PM2,
	SAT13AM2,
	SAT14PM2,
	COMBINED_CLIENT_NAME2,
	B1_PHONE_NUMBER2,
	C1_ADDRESS2,
	D_CITY2,
	WKMAXHRS2,
	SUN_AM3,
	SUN_PM3,
	MON_AM3,
	MON_PM3,
	TUE_AM3,
	TUE_PM3,
	WED_AM3,
	WED_PM3,
	THU_AM3,
	THU_PM3,
	FRI_AM3,
	FRI_PM3,
	SAT_AM3,
	SAT_PM3,
	ADDRESS2A,
	ADDRESS2B,
	ADDRESS2C,
	CLIIDOA1,
	CLIIDOA2,
	CLIIDOA3,
	SHAREDCODE1,
	SHAREDCODE2,
	SHAREDCODE3,
	REGION,
	NOT_AVAIL,
	FLAGFIELD1,
	FLAGFIELD2,
	FLAGFIELD3
) as
select t.$1 AS Employee_Number,
t.$2 AS Employee_Name,
t.$3 AS Address,
t.$4 AS Emp_City,
t.$5 AS Desk,
t.$6 AS Phone_Number,
t.$7 AS Cell_Phone,
t.$8 AS CombinedClientName,
t.$9 AS B1PhoneNumber,
t.$10 AS C1Address1,
t.$11 AS DCity,
t.$12 AS WkMaxhrs,
t.$13 AS Sun_am1,
t.$14 AS Sun_pm1,
t.$15 AS Mon_am1,
t.$16 AS Mon_pm1,
t.$17 AS Tue_am1,
t.$18 AS Tue_pm1,
t.$19 AS Wed_am1,
t.$20 AS Wed_pm1,
t.$21 AS Thu_am1,
t.$22 AS Thu_pm1,
t.$23 AS Fri_am1,
t.$24 AS Fri_pm1,
t.$25 AS Sat_am1,
t.$26 AS Sat_pm1,
t.$27 AS Combined_Client_Name1,
t.$28 AS B1_Phone_Number1,
t.$29 AS C1_Address1,
t.$30 AS D_City1,
t.$31 AS WKMaxHrs1,
t.$32 AS Sun1am2,
t.$33 AS Sun2pm2,
t.$34 AS Mon3am2,
t.$35 AS Mon4pm2,
t.$36 AS Tue5am2,
t.$37 AS Tue6pm2,
t.$38 AS Wed7am2,
t.$39 AS Wed8pm2,
t.$40 AS Thu9am2,
t.$41 AS Thu10pm2,
t.$42 AS Fri11am2,
t.$43 AS Fri12pm2,
t.$44 AS Sat13am2,
t.$45 AS Sat14pm2,
t.$46 AS Combined_Client_Name2,
t.$47 AS B1_Phone_Number2,
t.$48 AS C1_Address2,
t.$49 AS D_City2,
t.$50 AS WKMaxHrs2,
t.$51 AS Sun_am3,
t.$52 AS Sun_pm3,
t.$53 AS Mon_am3,
t.$54 AS Mon_pm3,
t.$55 AS Tue_am3,
t.$56 AS Tue_pm3,
t.$57 AS Wed_am3,
t.$58 AS Wed_pm3,
t.$59 AS Thu_am3,
t.$60 AS Thu_pm3,
t.$61 AS Fri_am3,
t.$62 AS Fri_pm3,
t.$63 AS Sat_am3,
t.$64 AS Sat_pm3,
t.$65 AS Address2a,
t.$66 AS Address2b,
t.$67 AS Address2c,
t.$68 AS CliIDoA1,
t.$69 AS CliIDoA2,
t.$70 AS CliIDoA3,
t.$71 AS SharedCode1,
t.$72 AS SharedCode2,
t.$73 AS SharedCode3,
t.$74 AS Region,
t.$75 AS Not_Avail,
t.$76 AS FlagField1,
t.$77 AS FlagField2,
t.$78 AS FlagField3
from @DISC_PROD.STAGE.AZSTAGEPROD/FilePro/EmpRoster(file_format => DISC_PROD.PUBLIC.CSV_FORMAT ) AS T;
create or replace view DISC_PROD.FILEPRO.VW_RAWVRFP(
	"Client Name",
	"Service Type",
	"Hours Worked",
	"Employee Number",
	"Record Accepted",
	"Operator Response",
	"Processed By Which Module",
	"Rate of Pay",
	"Area",
	"Contract",
	"Agreement",
	"Period Date",
	"Pay Period Ending Date",
	"Pay Employee",
	"Transaction Type",
	"Mileage",
	"Extra Hours",
	"Non-Billable Hours",
	"Training Hours",
	"Overtime",
	"Supplemental Earnings",
	"Vacation",
	"Sick",
	"Home Holiday Hours",
	"Client Desk",
	"Emp Desk",
	"Travel",
	"Private Home",
	"Training Date",
	"Created By",
	"Creation Date",
	"Created At",
	"Update 1 On",
	"Update 1 By",
	"Update 1 At",
	"Update 2 On",
	"Update 2 By",
	"Update 2 At",
	"Update 3 On",
	"Update 3 By",
	"Update 3 At",
	"Day of Service",
	"Client ID",
	"Billing Number",
	"#Units (5 whhal)",
	"Units (3 .0)",
	"City opted out",
	"Area (3 ALLUP)",
	"Travel Hours",
	"Day of Wee",
	"Week and Year"
) as 
select 
t.$1 	as 	"Client Name"	,
t.$2	as 	"Service Type"	,
t.$3	as 	"Hours Worked"	,
t.$4	as 	"Employee Number",
t.$5	as 	"Record Accepted",
t.$6	as 	"Operator Response"	,
t.$7	as 	"Processed By Which Module"	,
t.$8	as 	"Rate of Pay"	,
t.$9	as 	"Area",
t.$10	as 	"Contract",
t.$11	as 	"Agreement"	,
SUBSTR(t.$12,1,2)||'-'||SUBSTR(T.$12,3,2)||'-'||SUBSTR(T.$12,5,8)	as 	"Period Date",
SUBSTR(t.$13,1,2)||'-'||SUBSTR(T.$13,3,2)||'-'||SUBSTR(T.$13,5,8)	as 	"Pay Period Ending Date"	,
t.$14	as 	"Pay Employee",
t.$15	as 	"Transaction Type"	,
t.$16	as 	"Mileage",
t.$17	as 	"Extra Hours"	,
t.$18	as 	"Non-Billable Hours",
t.$19	as 	"Training Hours",
t.$20	as 	"Overtime",
t.$21	as 	"Supplemental Earnings"	,
t.$22	as 	"Vacation"	,
t.$23	as 	"Sick"	,
t.$24	as 	"Home Holiday Hours"	,
t.$25	as 	"Client Desk"	,
t.$26	as 	"Emp Desk"	,
t.$27	as 	"Travel"	,
t.$28	as 	"Private Home",
t.$29	as 	"Training Date"	,
t.$30	as 	"Created By"	,
SUBSTR(t.$31,1,2)||'-'||SUBSTR(T.$31,3,2)||'-'||SUBSTR(T.$31,5,8)	as 	"Creation Date"	,
t.$32	as 	"Created At"	,
t.$33	as 	"Update 1 On"	,
t.$34	as 	"Update 1 By"	,
t.$35	as 	"Update 1 At"	,
t.$36	as 	"Update 2 On"	,
t.$37	as 	"Update 2 By",
t.$38	as 	"Update 2 At"	,
t.$39	as 	"Update 3 On"	,
t.$40	as 	"Update 3 By",
t.$41	as 	"Update 3 At"	,
t.$42	as 	"Day of Service"	,
t.$43	as 	"Client ID"	,
t.$44	as 	"Billing Number"	,
t.$45	as 	"#Units (5 whhal)"	,
t.$46	as 	"Units (3 .0)"	,
t.$47	as 	"City opted out"	,
t.$48	as 	"Area (3 ALLUP)"	,
t.$49	as 	"Travel Hours"	,
t.$50	as 	"Day of Wee"	,
t.$51	as 	"Week and Year"
 from @DISC_PROD.STAGE.AZSTAGEPROD/FilePro/rawvrfp (file_format => DISC_PROD.PUBLIC.CSV_FORMAT ) as t;
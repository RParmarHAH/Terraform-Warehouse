resource "snowflake_view" "DISC_AXXESS_VW_AXXESS_HC_VISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "VW_AXXESS_HC_VISITS"
	statement = <<-SQL
	 (SELECT * FROM AXXESS.AXXESS_VISITFINANCIALS PV
WHERE PV.SCHEDULED_TASK_NAME  NOT IN 
(
'Case Conference' ,
'Client On Hold ',
'Employee Bonus' ,
'Employee Mileage 0.42',
'Employee Travel Time 9.30',
'NO HHA Care Plans * (Multiple)',
'HHA Discharge Sumarry',
'HHA Meeting',
'HHA sign on Bonus $400',
'HHA Supervisory Visit ',
'HOME sup visit form yearly', 
'LPN Orient/ meeting $23.00',
'LPN Supervisory Visit',
'OLD Don’t use T1019',
'OT Discharge Summary',
'Physician Order', 
'PT Discharge Summary', 
'PTO Field Staff',
'Referral Bonus $150.00',
'RN Orient/ Meeting $33.00',
'ST Discharge Summary ',
'Travel Mileage Sheet',
'Wendy Schedule Reminder' 
)
AND SCHEDULED_TASK_ID IS NOT NULL
);
SQL
	or_replace = true 
	is_secure = false 
}


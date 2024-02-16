create or replace view DW_PROD.REPORT.ROLLING_ONHOLDCLIENTCOUNT_WEEKLY(
	HAH_CURRENT_WEEK_FIRST_DAY,
	STATE,
	BRANCH_NAME,
	BRANCH_KEY,
	DISTINCTCLIENTCOUNT
) as
SELECT  DT.HAH_CURRENT_WEEK_FIRST_DAY,'PA' as State ,
CASE when b.BRANCH_NAME = 'PHILADELPHIA' then 'North Philadelphia' else b.BRANCH_NAME
end as branch_name,B.BRANCH_KEY,COUNT(DISTINCT clnt.client_key) AS DistinctClientCount

FROM  REPORT.ONHOLDCLIENTHISTORY_PA AS clnt 
inner join hah.fact_visit v
on v.client_key = clnt.client_key
inner join hah.dim_branch b
on b.branch_key = v.branch_key
INNER JOIN HAH.DIM_dATE DT
On DT.CALENDAR_date BETWEEN IFNULL( clnt.ONHOLDSTARTDATE, DATEADD( DAY, 1, CURRENT_DATE)) 
 AND IFNULL( clnt.ONHOLDENDDATE, DATEADD( DAY, 1, CURRENT_DATE)) 
WHERE dt.Calendar_Date BETWEEN CAST( '2020-01-28' AS DATE) AND CURRENT_DATE 
GROUP BY DT.HAH_CURRENT_WEEK_FIRST_DAY ,b.BRANCH_NAME,B.BRANCH_KEY

union ALL

SELECT DATE.HAH_CURRENT_WEEK_FIRST_DAY,
 O.DBNAME,OFFICENAME,
 BRANCH_KEY,
 COUNT(DISTINCT C.Number) 
			
  FROM DISC_PROD.DATAFLEXSYNCDATA.DfTimeSheets T
      JOIN DISC_PROD.DATAFLEXSYNCDATA.DfTimeSheetHours TH
          ON TH.DbName = T.DbName
             AND TH.ReferenceNo = T.ReferenceNo
             AND TH.WeekendDate = T.WeekendDate
      JOIN DISC_PROD.DATAFLEXSYNCDATA.DfClients C
          ON C.DbName = T.DbName
             AND C.Number = T.ClientNumber
      JOIN DISC_PROD.DATAFLEXSYNCDATA.DfClientContracts cc
          ON cc.DbName = T.DbName
             AND cc.ClientNumber = T.ClientNumber
             AND cc.ContractCode = T.ContractCode
      JOIN DISC_PROD.DATAFLEXSYNCDATA.DfContracts co
          ON co.DbName = T.DbName
             AND co.ContractCode = T.ContractCode
             AND co.ContractCode = cc.ContractCode
      JOIN DISC_PROD.DATAFLEXSYNCDATA.DfOffices o
          ON o.DbName = C.DbName
             AND o.OfficeNumber = C.OfficeNumber
      join report.onholdclienthistory_dataflex df
            ON C.DbName = df.DbName
             AND C.Number = df.Number
      JOIN HAH.DIM_DATE DATE
            ON DATE.CALENDAR_DATE between df.OnHoldStartDate and nvl(df.OnHoldEndDate,DATEADD(d,1,getdate()))
      join HAH.DIM_BRANCH BRANCH
            ON T.DbName = BRANCH.OFFICE_STATE_CODE
            AND O.OfficeNumber= BRANCH.OFFICE_NUMBER
  WHERE co.RevenueCategory <> 'cls'
       AND co.RevenueCategory IN ( 'HC', 'HH' )
       AND co.Billable = 1
      AND co.Payable = 1
		and nvl(co.IsMileage,0) = 0
		and ContractName NOT LIKE '%TRANSPORT%' AND ContractName NOT LIKE '%DRUG%'
		AND ContractName NOT LIKE '%DCFS%' 
		and(c.EndServiceDate > cast(CALENDAR_DATE as date) or c.EndServiceDate is null)
        AND CALENDAR_DATE <= GETDATE() AND CALENDAR_DATE >= '2020-01-29'
		
group by DATE.HAH_CURRENT_WEEK_FIRST_DAY
,O.DBNAME,OFFICENAME,BRANCH_KEY

ORDER BY 1 DESC;
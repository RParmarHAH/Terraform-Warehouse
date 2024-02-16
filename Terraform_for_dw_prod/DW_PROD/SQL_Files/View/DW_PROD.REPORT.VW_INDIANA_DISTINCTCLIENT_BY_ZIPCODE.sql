create or replace view DW_PROD.REPORT.VW_INDIANA_DISTINCTCLIENT_BY_ZIPCODE(
	CLIENT_ZIP,
	DETAILED_OFFICE_NAME,
	REVENUE_CATEGORY,
	CLIENTDISTINCTCOUNT
) as
SELect CLIENT_ZIP,DETAILED_OFFICE_NAME,REVENUE_CATEGORY,count(distinct v.client_key) as ClientDistinctCount from hah.fact_visit v
inner join hah.dim_client cl 
on cl.client_key  = v.client_key
inner join hah.dim_contract ct
on ct.contract_key = v.contract_key
inner join hah.dim_branch bc
on bc.branch_key = v.branch_key
left outer join hah.dim_geography g
on g.ZIP_CODE = cl.CLIENT_ZIP
where v.source_system_id = 3 and v.system_code = 'IN'
and month(service_Date) = 4 and year(service_date) = 2020
and ct.REVENUE_CATEGORY in ('HC','HH','CLS')
and g.zip_Code is null
group by client_zip,REVENUE_CATEGORY,DETAILED_OFFICE_NAME;
resource "snowflake_view" "DISC_HHAEXCHANGEOPENSYSTEMS_VW_OPENSYSTEMS_REVENUE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "VW_OPENSYSTEMS_REVENUE"
	statement = <<-SQL
	 
(SELECT 
SC.SERVICECODEID,
SC.CONTRACTID,
SC.CONTRACTNAME, 
SC.SERVICECODE,
SC.DISCIPLINE,
CASE WHEN SC.DISCIPLINE IN ('HCSS','HSK','PCA','RESP', 'HMK','COMP','Other (Non Skilled)','Other(Non Skilled)') THEN 'HC'
WHEN SC.DISCIPLINE = 'HHA' AND SC.SERVICECODE IN ('Daily0','Rate0','Support Svcs','T1019','T1019:TT',
                                                  'T1019:UN','T1019:UP','T2025','T2025-R1','T2025-R2','T2025-R3',
                                                  'T2025-R4','T1021GY','T1021TDTT','T1021TD','T1021TTGY','T1021TT',
                                                  'T1022','T1030TT-OLD','T1030-OLD','T1031TT-OLD','T1031-OLD','T1021',
                                                  'T1004','T1004','T1021','T1021TD','T1019 CR','T1019 CR U3','Non-billable',
                                                  'T1019 CR U1','T1019 CR U2','T1019 CR U1','T1019 CR U2') THEN 'HC'
WHEN SC.DISCIPLINE = 'PC' AND SC.SERVICECODE IN ('T1019','T101912','T101976','T1019CG','T1019TT','T1019U2','T1019U5',
                                                 'T1019UA','T1019UC','T1019','T101912','T101976','T1019CG','T1019TT',
                                                 'T1019U2','T1019U5','T1019UA','T1019UC') THEN 'HC'
WHEN SC.DISCIPLINE = 'HHA' AND SC.SERVICECODE IN ('G0156','G0156AT','G0156TT','G0156U8','G0156U8UD','G0156U9',
                                                  'G0156UD','S9122','S9122:TT','S9122:UN','S9122:UP','S9122UD') THEN 'HH'
WHEN SC.DISCIPLINE = 'PC' AND SC.SERVICECODE IN ('S9122','S9122TT','S9122TTUF','S9122UF') THEN 'HH'
WHEN SC.DISCIPLINE IN ('LPN','MSW','OT','PT','RN','ST', 'RT','NT','Other (Skilled)','Other(Skilled)') THEN 'HH'
ELSE 'UNKNOWN'
END REVENUE_CATEGORY,
CASE WHEN REVENUE_CATEGORY = 'HH' THEN 'HHA'
     WHEN REVENUE_CATEGORY = 'HC' THEN 'HC'
     ELSE 'UNKNOWN'
     END 
     AS REVENUE_SUBCATEGORY_CODE,
CASE WHEN   REVENUE_SUBCATEGORY_CODE= 'HHA' THEN 'Home Health Aide'
     WHEN   REVENUE_SUBCATEGORY_CODE= 'HC' THEN 'Home Care'
     ELSE 'UNKNOWN'
     END 
     AS REVENUE_SUBCATEGORY_NAME
FROM 
DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.SERVICECODES SC
);
SQL
	or_replace = true 
	is_secure = false 
}


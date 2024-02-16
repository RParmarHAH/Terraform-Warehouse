CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_PAYERS (
	PAY_ID NUMBER(19,0),
	PAY_BRANCHID NUMBER(10,0),
	PAY_CLIENTID NUMBER(19,0),
	PAY_NAME VARCHAR(50),
	PAY_ADDRESS1 VARCHAR(255),
	PAY_ADDRESS2 VARCHAR(60),
	PAY_CITY VARCHAR(50),
	PAY_STATEORPROVINCE VARCHAR(20),
	PAY_POSTALCODE VARCHAR(20),
	PAY_COUNTY VARCHAR(50),
	PAY_COUNTRY NUMBER(10,0),
	PAY_ACTIVE BOOLEAN,
	PAY_CONTACTSALUT VARCHAR(5),
	PAY_CONTACTTITLE VARCHAR(50),
	PAY_CONTACTFIRSTNAME VARCHAR(50),
	PAY_CONTACTLASTNAME VARCHAR(50),
	PAY_PHONE VARCHAR(30),
	PAY_PHONETYPE NUMBER(10,0),
	PAY_NOTES VARCHAR(16777216),
	PAY_PAYERTYPEID NUMBER(10,0),
	PAY_NPI VARCHAR(10),
	PAY_BILLTYPEID NUMBER(10,0),
	PAY_AGENCYPROVIDERNUM VARCHAR(20),
	PAY_EXCLUDEFROMBATCH BOOLEAN,
	PAY_PAYMENTTYPEID NUMBER(10,0),
	PAY_REGIONID NUMBER(10,0),
	PAY_AUTHREQUIRED BOOLEAN,
	PAY_ANSIISAFI01 VARCHAR(2),
	PAY_ANSIISAFI02 VARCHAR(10),
	PAY_ANSIISAFI03 VARCHAR(2),
	PAY_ANSIISAFI04 VARCHAR(10),
	PAY_ANSIISAFI05_1 VARCHAR(2),
	PAY_ANSIISAFI06 VARCHAR(15),
	PAY_ANSIISAFI05_2 VARCHAR(2),
	PAY_ANSIISAFI07 VARCHAR(15),
	PAY_ANSIISAFI10 VARCHAR(1),
	PAY_ANSIISAFI11 VARCHAR(5),
	PAY_ANSIISAFI12 VARCHAR(9),
	PAY_ANSIISAFI13 VARCHAR(1),
	PAY_ANSIISAFI14 VARCHAR(1),
	PAY_ANSIISAFI15 VARCHAR(1),
	PAY_ANSIGSF479 VARCHAR(2),
	PAY_ANSIGSF28 NUMBER(10,0),
	PAY_ANSIGSF455 VARCHAR(2),
	PAY_ANSIGSF480 VARCHAR(12),
	PAY_ANSISTF143 VARCHAR(3),
	PAY_ANSISTF329 VARCHAR(9),
	PAY_ANSISTF1705 VARCHAR(35),
	PAY_ANSIBHTF1005 VARCHAR(4),
	PAY_ANSIHEADERREFF128 VARCHAR(3),
	PAY_ANSIHEADERREFF127 VARCHAR(30),
	PAY_ANSILOOP1000ANM1F98 VARCHAR(3),
	PAY_ANSILOOP1000BNM1F98 VARCHAR(3),
	PAY_ANSILOOP1000ANM1F66 VARCHAR(2),
	PAY_ANSILOOP1000BNM1F66 VARCHAR(2),
	PAY_ANSIRECEIVERNAME VARCHAR(35),
	PAY_ANSIIDTYPE1 NUMBER(3,0),
	PAY_ANSIIDTYPE2 NUMBER(3,0),
	PAY_ANSIIDTYPE3 NUMBER(3,0),
	PAY_ANSIPHYSIDTYPE1 NUMBER(3,0),
	PAY_ANSIPHYSIDTYPE2 NUMBER(3,0),
	PAY_ANSIPHYSIDTYPE3 NUMBER(3,0),
	PAY_INVOICETOTALROUND NUMBER(3,0),
	PAY_INVOICETOTALROUNDDECIMAL NUMBER(3,0),
	PAY_INVOICELINEROUND NUMBER(3,0),
	PAY_INVOICELINEROUNDDECIMAL NUMBER(3,0),
	PAY_EDITYPEID NUMBER(10,0),
	PAY_CREATEDDATE TIMESTAMP_NTZ(9),
	PAY_CREATEDUSER VARCHAR(50),
	PAY_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PAY_MODIFIEDUSER VARCHAR(50),
	PAY_TS VARCHAR(100),
	PAY_STATUSID NUMBER(10,0),
	PAY_LEGACYID NUMBER(10,0),
	PAY_LEGACYBRANCHID NUMBER(10,0),
	PAY_EMAIL VARCHAR(50),
	PAY_ERNID VARCHAR(10),
	PAY_ITEMIZE1500BILLING BOOLEAN,
	PAY_ALLOWMASSEMAIL BOOLEAN,
	PAY_AUTHORIZATIONCONFLICTSALLOW NUMBER(3,0),
	PAY_AUTHORIZATIONCONFLICTSOVERRIDE NUMBER(3,0),
	PAY_DAILYBENEFIT12AM BOOLEAN,
	PAY_SHOWDFPSPLIT NUMBER(3,0),
	PAY_SHOWDFPBALANCE NUMBER(3,0),
	PAY_SHOWDFPDAILYBENEFIT NUMBER(3,0),
	PAY_SHOWDFPVISIT NUMBER(3,0),
	PAY_USECLIENTFORINSURED BOOLEAN,
	PAY_INVDETAILPROVIDERTYPEID NUMBER(3,0),
	PAY_USEBILLCONTACTFORSIGN BOOLEAN,
	PAY_USEBILLPROVIDERFORFACILITY BOOLEAN,
	PAY_BILLBYSHIFT BOOLEAN,
	PAY_STAMPAUTH BOOLEAN,
	PAY_DXVERSIONDEFAULT NUMBER(3,0),
	PAY_CONTACTSALUTATIONID NUMBER(10,0),
	PAY_INVBREAKBYAUTH BOOLEAN,
	PAY_INVBREAKBYHCPCS BOOLEAN,
	PAY_INVOICEUNITFLAG NUMBER(5,0),
	PAY_INVOICEFROMTOTYPE NUMBER(3,0),
	PAY_SHOWINVFROMDTONLY BOOLEAN,
	PAY_ELECTPMTGATEWAYCUSTPROFILEID VARCHAR(20),
	PAY_ELECTPMTDFLTCUSTPMTPROFILEID VARCHAR(20),
	PAY_INVPARM_DISPLAYBRLOGO NUMBER(3,0),
	PAY_INVPARM_DISPLAYCRBALANCES NUMBER(3,0),
	PAY_INVPARM_DISPLAYCARFISTNAMEONLY NUMBER(3,0),
	PAY_INVPARM_DISPLAYRECENTPMTS NUMBER(3,0),
	PAY_INVPARM_DISPLAYOUTSTANDINGINV NUMBER(3,0),
	PAY_INVPARM_DISPLAYDEPOSITBALANCES NUMBER(3,0),
	PAY_INVPARM_PMTWITHINDAYS NUMBER(3,0),
	PAY_1500OTHRPVDRTYPE NUMBER(3,0),
	PAY_AUTHORIZATIONFROMPHYSICANORDER BOOLEAN,
	PAY_485BOX1USEPOLICYNUMBER BOOLEAN,
	PAY_INVPARM_DISPLAYSCHTIME NUMBER(3,0),
	PAY_ANSIISAFI65 VARCHAR(1),
	PAY_DELIVERYMETHOD NUMBER(3,0),
	PAY_ANSISBR1032 VARCHAR(2),
	PAY_ANSILOOP2310A_ENABLE NUMBER(3,0),
	PAY_ANSILOOP2310B_ENABLE NUMBER(3,0),
	PAY_ANSILOOP2310C_ENABLE NUMBER(3,0),
	PAY_ANSICLM1359 VARCHAR(1),
	PAY_ANSICLM1351 VARCHAR(1),
	PAY_ANSICLM1331 VARCHAR(2),
	PAY_ANSICLM1325 VARCHAR(1),
	PAY_ANSICLM1073_1 VARCHAR(1),
	PAY_EDIPOSTINGTYPEID NUMBER(3,0),
	PAY_ANSILOOP2300REF_9F_ENABLE NUMBER(3,0),
	PAY_EDIADDITIONALID VARCHAR(50),
	PAY_EDIADDITIONALIDTYPE VARCHAR(3),
	PAY_INVPARM_PAYERINVGROUPBY NUMBER(3,0),
	PAY_ANSILOOP2010BBNM1F1035_1 VARCHAR(60),
	PAY_ANSILOOP2010BBNM1F66 VARCHAR(2),
	PAY_ANSILOOP2010BBNM1F67 VARCHAR(80),
	PAY_INVPARM_DISPLAYSCHNOTE NUMBER(3,0),
	PAY_INVOICEGROUPINGTYPEID NUMBER(10,0),
	PAY_WEEKLYBENEFITSTART NUMBER(3,0),
	PAY_MONTHLYBENEFITSTART NUMBER(3,0),
	PAY_ANSILOOP1000ANM1F1035_1 VARCHAR(60),
	PAY_ANSILOOP1000ANM1F67 VARCHAR(80),
	PAY_ANSILOOP1000BNM1F67 VARCHAR(80),
	PAY_ANSIGSF142 VARCHAR(15),
	PAY_ANSIGSF124 VARCHAR(15),
	PAY_ANSILOOP2000C_ENABLE NUMBER(3,0),
	PAY_CONTALLOWADJ NUMBER(10,0),
	PAY_INVBREAKBYPOC BOOLEAN,
	PAY_EDI837_TERMINATESEGMENTWITHLINEFEED BOOLEAN,
	PAY_INVPARM_DISPLAYRATESCHARGES BOOLEAN,
	PAY_FEATURES NUMBER(10,0),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);
CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PLACEMENTMASTERWEEK (
	OFFICEID NUMBER(10,0),
	AGENCYID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	MASTERWEEKHEADERID NUMBER(10,0) NOT NULL,
	MASTERWEEKFROMDATE TIMESTAMP_NTZ(9),
	MASTERWEEKTODATE TIMESTAMP_NTZ(9),
	SATURDAYFROMTIME VARCHAR(4),
	SATURDAYTOTIME VARCHAR(4),
	SATURDAYAIDEID NUMBER(10,0),
	SATURDAYASSIGNMENTID VARCHAR(6),
	SATURDAYRATE VARCHAR(10),
	SATPAYRATEID NUMBER(10,0),
	SATURDAYPOC NUMBER(10,0),
	SATCONTRACTID1 NUMBER(19,0),
	SATHOURS1 VARCHAR(3),
	SATMINUTES1 VARCHAR(2),
	SATPAYRATEID1 NUMBER(10,0),
	SATCONTRACTID2 NUMBER(19,0),
	SATHOURS2 VARCHAR(3),
	SATMINUTES2 VARCHAR(2),
	SATPAYRATEID2 NUMBER(10,0),
	SATINCLUDEMILEAGEEXPENSE VARCHAR(1),
	SUNDAYFROMTIME VARCHAR(4),
	SUNDAYTOTIME VARCHAR(4),
	SUNDAYAIDEID NUMBER(10,0),
	SUNDAYASSIGNMENTID VARCHAR(6),
	SUNDAYRATE VARCHAR(10),
	SUNPAYRATEID NUMBER(10,0),
	SUNDAYPOC NUMBER(10,0),
	SUNCONTRACTID1 NUMBER(19,0),
	SUNHOURS1 VARCHAR(3),
	SUNMINUTES1 VARCHAR(2),
	SUNPAYRATEID1 NUMBER(10,0),
	SUNCONTRACTID2 NUMBER(19,0),
	SUNHOURS2 VARCHAR(3),
	SUNMINUTES2 VARCHAR(2),
	SUNPAYRATEID2 NUMBER(10,0),
	SUNINCLUDEMILEAGEEXPENSE VARCHAR(1),
	MONDAYFROMTIME VARCHAR(4),
	MONDAYTOTIME VARCHAR(4),
	MONDAYAIDEID NUMBER(10,0),
	MONDAYASSIGNMENTID VARCHAR(6),
	MONDAYRATE VARCHAR(10),
	MONPAYRATEID NUMBER(10,0),
	MONDAYPOC NUMBER(10,0),
	MONCONTRACTID1 NUMBER(19,0),
	MONHOURS1 VARCHAR(3),
	MONMINUTES1 VARCHAR(10),
	MONPAYRATEID1 NUMBER(10,0),
	MONCONTRACTID2 NUMBER(19,0),
	MONHOURS2 VARCHAR(3),
	MONMINUTES2 VARCHAR(2),
	MONPAYRATEID2 NUMBER(10,0),
	MONINCLUDEMILEAGEEXPENSE VARCHAR(1),
	TUESDAYFROMTIME VARCHAR(4),
	TUESDAYTOTIME VARCHAR(4),
	TUESDAYAIDEID NUMBER(10,0),
	TUESDAYASSIGNMENTID VARCHAR(6),
	TUESDAYRATE VARCHAR(10),
	TUEPAYRATEID NUMBER(10,0),
	TUESDAYPOC NUMBER(10,0),
	TUEBILLTO NUMBER(19,0),
	TUEHOURS VARCHAR(3),
	TUEMINUTES VARCHAR(2),
	TUEPAYRATEID1 NUMBER(10,0),
	TUECONTRACTID2 NUMBER(19,0),
	TUEHOURS2 VARCHAR(3),
	TUEMINUTES2 VARCHAR(2),
	TUEPAYRATEID2 NUMBER(10,0),
	TUEINCLUDEMILEAGEEXPENSE VARCHAR(1),
	WEDNESDAYFROMTIME VARCHAR(4),
	WEDNESDAYTOTIME VARCHAR(4),
	WEDNESDAYAIDEID NUMBER(10,0),
	WEDNESDAYASSIGNMENTID VARCHAR(6),
	WEDNESDAYRATE VARCHAR(10),
	WEDPAYRATEID NUMBER(10,0),
	WEDNESDAYPOC NUMBER(10,0),
	WEDCONTRACTID1 NUMBER(19,0),
	WEDHOURS1 VARCHAR(3),
	WEDMINUTES1 VARCHAR(2),
	WEDPAYRATEID1 NUMBER(10,0),
	WEDCONTRACTID2 NUMBER(19,0),
	WEDHOURS2 VARCHAR(3),
	WEDMINUTES2 VARCHAR(2),
	WEDPAYRATEID2 NUMBER(10,0),
	WEDINCLUDEMILEAGEEXPENSE VARCHAR(1),
	THURSDAYFROMTIME VARCHAR(4),
	THURSDAYTOTIME VARCHAR(4),
	THURSDAYAIDEID NUMBER(10,0),
	THURSDAYASSIGNMENTID VARCHAR(6),
	THURSDAYRATE VARCHAR(10),
	THUPAYRATEID NUMBER(10,0),
	THURSDAYPOC NUMBER(10,0),
	THUCONTRACTID1 NUMBER(19,0),
	THUHOURS1 VARCHAR(3),
	THUMINUTES1 VARCHAR(2),
	THUPAYRATEID1 NUMBER(10,0),
	THUCONTRACTID2 NUMBER(19,0),
	THUHOURS2 VARCHAR(3),
	THUMINUTES2 VARCHAR(2),
	THUPAYRATEID2 NUMBER(10,0),
	THUINCLUDEMILEAGEEXPENSE VARCHAR(1),
	FRIDAYFROMTIME VARCHAR(4),
	FRIDAYTOTIME VARCHAR(4),
	FRIDAYAIDEID NUMBER(10,0),
	FRIDAYASSIGNMENTID VARCHAR(6),
	FRIDAYRATE VARCHAR(10),
	FRIPAYRATEID NUMBER(10,0),
	FRIDAYPOC NUMBER(10,0),
	FRICONTRACTID1 NUMBER(19,0),
	FRIHOURS1 VARCHAR(3),
	FRIMINUTES1 VARCHAR(2),
	FRIPAYRATEID1 NUMBER(10,0),
	FRICONTRACTID2 NUMBER(19,0),
	FRIHOURS2 VARCHAR(3),
	FRIMINUTES2 VARCHAR(2),
	FRIPAYRATEID2 NUMBER(10,0),
	FRIINCLUDEMILEAGEEXPENSE VARCHAR(1),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);
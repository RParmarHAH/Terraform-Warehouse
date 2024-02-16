CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EINFO_TABLE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  GET_EINFO_TABLE 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE            	AUTHOR                  	NOTES:
-- ----------      	-------------------     	-----------------------------------------------------------------------------------------------
-- 2023-11-20     	JIGAR PRAJAPATI          	INITIAL DEVELOPMENT
--*****************************************************************************************************************************

    BEGIN
       --insert in hist table
       INSERT INTO EmpeonEdison.Hist_EInfo_table (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS lastName, t.$4 AS firstName, t.$5 AS middleName, t.$6 AS address1, t.$7 AS address2, t.$8 AS city, t.$9 AS state, t.$10 AS zip, t.$11 AS county, t.$12 AS country, t.$13 AS ssn, t.$14 AS birthDate, t.$15 AS sex, t.$16 AS payGroup, t.$17 AS hireDate, t.$18 AS rehireDate, t.$19 AS adjSeniorityDate, t.$20 AS termDate, t.$21 AS newhireReportDate, t.$22 AS cc, t.$23 AS cc1, t.$24 AS cc2, t.$25 AS cc3, t.$26 AS cc4, t.$27 AS cc5, t.$28 AS wcc, t.$29 AS clock, t.$30 AS payGrade, t.$31 AS baseRate, t.$32 AS ratePer, t.$33 AS salary, t.$34 AS defaultHours, t.$35 AS payFrequency, t.$36 AS annualSalary, t.$37 AS autoPay, t.$38 AS jobCode, t.$39 AS tipped, t.$40 AS guidfield, t.$41 AS lastChange, t.$42 AS lastChangeUser, t.$43 AS password, t.$44 AS salutation, t.$45 AS surname, t.$46 AS nickname, t.$47 AS priorLastName, t.$48 AS homePhone, t.$49 AS ethnicity, t.$50 AS maritalStatus, t.$51 AS disabilityDesc, t.$52 AS veteranDesc, t.$53 AS smoker, t.$54 AS positionCode, t.$55 AS positionInfoLocked, t.$56 AS title, t.$57 AS eeoClass, t.$58 AS flsaOTExempt, t.$59 AS workPhone, t.$60 AS workPhoneExt, t.$61 AS mailStop, t.$62 AS emailAddress, t.$63 AS taxForm, t.$64 AS pension, t.$65 AS statutory, t.$66 AS deceased, t.$67 AS deferredComp, t.$68 AS legalRep, t.$69 AS domesticEmpl, t.$70 AS seasonal, t.$71 AS i9Verified, t.$72 AS i9Reverify, t.$73 AS citizenship, t.$74 AS visaType, t.$75 AS visaExpiration, t.$76 AS unionCode, t.$77 AS unionDate, t.$78 AS unionInitFees, t.$79 AS unionDues, t.$80 AS supervisorID, t.$81 AS supervisorName, t.$82 AS lastRaiseDate, t.$83 AS lastRaiseAmount, t.$84 AS lastRaiseReason, t.$85 AS nextRaiseDate, t.$86 AS lastReviewDate, t.$87 AS lastReviewRating, t.$88 AS nextReviewDate, t.$89 AS user1, t.$90 AS user2, t.$91 AS user3, t.$92 AS user4, t.$93 AS user5, t.$94 AS user6, t.$95 AS user7, t.$96 AS user8, t.$97 AS miscCheck1, t.$98 AS miscCheck2, t.$99 AS miscCheck3, t.$100 AS miscCheck4, t.$101 AS miscCheck5, t.$102 AS ee401kDeferral, t.$103 AS ee401kCalc, t.$104 AS ee401kContinue, t.$105 AS ee401kEligibleDate, t.$106 AS ee401kStatus, t.$107 AS ee401kSuspendDate, t.$108 AS er401kMatch, t.$109 AS highComp, t.$110 AS owner, t.$111 AS ownerPercent, t.$112 AS ownerRelated, t.$113 AS ownerSSN, t.$114 AS memo, t.$115 AS showMemo, t.$116 AS newhireCalendarId, t.$117 AS newhireSB, t.$118 AS workState, t.$119 AS officer, t.$120 AS wageType, t.$121 AS family, t.$122 AS probation, t.$123 AS distributionCodes, t.$124 AS cellPhone, t.$125 AS masterRecordForACA, t.$126 AS cmsPBJId, t.$127 AS addressNotes, t.$128 AS contactNotes, t.$129 AS demographicNotes, t.$130 AS facebook, t.$131 AS fileStorageUsed, t.$132 AS jobCategory, t.$133 AS jobNotes, t.$134 AS languagesSpoken, t.$135 AS linkedIn, t.$136 AS skype, t.$137 AS twitterUsername, t.$138 AS EssAccountCreated, t.$139 AS NewHireHandled, t.$140 AS isPBJ, t.$141 AS isManager, t.$142 AS profileImg, t.$143 AS fullName, t.$144 AS unionDedAuth, t.$145 AS timeZoneId, t.$146 AS clockCardNo, t.$147 AS clockFilter, t.$148 AS clockManager, t.$149 AS clockPw, t.$150 AS legacyEligibleForRehire, t.$151 AS legacyEmpStatus, t.$152 AS legacyEmpType, t.$153 AS legacyTermReason, t.$154 AS termReason, t.$155 AS empType, t.$156 AS empStatus, t.$157 AS eligibleForRehire, t.$158 AS payToSchedule, t.$159 AS attendanceExcluded, t.$160 AS webClock, t.$161 AS onboardingId, t.$162 AS pbjEmpId, t.$163 AS pbjEmpType, t.$164 AS allowMissingPunch, t.$165 AS workAuthorizationStatus, t.$166 AS workEmail, t.$167 AS firstPayDate, t.$168 AS lastPayDate, t.$169 AS SYS_CHANGE_VERSION, t.$170 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$170,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EInfo_table.*[.]csv.gz'')T);
       
       ----Create Current Table---
        CREATE OR REPLACE TABLE DISC_PROD.EmpeonEdison.EInfo_table 
        AS WITH curr_v AS 
        (SELECT co, id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE 
        FROM DISC_PROD.EmpeonEdison.Hist_EInfo_table GROUP BY co, id) 
        SELECT P.* exclude ETL_DELETED_FLAG,
        CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE P.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG 
        FROM DISC_PROD.EmpeonEdison.Hist_EInfo_table P 
        INNER JOIN curr_v v ON P.co = v.co AND P.id = v.id
        AND P.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;
       
        ----REPLACE HIST TABLE WITH CURRETN TABLE 
       CREATE OR REPLACE table DISC_PROD.EmpeonEdison.Hist_EInfo_table CLONE DISC_PROD.EmpeonEdison.EInfo_table;
       
    END;
';
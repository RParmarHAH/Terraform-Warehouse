CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_TRAINEEPROFILE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_TraineeProfile 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.TraineeProfile (SELECT t.$1 AS AgencyID, t.$2 AS TraineeID, t.$3 AS Office, t.$4 AS FirstName, t.$5 AS LastName, t.$6 AS Status, t.$7 AS ProgramEnrolledIn, t.$8 AS ClassStartDate, t.$9 AS CompletionDate, t.$10 AS ProgramEnrolled, t.$11 AS DateOfEnrollment, t.$12 AS CertificateDate, t.$13 AS CertificateAwarded, t.$14 AS CertificatePrintedDate, t.$15 AS CertifiedHCR, t.$16 AS TrainingSchool, t.$17 AS CountryOfBirth, t.$18 AS ReferralSource, t.$19 AS Initials, t.$20 AS Language1, t.$21 AS DateofBirth, t.$22 AS EthnicityText, t.$23 AS Ethnicity, t.$24 AS Language2, t.$25 AS Gender, t.$26 AS MaritalStatus, t.$27 AS SSN, t.$28 AS MiddleName, t.$29 AS Reference1, t.$30 AS Reference2, t.$31 AS Team, t.$32 AS VerificationMethod1, t.$33 AS VerificationMethod2, t.$34 AS Verified1, t.$35 AS Verified2, t.$36 AS Location, t.$37 AS Competency, t.$38 AS Branch, t.$39 AS Address1, t.$40 AS Address2, t.$41 AS CrossStreet, t.$42 AS City, t.$43 AS State, t.$44 AS ZipCode, t.$45 AS Phone, t.$46 AS Phone2, t.$47 AS Phone3, t.$48 AS Emergency1Relationship, t.$49 AS Emergency1Address, t.$50 AS Emergency1Name, t.$51 AS Emergency1Phone1, t.$52 AS Emergency1Phone2, t.$53 AS Emergency2Relationship, t.$54 AS Emergency2Address, t.$55 AS Emergency2Name, t.$56 AS Emergency2Phone1, t.$57 AS Emergency2Phone2, t.$58 AS GPA, t.$59 AS HCRCertificateReceivedDate, t.$60 AS HHAFinalGrade, t.$61 AS SPT, t.$62 AS SupPracticalTraining, t.$63 AS TrainingSite, t.$64 AS VerificationDate, t.$65 AS Average, t.$66 AS ClassCompletionDate, t.$67 AS Instructor, t.$68 AS InstructorName, t.$69 AS TuitionSponsorship, t.$70 AS JobPlacement, t.$71 AS PCASchool, t.$72 AS Verified, t.$73 AS EntranceExamination, t.$74 AS ATBTest, t.$75 AS SignedByRN, t.$76 AS Score, t.$77 AS PCACertificate, t.$78 AS PCAFinalGrade, t.$79 AS HighSchoolDiploma, t.$80 AS I9Document1, t.$81 AS I9Document, t.$82 AS I9DocumentText, t.$83 AS EVerifyNumber, t.$84 AS I9DocumentExpiration, t.$85 AS I9Verified, t.$86 AS RelationshipName1, t.$87 AS RelationshipName2, t.$88 AS CaregiverID, t.$89 AS ReferralSourceID, t.$90 AS LocationID, t.$91 AS BranchID, t.$92 AS TraineeTeamID, t.$93 AS OfficeID, t.$94 AS CreatedDate, t.$95 AS LastModifiedDate, t.$96 AS SYS_CHANGE_VERSION, t.$97 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$97,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_TraineeProfile.*[.]csv.gz'') T);

    return ''Success'';
END;
';
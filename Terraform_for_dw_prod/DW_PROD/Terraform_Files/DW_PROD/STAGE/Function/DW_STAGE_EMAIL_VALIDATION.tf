resource "snowflake_function" "DW_STAGE_EMAIL_VALIDATION" {
	name = "EMAIL_VALIDATION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	language  = "SQL"

	arguments {
		name = "email"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	statement = <<-EOT

-- PURPOSE: Validates Email address according to the standard rules
--
-- DEVELOPMENT LOG:
-- DATE          AUTHOR                NOTES:
-- --------      -------------------   --------------------------------------------------------------------------------------------------
-- 01/31/2024    Shikhar Saxena        Initial development

	CASE WHEN TRIM(email) IS NULL THEN
		NULL
	WHEN REGEXP_LIKE(TRIM(email),'[a-zA-Z0-9\\\\[\\\\].!_#+$-?/`=^%*{|&?]{2,}+@[a-zA-Z0-9-]+(\\\\.[a-zA-Z]{2,4}|(\\\\.[a-zA-Z0-9]{2,}\\\\.[a-zA-Z]{2,4})|(\\\\.[a-zA-Z0-9]{2,}\\\\.[a-zA-Z]{2,4}\\\\.[a-zA-Z]{2,3}))$')=TRUE  -- basic pattern check 
	AND
	-- To check for two consecutive special characters
	(nvl(length(regexp_substr(TRIM(email),'(\\\\W{2,})|(_{2,})|(\\\\W_)+|(_\\\\W)+')),0)=0) = TRUE
	AND
	-- To check if there is any special character at start
	nvl(REGEXP_LIKE(TRIM(email),'\\\\W[a-zA-Z0-9\\\\[\\\\].!_#+$-?/`=^%*{|&?]{2,}+@[a-zA-Z0-9-]+(\\\\.[a-zA-Z]{2,4}|(\\\\.[a-zA-Z0-9]{2,}\\\\.[a-zA-Z]{2,4})|(\\\\.[a-zA-Z0-9]{2,}\\\\.[a-zA-Z]{2,4}\\\\.[a-zA-Z]{2,3}))$'),FALSE) = FALSE 
	AND
	-- To check if there is any special character before @
	nvl(REGEXP_LIKE(regexp_substr(email,'\\\\W@|\\\\_@'),'(^\\\\W)@|(^\\\\_)@'),FALSE) = FALSE
    AND
	-- To check for only numbers before @
    nvl(REGEXP_LIKE(substr(email,0,(position('@',email)-1)),'(^[0-9]*$)'),FALSE) = FALSE
	THEN email
	ELSE NULL
	END

 EOT
}


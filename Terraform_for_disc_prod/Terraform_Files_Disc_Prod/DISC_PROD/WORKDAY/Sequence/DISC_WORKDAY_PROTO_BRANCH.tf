resource "snowflake_sequence" "DISC_WORKDAY_PROTO_BRANCH" {
	name ="PROTO_BRANCH"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	start_with = -1
	increment  = -1
	order  = true
}


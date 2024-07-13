-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-----------------------------------------------------------------------------------------------------

---------------------
-- Any config
---------------------
{{ config(
    post_hook="ALTER TABLE {{this}} ADD CONSTRAINT pk1 PRIMARY KEY (city_id)"
) }}

---------------------
-- CTE's
---------------------

WITH 
    carmen_sightings
    AS
    (
        SELECT DISTINCT
                cs.country_id										    AS country_id,
                cs.city_id											    AS city_id,
                cs.city											        AS city,
				----------------
				-- audit trail
				----------------
				'{{ invocation_id }}'          							AS dw_created_run_id,
				current_timestamp()            							AS dw_created_dtm,
				'{{ invocation_id }}'          							AS dw_updated_run_id,
				current_timestamp()            							AS dw_updated_dtm    
		FROM
				{{ ref ( 'int_cs_sightings_add_keys' ) 	}} AS cs
    )

------------------------------

SELECT * FROM carmen_sightings



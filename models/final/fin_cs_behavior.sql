-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-----------------------------------------------------------------------------------------------------

---------------------
-- Any config
---------------------

{{ config(
    post_hook="ALTER TABLE {{this}} ADD CONSTRAINT pk1 PRIMARY KEY (behavior_id)" 
) }}

---------------------
-- CTE's
---------------------

WITH 
    carmen_sightings
    AS
    (
        SELECT DISTINCT
                cs.behavior_id											AS behavior_id,
                cs.behavior											    AS behavior,
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



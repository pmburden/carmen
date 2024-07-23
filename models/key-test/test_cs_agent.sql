-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-----------------------------------------------------------------------------------------------------

---------------------
-- Any config
---------------------


---------------------
-- CTE's
---------------------

WITH 
    carmen_sightings
    AS
    (
        SELECT DISTINCT
                cs.agent_id											    AS agent_id,
                cs.agent											    AS agent,
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



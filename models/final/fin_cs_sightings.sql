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
        SELECT 
                cs.region_id											AS region_id,
                --cs.region											    AS region,
				cs.date_witness											AS date_witness,
                cs.witness_id											AS witness_id,
				--cs.witness											AS witness,
				cs.agent_id											    AS agent_id,
                --cs.agent											    AS agent,
				cs.date_agent											AS date_agent,
				cs.city_agent											AS city_agent,
				cs.country_id											AS country_id,
                --cs.country											AS country,
				cs.city_id											    AS city_id,
                --cs.city											    AS city,
				cs.latitude											    AS latitude,
				cs.longitude											AS longitude,
				cs.has_weapon											AS has_weapon,
				cs.has_hat											    AS has_hat,
				cs.has_jacket											AS has_jacket,
				cs.behavior_id											AS behavior_id,
                --cs.behavior											AS behavior,
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






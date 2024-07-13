-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings staging model 
-- normally for basic tidy up, prep or column renaming
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
				------------
				-- main content
				------------
				cs.date_witness											AS date_witness,
				cs.witness											    AS witness,
				cs.agent											    AS agent,
				cs.date_agent											AS date_agent,
				cs.city_agent											AS city_agent,
				cs.country											    AS country,
				cs.city											        AS city,
				cs.latitude											    AS latitude,
				cs.longitude											AS longitude,
				cs.has_weapon											AS has_weapon,
				cs.has_hat											    AS has_hat,
				cs.has_jacket											AS has_jacket,
				cs.behavior											    AS behavior,
				----------------
				-- audit trail
				----------------
				'{{ invocation_id }}'          							AS dw_created_run_id
				--current_timestamp()            							AS dw_created_dtm,
				--'{{ invocation_id }}'          							AS dw_updated_run_id,
				--current_timestamp()            							AS dw_updated_dtm    
		FROM
				{{ ref ( 'africa' ) 	}} AS cs
	)

------------------------------

SELECT * FROM carmen_sightings


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
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
				----------------
				-- audit trail
				----------------
				'{{ invocation_id }}'          							AS dw_created_run_id
				--current_timestamp()            							AS dw_created_dtm,
				--'{{ invocation_id }}'          							AS dw_updated_run_id,
				--current_timestamp()            							AS dw_updated_dtm    
		FROM
				{{ ref ( 'asia' ) 	}} AS cs
	)

------------------------------

SELECT * FROM carmen_sightings



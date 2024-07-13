-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings staging model 
-- combine all sighting files
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
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'africa'            AS region
		FROM
				{{ ref ( 'africa' ) 	}} AS cs
        UNION 
		SELECT
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'america'            AS region
		FROM
				{{ ref ( 'america' ) 	}} AS cs
        UNION 
		SELECT
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'asia'            AS region
		FROM
				{{ ref ( 'asia' ) 	}} AS cs
        UNION 
		SELECT
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'atlantic'            AS region
		FROM
				{{ ref ( 'atlantic' ) 	}} AS cs
        UNION 
		SELECT
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'australia'            AS region
		FROM
				{{ ref ( 'australia' ) 	}} AS cs
        UNION 
		SELECT
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'europe'            AS region
		FROM
				{{ ref ( 'europe' ) 	}} AS cs
        UNION 
		SELECT
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'india'            AS region
		FROM
				{{ ref ( 'india' ) 	}} AS cs 
        UNION 
		SELECT
                {% for col_name in ["date_witness", "witness", "agent","date_agent","city_agent","country","city"
                ,"latitude","longitude","has_weapon","has_hat","has_jacket","behavior"] %}
                    cs.{{col_name}},
                {% endfor %}
                    'pacific'            AS region
		FROM
				{{ ref ( 'pacific' ) 	}} AS cs      
	), 


    final 
    AS
    ( 
        SELECT
                cs.region											    AS region,
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
				'{{ invocation_id }}'          							AS dw_created_run_id,
				current_timestamp()            							AS dw_created_dtm,
				'{{ invocation_id }}'          							AS dw_updated_run_id,
				current_timestamp()            							AS dw_updated_dtm    
        FROM carmen_sightings AS  cs
    )
------------------------------

SELECT * FROM final

---------------------
-- Any triggers
---------------------

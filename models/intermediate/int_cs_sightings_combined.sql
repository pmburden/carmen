-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-- combine all sighting files
-----------------------------------------------------------------------------------------------------

---------------------
-- Any config
---------------------
{{
  config(
    materialized = "table"
  )
}}

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
	)

------------------------------

SELECT * FROM carmen_sightings

---------------------
-- Any triggers
---------------------

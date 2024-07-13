-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-- add key and months 
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
    combined_sightings
    AS
    (
        SELECT 
                cs.region											    AS region,
                TRY_TO_DATE( cs.date_witness, 'dd/mm/yyyy' )            AS date_witness,
				cs.witness											    AS witness,
				cs.agent											    AS agent,
                TRY_TO_DATE( cs.date_agent, 'dd/mm/yyyy' )              AS date_agent,
				cs.city_agent											AS city_agent,
				cs.country											    AS country,
				cs.city											        AS city,
				cs.latitude											    AS latitude,
				cs.longitude											AS longitude,
				cs.has_weapon											AS has_weapon,
				cs.has_hat											    AS has_hat,
				cs.has_jacket											AS has_jacket,
				cs.behavior											    AS behavior
		FROM
				{{ ref ( 'int_cs_sightings_combined' ) 	}} AS cs   
    ),

	carmen_sightings
    AS
    ( 
        SELECT

                {{ dbt_utils.generate_surrogate_key([
                        'region'
                    ])
                }} as region_id, 
                cs.region											    AS region,
				cs.date_witness											AS date_witness,
                DATE_PART(MONTH , cs.date_witness )                     AS date_witness_month,		
                {{ dbt_utils.generate_surrogate_key([
                        'witness'
                    ])
                }} as witness_id, 								
				cs.witness											    AS witness,
                {{ dbt_utils.generate_surrogate_key([
                        'agent'
                    ])
                }} as agent_id, 
				cs.agent											    AS agent,
				cs.date_agent											AS date_agent,
                DATE_PART(MONTH , cs.date_agent )                       AS date_agent_month,
                {{ dbt_utils.generate_surrogate_key([
                        'city_agent'
                    ])
                }} as city_agent_id, 
				cs.city_agent											AS city_agent,
                {{ dbt_utils.generate_surrogate_key([
                        'country'
                    ])
                }} as country_id, 
				cs.country											    AS country,
                {{ dbt_utils.generate_surrogate_key([
                        'country',
                        'city'
                    ])
                }} as city_id, 
				cs.city											        AS city,
				cs.latitude											    AS latitude,
				cs.longitude											AS longitude,
				cs.has_weapon											AS has_weapon,
				cs.has_hat											    AS has_hat,
				cs.has_jacket											AS has_jacket,
                {{ dbt_utils.generate_surrogate_key([
                        'behavior'
                    ])
                }} as behavior_id, 
				cs.behavior											    AS behavior,                
				----------------
				-- audit trail
				----------------
				'{{ invocation_id }}'          							AS dw_created_run_id,
				current_timestamp()            							AS dw_created_dtm,
				'{{ invocation_id }}'          							AS dw_updated_run_id,
				current_timestamp()            							AS dw_updated_dtm    
        FROM combined_sightings AS  cs
    )
------------------------------

SELECT * FROM carmen_sightings

---------------------
-- Any triggers
---------------------

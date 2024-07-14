-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-- report d - behavior probabilities
-----------------------------------------------------------------------------------------------------

---------------------
-- Any config
---------------------


---------------------
-- CTE's
---------------------

WITH 
    carmen_sightings_all
    AS
    (
        SELECT 
                COUNT(*)                                                AS sightings_count,
                --cs.behavior											    AS behavior,
                cs.date_witness_month                                   AS date_witness_month
		FROM
				{{ ref ( 'fin_cs_sightings_all_cols' ) 	}} AS cs   
        GROUP BY cs.date_witness_month
    ), 
    common_behaviors
    AS
    (
        SELECT 
                cs.behavior
        FROM {{ ref ( 'anl_report_c_common_behaviours' ) }} AS cs  
    ),
    carmen_sightings
    AS
    (
        SELECT 
                COUNT(*)                                                AS sightings_count,
                --cs.behavior											    AS behavior,
                cs.date_witness_month                                   AS date_witness_month
		FROM
				{{ ref ( 'fin_cs_sightings_all_cols' ) 	}} AS cs   
        JOIN  common_behaviors AS cb
            ON cs.behavior = cb.behavior
        GROUP BY cs.date_witness_month
    ), 

    probability_percentage
    AS
    (
        SELECT 
                cs_all.date_witness_month                                                     AS date_witness_month,
                round(((cs.sightings_count / cs_all.sightings_count) * 100),2) || '%'         AS probability_percentage
        FROM   carmen_sightings      AS cs
        JOIN   carmen_sightings_all  AS cs_all
            ON cs.date_witness_month = cs_all.date_witness_month
    )


------------------------------

SELECT * FROM probability_percentage
order by date_witness_month



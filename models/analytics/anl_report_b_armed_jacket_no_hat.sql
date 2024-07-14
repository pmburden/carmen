-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-- report answers a - sightings per by armed/jacket/hat per month
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
                count(*)                                                AS sightings_count_all,
                cs.date_witness_month                                   AS date_witness_month
		FROM
				{{ ref ( 'fin_cs_sightings_all_cols' ) 	}} AS cs   
        GROUP BY cs.date_witness_month
    ),
    carmen_sightings
    AS
    (
        SELECT 
                count(*)                                                AS sightings_count,
                cs.date_witness_month                                   AS date_witness_month,
				--cs.has_weapon											AS has_weapon,
				--cs.has_hat											AS has_hat,
				--cs.has_jacket											AS has_jacket
		FROM
				{{ ref ( 'fin_cs_sightings_all_cols' ) 	}} AS cs   
        WHERE ((has_weapon AND has_jacket) AND NOT(has_hat))
        GROUP BY cs.date_witness_month
    ),
    probability_percentage
    AS
    (
        SELECT 
                cs_all.date_witness_month                                                         AS date_witness_month,
                round(((cs.sightings_count / cs_all.sightings_count_all) * 100),2) || '%'         AS probability_percentage
        FROM   carmen_sightings      AS cs
        JOIN   carmen_sightings_all  AS cs_all
            ON cs.date_witness_month = cs_all.date_witness_month
    )



------------------------------

SELECT * FROM probability_percentage
order by date_witness_month


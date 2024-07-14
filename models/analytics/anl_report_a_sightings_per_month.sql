-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-- report answers a - sightings per region by month
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
                COUNT(*)                                                AS sightings_count,
                cs.region											    AS region,
                cs.date_witness_month                                   AS date_witness_month
		FROM
				{{ ref ( 'fin_cs_sightings_all_cols' ) 	}} AS cs   
        GROUP BY cs.region, cs.date_witness_month
    ), 

    highest
    AS
    (
        SELECT 
                --MAX(sightings_count)                                  AS highest_count,
                RANK() OVER (PARTITION BY cs.date_witness_month 
                            ORDER BY sightings_count DESC)              AS row_rank,
                INITCAP(cs.region)										AS most_likely_region,
                cs.date_witness_month                                   AS date_witness_month
        FROM carmen_sightings AS CS
    ), 

    top_group
    AS
    (
        SELECT *
        FROM highest
        WHERE row_rank = 1    
    )


------------------------------

SELECT * exclude row_rank FROM top_group
order by date_witness_month

-----------------------------------------------------------------------------------------------------
-- Notes:   carmen sightings model 
-- report answers c - common behaviors
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
                count(*)                                                AS sightings_count,
                cs.behavior											    AS behavior
		FROM
				{{ ref ( 'fin_cs_sightings_all_cols' ) 	}} AS cs   
        GROUP BY cs.behavior
    ),
    highest
    AS
    (
        SELECT 
                cs.behavior                                             AS behavior,
                RANK() OVER (ORDER BY cs.sightings_count DESC)          AS ranking
        FROM carmen_sightings AS cs
    ),

    top_group
    AS
    (
        SELECT *
        FROM highest
        WHERE ranking <= 3    
    )


------------------------------

--exclude row_rank
SELECT *  FROM top_group
order by ranking


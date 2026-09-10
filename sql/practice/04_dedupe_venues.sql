DROP VIEW IF EXISTS V_VENUES_CLEAN;

CREATE VIEW V_VENUES_CLEAN AS
WITH RANKED AS (
    SELECT
        VENUE_ID,
        VENUE,
        CITY,
        ROW_NUMBER() OVER (
            PARTITION BY VENUE
            ORDER BY
                CASE
                    WHEN CITY IS NULL OR TRIM(CITY) = '' THEN 1
                    ELSE 0
                END,
                VENUE_ID
        ) AS RN
    FROM VENUES
)
SELECT VENUE_ID, VENUE, CITY
FROM RANKED
WHERE RN = 1;
-- Pour les 100 premières lignes
SELECT *
FROM (
    SELECT a.*, ROWNUM rn
    FROM as_ingredients a
    ORDER BY id
)
WHERE rn <= 50;

-- Pour les lignes 101 à 200 (ce que tu voulais)
SELECT *
FROM (
    SELECT a.*, ROWNUM rn
    FROM as_ingredients a
    ORDER BY id
)
WHERE rn > 100
  AND rn <= 200;

/* rediriger vers donnes.txt */
SPOOL /home/coralie/donnes.txt
SET PAGESIZE 0
SET LINESIZE 500
SET TRIMSPOOL ON
SET COLSEP ';'

SELECT *
FROM (
    SELECT a.*, ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM as_ingredients a
)
WHERE rn BETWEEN 101 AND 200;

SPOOL OFF


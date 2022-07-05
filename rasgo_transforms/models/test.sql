WITH cte1 AS (
    dateadd(source_table='rasgolocal.public.factinternetsales', date='orderdate', date_part='day', offset=7)
)
SELECT * FROM cte1
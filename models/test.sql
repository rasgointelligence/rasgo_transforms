
{{
cte(
  [
    'select * from rasgolocal.public.factinternetsales',
    dateadd(date='orderdate', date_part='day', offset=7),
    drop_columns(exclude_cols=['ORDERDATEKEY', 'SHIPDATEKEY', 'DUEDATEKEY'])
  ]
)
}}
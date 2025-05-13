{{ config(materialized="table") }}


with source_cte as (
    select 
        distinct issuername, 
        issuesymbolidentifier as trading_symbol from public.otc_securities_raw)

<<<<<<< HEAD
select row_number() over (order by issuername) as source_id, issuername as source_name
from source_cte
=======
select row_number() over (order by issuername) as source_id, issuername as source_name, trading_symbol
from source_cte
>>>>>>> 47b936023ccaf08a8bb45c81eb5fbe9392da0a4e

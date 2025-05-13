{{ config(materialized="table") }}


with source_cte as (
    select 
        distinct issuername, 
        issuesymbolidentifier as trading_symbol from public.otc_securities_raw)

select row_number() over (order by issuername) as source_id, issuername as source_name, trading_symbol
from source_cte
{{ config(materialized="table") }}

with
    source_cte as (
        select distinct upper(issuername) as source_name, issuesymbolidentifier as trading_symbol from public.otc_securities_raw
    )

select row_number() over (order by source_name) as source_id, source_name, trading_symbol
from source_cte
{{ config(materialized="table") }}


with trading_venue_cte as (
    select 
        distinct venue,
        SYMBOL from public.otc_data_raw)

select row_number() over (order by venue) as trading_venue_id, venue as trading_venue, symbol as trading_symbol
from trading_venue_cte
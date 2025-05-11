USE WAREHOUSE COMPUTE_WH;

{{ config(materialized="table") }}


with trading_venue_cte as (
    select distinct venue 
    from public.OTC_DATA_RAW
)

select 
    row_number() over (order by venue) as trading_venue_id, venue as trading_venue 
from trading_venue_cte

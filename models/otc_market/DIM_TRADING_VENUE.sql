{{ config(materialized="table") }}


with trading_venue_cte as (
    select 
        distinct venue,
        SYMBOL from public.otc_data_raw)

<<<<<<< HEAD
select row_number() over (order by venue) as trading_venue_id, venue as trading_venue
from trading_venue_cte
=======
select row_number() over (order by venue) as trading_venue_id, venue as trading_venue, symbol as trading_symbol
from trading_venue_cte
>>>>>>> 47b936023ccaf08a8bb45c81eb5fbe9392da0a4e

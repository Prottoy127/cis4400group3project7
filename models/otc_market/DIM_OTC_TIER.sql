{{ config(materialized="table") }}


with otc_tier_cte as (
    select 
        distinct tier,
        SYMBOL from public.otc_company_info_raw)

<<<<<<< HEAD
select row_number() over (order by tier) as otc_tier_id, tier as otc_tier
from otc_tier_cte
=======
select row_number() over (order by tier) as otc_tier_id, tier as otc_tier, symbol as trading_symbol
from otc_tier_cte
>>>>>>> 47b936023ccaf08a8bb45c81eb5fbe9392da0a4e

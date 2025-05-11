use warehouse compute_wh
;

{{ config(materialized="table") }}


with otc_tier_cte as (select distinct tier from public.otc_company_info_raw)

select row_number() over (order by tier) as otc_tier_id, tier as otc_tier
from otc_tier_cte
